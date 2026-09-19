"""
helpers.py
Reusable utility functions for data processing, math operations,
file handling, and random generation.
"""

import os
import json
import random
from datetime import datetime
from typing import List, Dict, Any

# -----------------------------
# Math Utilities
# -----------------------------

def mean(values: List[float]) -> float:
    if not values:
        raise ValueError("List is empty")
    return sum(values) / len(values)

def median(values: List[float]) -> float:
    if not values:
        raise ValueError("List is empty")
    sorted_vals = sorted(values)
    n = len(sorted_vals)
    mid = n // 2
    return sorted_vals[mid] if n % 2 == 1 else (sorted_vals[mid - 1] + sorted_vals[mid]) / 2

def clamp(value: float, min_val: float, max_val: float) -> float:
    return max(min_val, min(value, max_val))

# -----------------------------
# File Utilities
# -----------------------------

def read_json(path: str) -> Dict[str, Any]:
    if not os.path.exists(path):
        raise FileNotFoundError(f"File not found: {path}")
    with open(path, "r") as f:
        return json.load(f)

def write_json(path: str, data: Dict[str, Any]) -> None:
    with open(path, "w") as f:
        json.dump(data, f, indent=4)

def list_files(directory: str) -> List[str]:
    if not os.path.isdir(directory):
        raise NotADirectoryError(f"Not a directory: {directory}")
    return [f for f in os.listdir(directory) if os.path.isfile(os.path.join(directory, f))]

# -----------------------------
# Random Utilities
# -----------------------------

def random_int(low: int, high: int) -> int:
    return random.randint(low, high)

def random_choice(items: List[Any]) -> Any:
    if not items:
        raise ValueError("List is empty")
    return random.choice(items)

def random_sample(items: List[Any], k: int) -> List[Any]:
    if k > len(items):
        raise ValueError("Sample size exceeds list length")
    return random.sample(items, k)

# -----------------------------
# Date & Time Utilities
# -----------------------------

def timestamp() -> str:
    return datetime.now().strftime("%Y-%m-%d %H:%M:%S")

def days_between(date1: str, date2: str) -> int:
    d1 = datetime.strptime(date1, "%Y-%m-%d")
    d2 = datetime.strptime(date2, "%Y-%m-%d")
    return abs((d2 - d1).days)

