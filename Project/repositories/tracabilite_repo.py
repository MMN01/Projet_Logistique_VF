from __future__ import annotations
from typing import Any, Dict, Optional
from services.db import Db

class TracabiliteRepo:
    def __init__(self, db: Db):
        self.db = db
        self._cols = set(db.get_table_columns("tracabilite"))

    def insert_or_update(self, row: dict) -> None:
        clean = {k: v for k, v in row.items() if k in self._cols}
        if not clean:
            return

        cols = list(clean.keys())
        placeholders = ", ".join(["%s"] * len(cols))
        col_sql = ", ".join(f"`{c}`" for c in cols)

        # on met à jour tout sauf la PK
        updates = [c for c in cols if c != "ID_Demande"]
        update_sql = ", ".join([f"`{c}`=VALUES(`{c}`)" for c in updates]) if updates else ""

        sql = f"INSERT INTO tracabilite ({col_sql}) VALUES ({placeholders})"
        if update_sql:
            sql += f" ON DUPLICATE KEY UPDATE {update_sql}"

        self.db.execute(sql, tuple(clean[c] for c in cols))