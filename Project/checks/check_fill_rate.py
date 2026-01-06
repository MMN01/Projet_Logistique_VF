class FillRateCheck:
    def __init__(self, min_fill_rate_percent: float):
        self.min_fill = min_fill_rate_percent

    def run(self, fill_rate_percent: float) -> tuple[bool, str]:
        if fill_rate_percent < self.min_fill:
            return False, f"Remplissage trop faible ({fill_rate_percent:.1f}% < {self.min_fill}%)"
        return True, "OK"