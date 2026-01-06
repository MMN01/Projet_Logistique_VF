from __future__ import annotations
from dataclasses import dataclass
from typing import Any, Dict, Iterable, List, Optional, Tuple

@dataclass
class DbConfigLike:
    host: str
    port: int
    user: str
    password: str
    database: str

class Db:
    """
    Wrapper simple MySQL/MariaDB.
    - essaie mysql-connector-python
    - sinon essaie PyMySQL
    """
    def __init__(self, cfg: DbConfigLike):
        self.cfg = cfg
        self._driver = None
        self._conn = None

        try:
            import mysql.connector  # type: ignore
            self._driver = "mysql.connector"
            self._mysql = mysql.connector
        except Exception:
            import pymysql  # type: ignore
            self._driver = "pymysql"
            self._pymysql = pymysql

    def connect(self):
        if self._conn is not None:
            return
        if self._driver == "mysql.connector":
            self._conn = self._mysql.connect(
                host=self.cfg.host,
                port=self.cfg.port,
                user=self.cfg.user,
                password=self.cfg.password,
                database=self.cfg.database,
            )
        else:
            self._conn = self._pymysql.connect(
                host=self.cfg.host,
                port=self.cfg.port,
                user=self.cfg.user,
                password=self.cfg.password,
                database=self.cfg.database,
                cursorclass=self._pymysql.cursors.DictCursor,
                autocommit=False,
            )

    def close(self):
        if self._conn is not None:
            self._conn.close()
            self._conn = None

    def query(self, sql: str, params: Optional[Tuple[Any, ...]] = None) -> List[Dict[str, Any]]:
        self.connect()
        cur = self._conn.cursor(dictionary=True) if self._driver == "mysql.connector" else self._conn.cursor()
        cur.execute(sql, params or ())
        rows = cur.fetchall()
        cur.close()
        return rows if isinstance(rows, list) else list(rows)

    def execute(self, sql: str, params: Optional[Tuple[Any, ...]] = None) -> int:
        self.connect()
        cur = self._conn.cursor()
        cur.execute(sql, params or ())
        rowcount = cur.rowcount
        cur.close()
        self._conn.commit()
        return rowcount

    def get_table_columns(self, table: str) -> List[str]:
        rows = self.query(
            "SELECT COLUMN_NAME as c FROM information_schema.COLUMNS "
            "WHERE TABLE_SCHEMA=%s AND TABLE_NAME=%s",
            (self.cfg.database, table),
        )
        return [r["c"] for r in rows]