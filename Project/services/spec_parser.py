from models.specs import SpecConstraints

def _normalize_energy(v: str) -> str:
    v = v.strip().lower()
    mapping = {
        "electric": "Electrique",
        "electrique": "Electrique",
        "diesel": "Diesel",
        "gazole": "Diesel",
        "essence": "Essence",
        "gasoline": "Essence",
        "gpl": "GPL",
        "lpg": "GPL",
        "hydrogen": "Hydrogene",
        "hydrogene": "Hydrogene",
    }
    return mapping.get(v, v.capitalize())

def parse_spec(spec: str, needs_refrigeration: bool) -> SpecConstraints:
    """
    SPEC: "PTAC=12t, COL=Red, ENR=Electric" (exemples ERP)
    """
    c = SpecConstraints()
    if needs_refrigeration:
        c.refrigerated = True

    if not spec:
        return c

    parts = [p.strip() for p in spec.split(",") if p.strip()]
    for p in parts:
        if "=" not in p:
            continue
        k, v = [x.strip() for x in p.split("=", 1)]
        k = k.upper()
        if k == "PTAC":
            c.ptac = v
        elif k in ("ENR", "ENER", "ENERGIE", "ENERGY"):
            c.energy = _normalize_energy(v)
        elif k in ("COL", "COUL", "COULEUR", "COLOR"):
            c.color = v.capitalize()
        elif k in ("FRIGO", "REFRIGERE", "REFRIGEREE"):
            c.refrigerated = v.strip().lower() in ("1", "true", "oui", "yes")
    return c