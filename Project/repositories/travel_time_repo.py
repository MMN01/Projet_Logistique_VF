from typing import Optional
from services.db import Db

class TravelTimeRepo:
    def __init__(self, db: Db):
        self.db = db

    def get_travel_hours(self, loc_a_pk: int, loc_b_pk: int) -> Optional[float]:
        if loc_a_pk == loc_b_pk:
            return 0.0
        lo, hi = sorted([loc_a_pk, loc_b_pk])

        # table triangulaire supérieure => on lit ligne FK_LOCATIONS=lo, colonne "hi"
        rows = self.db.query("SELECT * FROM travel_time_matrix WHERE FK_LOCATIONS=%s LIMIT 1", (lo,))
        if not rows:
            return None
        r = rows[0]
        key = str(hi)
        v = r.get(key)
        if v is None:
            # parfois c'est l'autre triangle (selon vos dumps)
            rows2 = self.db.query("SELECT * FROM travel_time_matrix WHERE FK_LOCATIONS=%s LIMIT 1", (hi,))
            if not rows2:
                return None
            v = rows2[0].get(str(lo))
        return float(v) if v is not None else None