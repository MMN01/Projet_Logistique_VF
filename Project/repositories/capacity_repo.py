from typing import Optional
from services.db import Db

class CapacityRepo:
    def __init__(self, db: Db):
        self.db = db

    def get_capacity(self, ptac: str, palette_type: str) -> Optional[int]:
        palette_type = palette_type.upper()
        rows = self.db.query("SELECT * FROM trucks_capacity WHERE PTAC=%s LIMIT 1", (ptac.replace("t", ""),))
        if not rows:
            # certains dumps ont PTAC en '12' (varchar(3)) -> on essaie sans 't'
            rows = self.db.query("SELECT * FROM trucks_capacity WHERE PTAC=%s LIMIT 1", (ptac,))
        if not rows:
            return None
        r = rows[0]

        if palette_type == "EPAL":
            return int(r["EPAL"])
        if palette_type in ("EPALH", "EPAL(HALF)", "EPAL (HALF)"):
            # dans votre SQL: colonne "EPAL (half)"
            return int(r.get("EPAL (half)") or r.get("EPAL (HALF)") or r.get("EPAL_half") or 0)
        if palette_type == "ISO":
            return int(r["ISO"])
        return None