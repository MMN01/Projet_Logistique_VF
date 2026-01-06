import math

class RegulationCheck:
    def __init__(
        self,
        max_daily_driving_hours: float,
        max_continuous_driving_hours: float,
        break_minutes: int,
        carence_minutes: int = 0,
    ):
        self.max_daily = max_daily_driving_hours
        self.max_cont = max_continuous_driving_hours
        self.break_minutes = break_minutes
        self.carence_minutes = carence_minutes

    def compute_breaks_minutes(self, driving_hours: float) -> int:
        if driving_hours <= self.max_cont:
            return 0
        # nb de segments de max_cont => nb pauses = segments - 1
        segments = math.ceil(driving_hours / self.max_cont)
        pauses = max(0, segments - 1)
        return pauses * self.break_minutes

    def run(self, driving_hours: float) -> tuple[bool, int, str]:
        if driving_hours is None:
            return False, 0, "Temps de trajet inconnu (matrice)"

        if driving_hours > self.max_daily:
            return False, 0, f"Contrainte: durée de conduite > {self.max_daily}h"

        pauses = self.compute_breaks_minutes(driving_hours)
        # carence: ici on ne peut pas vérifier sans planning chauffeur => on expose juste le param
        return True, pauses, "OK"