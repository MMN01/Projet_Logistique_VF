from datetime import datetime
from models.demand import TransportRequest

class DemandLifetimeCheck:
    def __init__(self, max_processing_seconds: int, reject_if_deadline_passed: bool = True):
        self.max_processing_seconds = max_processing_seconds
        self.reject_if_deadline_passed = reject_if_deadline_passed

    def run(self, req: TransportRequest) -> tuple[bool, str]:
        now = datetime.now()

        # 2a) délai de traitement max (si vous l'utilisez)
        age = (now - req.received_at).total_seconds()
        if self.max_processing_seconds > 0 and age > self.max_processing_seconds:
            return False, "Temps de traitement dépassé"

        # 2b) deadline H_DEP
        if self.reject_if_deadline_passed and now > req.h_dep:
            return False, "Deadline H_DEP dépassée (demande expirée)"

        return True, "OK"