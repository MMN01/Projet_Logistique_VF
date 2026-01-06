from dataclasses import dataclass
from typing import Optional, Tuple, List
from models.demand import TransportRequest
from models.truck import Truck
from models.specs import SpecConstraints
from repositories.fleet_repo import FleetRepo
from repositories.capacity_repo import CapacityRepo

@dataclass
class TruckSelection:
    truck: Truck
    capacity: int
    fill_rate_percent: float

class TruckAvailabilityCheck:
    def __init__(self, fleet: FleetRepo, capacity_repo: CapacityRepo):
        self.fleet = fleet
        self.capacity_repo = capacity_repo

    def run(
        self,
        req: TransportRequest,
        dep_factory_loc_pk: int,
        specs: SpecConstraints,
    ) -> Tuple[bool, Optional[TruckSelection], str]:
        rr = self.fleet.get_reference_range_for_factory(dep_factory_loc_pk)
        if rr is None:
            return False, None, "Aucun camion assigné à cette usine"

        ref_l, ref_h = rr
        trucks = self.fleet.get_trucks_by_reference_range(ref_l, ref_h)
        if not trucks:
            return False, None, "Aucun camion disponible dans l'usine"

        candidates: List[Truck] = []
        for t in trucks:
            if specs.ptac and (t.ptac != specs.ptac):
                continue
            if specs.energy and (t.energy is None or t.energy.lower() != specs.energy.lower()):
                continue
            if specs.color and (t.color is None or t.color.lower() != specs.color.lower()):
                continue
            if specs.refrigerated is True and not t.refrigerated:
                continue
            candidates.append(t)

        if not candidates:
            return False, None, "Camion adapté indisponible (SPEC / frigo / énergie / couleur / PTAC)"

        # capacité + remplissage (sans seuil ici, juste calcul)
        best: Optional[TruckSelection] = None
        for t in candidates:
            if not t.ptac:
                continue
            cap = self.capacity_repo.get_capacity(t.ptac, req.type_pal)
            if not cap or cap <= 0:
                continue
            if req.qte_pal > cap:
                continue
            fill = (req.qte_pal / cap) * 100.0
            sel = TruckSelection(t, cap, fill)
            # choix simple : meilleur remplissage
            if best is None or sel.fill_rate_percent > best.fill_rate_percent:
                best = sel

        if best is None:
            return False, None, "Aucun camion avec capacité suffisante pour la demande"

        return True, best, "OK"