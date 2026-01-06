from dataclasses import dataclass

@dataclass(frozen=True)
class UdpConfig:
    host_emetteur: str = "192.168.40.100"  # ou votre faux serveur
    port: int = 40040

@dataclass(frozen=True)
class DbConfig:
    host: str = "127.0.0.1"
    port: int = 3306
    user: str = "root"
    password: str = ""
    database: str = "logistics"

@dataclass(frozen=True)
class FeasibilityConfig:
    # 2) Date de vie demande
    max_processing_seconds: int = 15 * 60  # si vous voulez refuser après 15 min sans traiter
    reject_if_deadline_passed: bool = True

    # 3) Port dispo
    port_threshold_percent: float = 95.0   # >95%
    port_use_forecast: bool = True         # si True: utilise T0/T+4/T+8 selon ETA

    # 4) Taux remplissage
    min_fill_rate_percent: float = 59.7

    # 5) Règlementation (valeurs “projet” configurables)
    max_daily_driving_hours: float = 9.0          # ex: 9h
    max_continuous_driving_hours: float = 4.5     # pause obligatoire
    break_minutes: int = 45
    carence_minutes: int = 0