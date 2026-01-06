from datetime import datetime
from models.demand import TransportRequest
from models.feasibility import (
    FeasibilityResult,
    REASON_OK, REASON_NO_TRUCK, REASON_NO_SUITABLE_TRUCK,
    REASON_PORT_UNAVAILABLE, REASON_FILL_TOO_LOW, REASON_REGULATION, REASON_EXPIRED
)
from services.spec_parser import parse_spec
from repositories.locations_repo import LocationsRepo
from repositories.travel_time_repo import TravelTimeRepo
from checks.check_truck_availability import TruckAvailabilityCheck
from checks.check_demand_lifetime import DemandLifetimeCheck
from checks.check_port_availability import PortAvailabilityCheck
from checks.check_fill_rate import FillRateCheck
from checks.check_regulation import RegulationCheck

class FeasibilityEngine:
    def __init__(
        self,
        locations: LocationsRepo,
        travel: TravelTimeRepo,
        check_truck: TruckAvailabilityCheck,
        check_life: DemandLifetimeCheck,
        check_port: PortAvailabilityCheck,
        check_fill: FillRateCheck,
        check_reg: RegulationCheck,
    ):
        self.locations = locations
        self.travel = travel
        self.check_truck = check_truck
        self.check_life = check_life
        self.check_port = check_port
        self.check_fill = check_fill
        self.check_reg = check_reg

    def evaluate(self, req: TransportRequest) -> FeasibilityResult:
        now = datetime.now()
        specs = parse_spec(req.spec, req.needs_refrigeration)

        dep = self.locations.get_location(req.loc_dep)
        arr = self.locations.get_location(req.loc_arr)
        if dep is None or arr is None:
            return FeasibilityResult(req.request_id, False, REASON_NO_SUITABLE_TRUCK, "Localisation inconnue", now)

        dep_pk, dep_name, dep_country = dep
        arr_pk, arr_name, arr_country = arr

        # Travel time (utile pour port forecast + règlementation)
        travel_h = self.travel.get_travel_hours(dep_pk, arr_pk)

        # 2) Lifetime
        ok, msg = self.check_life.run(req)
        if not ok:
            return FeasibilityResult(req.request_id, False, REASON_EXPIRED, msg, now, travel_hours=travel_h)

        # 1) Truck availability (si départ = USINE, sinon pour Import: départ=PORT -> on choisit camion dans usine d'arrivée)
        factory_pk = dep_pk if req.type_dep.upper() == "USINE" else arr_pk
        ok, selection, msg = self.check_truck.run(req, factory_pk, specs)
        if not ok or selection is None:
            code = REASON_NO_TRUCK if "Aucun camion" in msg else REASON_NO_SUITABLE_TRUCK
            return FeasibilityResult(req.request_id, False, code, msg, now, travel_hours=travel_h)

        # 4) Fill rate threshold
        ok, msg = self.check_fill.run(selection.fill_rate_percent)
        if not ok:
            return FeasibilityResult(
                req.request_id, False, REASON_FILL_TOO_LOW, msg, now,
                truck=selection.truck, fill_rate_percent=selection.fill_rate_percent, travel_hours=travel_h
            )

        # 3) Port availability (seulement si ARRIVE au PORT)
        port_pct = None
        if req.type_arr.upper() == "PORT":
            ok, port_pct, msg = self.check_port.run(req, arr_pk, travel_h)
            if not ok:
                return FeasibilityResult(
                    req.request_id, False, REASON_PORT_UNAVAILABLE, msg, now,
                    truck=selection.truck, fill_rate_percent=selection.fill_rate_percent,
                    travel_hours=travel_h, port_availability_percent=port_pct
                )

        # 5) Regulation
        ok, pauses_min, msg = self.check_reg.run(travel_h if travel_h is not None else None)
        if not ok:
            return FeasibilityResult(
                req.request_id, False, REASON_REGULATION, msg, now,
                truck=selection.truck, fill_rate_percent=selection.fill_rate_percent,
                travel_hours=travel_h, port_availability_percent=port_pct
            )

        return FeasibilityResult(
            req.request_id, True, REASON_OK, "Acceptée", now,
            truck=selection.truck, fill_rate_percent=selection.fill_rate_percent,
            travel_hours=travel_h, port_availability_percent=port_pct
        )