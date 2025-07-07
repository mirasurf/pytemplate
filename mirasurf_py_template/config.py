"""
Configuration management for Mirasurf Python Template.

Provides configuration classes and utilities for managing library settings.
"""

from typing import Optional

from pydantic import BaseModel, Field, field_validator


class MirasurfConfig(BaseModel):
    """Main configuration class for Mirasurf."""

    enable_logging: bool = Field(default=True, description="Enable logging")
    log_level: str = Field(default="INFO", description="Logging level")
    max_processing_time: int = Field(default=30, description="Maximum processing time in seconds")

    @field_validator("max_processing_time")
    @classmethod
    def validate_max_processing_time(cls, v: int) -> int:
        """Validate that max_processing_time is positive."""
        if v <= 0:
            raise ValueError("max_processing_time must be positive")
        return v


def get_mirasurf_config() -> MirasurfConfig:
    """Get default Mirasurf configuration."""
    return MirasurfConfig()


def set_mirasurf_config(config: MirasurfConfig) -> None:
    """Set global Mirasurf configuration."""
    global _global_config
    _global_config = config


# Global configuration instance
_global_config: Optional[MirasurfConfig] = None
