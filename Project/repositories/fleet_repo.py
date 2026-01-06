from typing import List, Optional, Tuple
from models.truck import Truck
from services.db import Db

class FleetRepo:
    def __init__(self, db: Db):
        self.db = db

    def get_reference_range_for_factory(self, factory_loc_pk: int) -> Optional[Tuple[int, int]]:
        rows = self.db.query(
            "SELECT REF_L, REF_H FROM assigned_trucks WHERE FK_LOCATIONS=%s LIMIT 1",
            (factory_loc_pk,),
        )
        if not rows:
            return None
        return int(rows[0]["REF_L"]), int(rows[0]["REF_H"])

    def get_trucks_by_reference_range(self, ref_l: int, ref_h: int) -> List[Truck]:
        rows = self.db.query(
            "SELECT PK_TRUCK, REFERENCE, IMMAT, DATE_MEC, VIN, CH, ENERGIE, PTAC, REMORQUE_REFRIGEREE, COULEUR "
            "FROM trucks WHERE REFERENCE BETWEEN %s AND %s",
            (ref_l, ref_h),
        )
        trucks: List[Truck] = []
        for r in rows:
            trucks.append(
                Truck(
                    id=int(r["PK_TRUCK"]),
                    reference=int(r["REFERENCE"]),
                    immat=str(r["IMMAT"]),
                    date_mec=None,
                    vin=str(r["VIN"]) if r["VIN"] else None,
                    power_ch=int(r["CH"]) if r["CH"] is not None else None,
                    energy=str(r["ENERGIE"]) if r["ENERGIE"] else None,
                    ptac=str(r["PTAC"]) if r["PTAC"] else None,
                    refrigerated=bool(r["REMORQUE_REFRIGEREE"]),
                    color=str(r["COULEUR"]) if r["COULEUR"] else None,
                )
            )
        return trucks