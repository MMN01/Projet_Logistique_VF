import socket
import json
from datetime import datetime
from config import UdpConfig, DbConfig, FeasibilityConfig
from services.db import Db
from repositories.locations_repo import LocationsRepo
from repositories.fleet_repo import FleetRepo
from repositories.capacity_repo import CapacityRepo
from repositories.ports_repo import PortsRepo
from repositories.travel_time_repo import TravelTimeRepo
from repositories.tracabilite_repo import TracabiliteRepo
from checks.check_truck_availability import TruckAvailabilityCheck
from checks.check_demand_lifetime import DemandLifetimeCheck
from checks.check_port_availability import PortAvailabilityCheck
from checks.check_fill_rate import FillRateCheck
from checks.check_regulation import RegulationCheck
from services.feasibility_engine import FeasibilityEngine
from models.demand import TransportRequest

def normalize_type_mat_to_columns(type_mat: str, qte_pal: int) -> dict:
    tm = type_mat.lower().replace(" ", "_")
    out = {"QTE_MP": 0.0, "QTE_MP_FRAIS": 0.0, "QTE_PF": 0.0, "QTE_PF_FRAIS": 0.0}
    if "mp" in tm and "frais" in tm:
        out["QTE_MP_FRAIS"] = float(qte_pal)
    elif tm == "mp":
        out["QTE_MP"] = float(qte_pal)
    elif "pf" in tm and "frais" in tm:
        out["QTE_PF_FRAIS"] = float(qte_pal)
    elif "pf" in tm:
        out["QTE_PF"] = float(qte_pal)
    return out

def palette_to_columns(type_pal: str, qte: int) -> dict:
    tp = type_pal.upper()
    return {
        "QTE_EPAL": qte if tp == "EPAL" else 0,
        "QTE_EPALh": qte if tp == "EPALH" else 0,
        "QTE_ISO": qte if tp == "ISO" else 0,
    }

def main():
    udp_cfg = UdpConfig()
    db_cfg = DbConfig()
    feas_cfg = FeasibilityConfig()

    # DB + repos
    db = Db(db_cfg)
    locations = LocationsRepo(db)
    fleet = FleetRepo(db)
    capacity = CapacityRepo(db)
    ports = PortsRepo(db)
    travel = TravelTimeRepo(db)
    trace_repo = TracabiliteRepo(db)

    # checks
    check_truck = TruckAvailabilityCheck(fleet, capacity)
    check_life = DemandLifetimeCheck(feas_cfg.max_processing_seconds, feas_cfg.reject_if_deadline_passed)
    check_port = PortAvailabilityCheck(ports, feas_cfg.port_threshold_percent, feas_cfg.port_use_forecast)
    check_fill = FillRateCheck(feas_cfg.min_fill_rate_percent)
    check_reg = RegulationCheck(
        feas_cfg.max_daily_driving_hours,
        feas_cfg.max_continuous_driving_hours,
        feas_cfg.break_minutes,
        feas_cfg.carence_minutes,
    )

    engine = FeasibilityEngine(
        locations=locations,
        travel=travel,
        check_truck=check_truck,
        check_life=check_life,
        check_port=check_port,
        check_fill=check_fill,
        check_reg=check_reg,
    )

    # UDP listener (broadcast)
    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    try:
        sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEPORT, 1)
    except AttributeError:
        sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    sock.setsockopt(socket.SOL_SOCKET, socket.SO_BROADCAST, 1)
    sock.bind(("", udp_cfg.port))

    print(f"[WEST] UDP listener ON (port={udp_cfg.port})")

    while True:
        data, addr = sock.recvfrom(4096)
        received_at = datetime.now()

        raw = data.decode("utf-8").replace("'", '"')
        try:
            msg = json.loads(raw)
        except Exception as e:
            print("JSON invalide:", e, raw)
            continue

        # msg = { "ID1": {..}, "ID2": {..} }
        for req_id, payload in msg.items():
            try:
                req = TransportRequest.from_erp(req_id, payload, received_at=received_at)
                res = engine.evaluate(req)

                dep = locations.get_location(req.loc_dep)
                arr = locations.get_location(req.loc_arr)
                dep_name, dep_country = (dep[1], dep[2]) if dep else (req.loc_dep, None)
                arr_name, arr_country = (arr[1], arr[2]) if arr else (req.loc_arr, None)

                # Build row for tracabilite (auto-filtré par TracabiliteRepo)
                row = {
                    "ID_Demande": req.request_id,  # obligatoire (PK)
                    "Statut_Demande": 1 if res.accepted else 0,
                    "Raison_Refus": None if res.accepted else int(res.reason_code),

                    "Type_Mouvement": req.type_mvt,
                    "Loc_Dep": req.loc_dep,
                    "Loc_Arrive": req.loc_arr,

                    "Quantité_Palette": req.qte_pal,
                    "Taux_Remplissage": float(res.fill_rate_percent) if res.fill_rate_percent is not None else None,

                    "Date_Demande": req.received_at.strftime("%d-%m-%Y"),
                    "Heure_Demande": req.received_at.strftime("%H:%M:%S"),
                }

                row.update(normalize_type_mat_to_columns(req.type_mat, req.qte_pal))
                row.update(palette_to_columns(req.type_pal, req.qte_pal))

                if res.truck is not None:
                    row.update({
                        "VIN_TRUCK": int(res.truck.reference),   # VIN_TRUCK est int(11) dans votre SQL
                        "TRUCK_PTAC": res.truck.ptac,
                    })

                trace_repo.insert_or_update(row)

                print(f"[{req_id}] accepted={res.accepted} reason={res.reason_code} ({res.reason_label})")

            except Exception as e:
                print(f"[{req_id}] ERREUR traitement:", e)

if __name__ == "__main__":
    main()