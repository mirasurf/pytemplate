"""
Mirasurf Python Template.

A minimal template project for building Python libraries.
"""

__version__ = "0.1.0"
__author__ = "Mirasurf Team"
__email__ = "team@mirasurf.com"

# Import main components
from .config import MirasurfConfig, get_mirasurf_config

__all__ = [
    "MirasurfConfig",
    "get_mirasurf_config",
    "set_mirasurf_config",
]
