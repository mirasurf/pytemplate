"""
Unit tests for configuration management.
"""

import pytest
from mirasurf_py_template.config import MirasurfConfig, get_mirasurf_config


class TestMirasurfConfig:
    """Test cases for MirasurfConfig class."""

    def test_default_config(self):
        """Test default configuration values."""
        config = MirasurfConfig()
        
        assert config.enable_logging is True
        assert config.log_level == "INFO"
        assert config.max_processing_time == 30

    def test_custom_config(self):
        """Test custom configuration values."""
        config = MirasurfConfig(
            enable_logging=False,
            log_level="DEBUG",
            max_processing_time=60
        )
        
        assert config.enable_logging is False
        assert config.log_level == "DEBUG"
        assert config.max_processing_time == 60

    def test_config_validation(self):
        """Test configuration validation."""
        # Test with valid values
        config = MirasurfConfig(log_level="WARNING")
        assert config.log_level == "WARNING"
        
        # Test with invalid values (should raise validation error)
        with pytest.raises(ValueError):
            MirasurfConfig(max_processing_time=-1)


class TestConfigFunctions:
    """Test cases for configuration utility functions."""

    def test_get_mirasurf_config(self):
        """Test get_mirasurf_config function."""
        config = get_mirasurf_config()
        
        assert isinstance(config, MirasurfConfig)
        assert config.enable_logging is True
        assert config.log_level == "INFO"
        assert config.max_processing_time == 30 