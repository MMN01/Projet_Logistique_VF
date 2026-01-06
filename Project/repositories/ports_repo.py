from typing import Optional, Tuple
from services.db import Db

class PortsRepo:
    def __init__(self, db: Db):
        self.db = db

    def get_availability(self, port_loc_pk: int) -> Optional[Tuple[float, float, float]]:
        rows = self.db.query(
            "SELECT `AVAILABILITY_T0` as t0, `AVAILABILITY_T+4` as t4, `AVAILABILITY_T+8` as t8 "
            "FROM ports_availability WHERE FK_LOCATIONS=%s LIMIT 1",
            (port_loc_pk,),
        )
        if not rows:
            return None
        r = rows[0]
        t0 = float(r["t0"]) if r["t0"] is not None else 0.0
        t4 = float(r["t4"]) if r["t4"] is not None else t0
        t8 = float(r["t8"]) if r["t8"] is not None else t4
        return t0, t4, t8