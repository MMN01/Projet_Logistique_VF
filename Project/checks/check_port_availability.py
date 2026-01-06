from typing import Optional
from models.demand import TransportRequest
from repositories.ports_repo import PortsRepo

class PortAvailabilityCheck:
    def __init__(self, ports_repo: PortsRepo, threshold_percent: float, use_forecast: bool = True):
        self.ports_repo = ports_repo
        self.threshold = threshold_percent
        self.use_forecast = use_forecast

    @staticmethod
    def _to_percent(x: float) -> float:
        # robustesse: si la BDD stocke 0..1 au lieu de 0..100
        return x * 100.0 if x <= 1.5 else x

    def run(self, req: TransportRequest, port_loc_pk: int, eta_hours: Optional[float]) -> tuple[bool, float, str]:
        av = self.ports_repo.get_availability(port_loc_pk)
        if av is None:
            return False, 0.0, "Port non trouvé en base"

        t0, t4, t8 = av
        # choix horizon
        chosen = t0
        if self.use_forecast and eta_hours is not None:
            if eta_hours <= 4:
                chosen = t4  # vous pouvez préférer T0 ici, à vous de voir
            else:
                chosen = t8

        chosen_pct = self._to_percent(float(chosen))
        if chosen_pct < self.threshold:
            return False, chosen_pct, f"Port indisponible ({chosen_pct:.1f}% < {self.threshold}%)"
        return True, chosen_pct, "OK"