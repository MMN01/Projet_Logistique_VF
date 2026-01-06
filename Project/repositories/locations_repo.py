from typing import Optional, Tuple
from services.db import Db

class LocationsRepo:
    def __init__(self, db: Db):
        self.db = db

    def get_location(self, name: str) -> Optional[Tuple[int, str, str]]:
        rows = self.db.query(
            "SELECT PK_LOCATIONS, NAME, COUNTRY FROM locations_names WHERE NAME=%s LIMIT 1",
            (name,),
        )
        if not rows:
            return None
        r = rows[0]
        return int(r["PK_LOCATIONS"]), str(r["NAME"]), str(r["COUNTRY"])