from dataclasses import dataclass
from datetime import datetime
from typing import Optional
from models.truck import Truck

# Codes (vous pouvez adapter à votre tableau)
REASON_OK = 100
REASON_NO_TRUCK = 200
REASON_NO_SUITABLE_TRUCK = 300
REASON_PORT_UNAVAILABLE = 400
REASON_FILL_TOO_LOW = 500
REASON_REGULATION = 550
REASON_EXPIRED = 700

@dataclass
class FeasibilityResult:
    request_id: str
    accepted: bool
    reason_code: int
    reason_label: str
    accepted_at: datetime
    truck: Optional[Truck] = None
    fill_rate_percent: Optional[float] = None
    travel_hours: Optional[float] = None
    port_availability_percent: Optional[float] = None