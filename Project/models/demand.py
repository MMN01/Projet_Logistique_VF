from __future__ import annotations
from dataclasses import dataclass
from datetime import datetime
from typing import Any, Dict, Optional

ERP_DT_FMT = "%d/%m/%y %H:%M:%S"

@dataclass
class TransportRequest:
    request_id: str
    type_mvt: str
    loc_dep: str
    loc_arr: str
    type_dep: str
    type_arr: str
    type_mat: str
    qte_pal: int
    type_pal: str
    h_dep: datetime
    spec: str
    received_at: datetime

    @staticmethod
    def from_erp(request_id: str, payload: Dict[str, Any], received_at: Optional[datetime] = None) -> "TransportRequest":
        received_at = received_at or datetime.now()
        h_dep = datetime.strptime(payload["H_DEP"], ERP_DT_FMT)
        return TransportRequest(
            request_id=request_id,
            type_mvt=str(payload["TYPE_MVT"]),
            loc_dep=str(payload["LOC_DEP"]),
            loc_arr=str(payload["LOC_ARR"]),
            type_dep=str(payload["TYPE_DEP"]),
            type_arr=str(payload["TYPE_ARR"]),
            type_mat=str(payload["TYPE_MAT"]),
            qte_pal=int(payload["QTE_PAL"]),
            type_pal=str(payload["TYPE_PAL"]),
            h_dep=h_dep,
            spec=str(payload.get("SPEC", "")),
            received_at=received_at,
        )

    @property
    def needs_refrigeration(self) -> bool:
        # convention simple: Frais => frigo
        return "frais" in self.type_mat.lower()