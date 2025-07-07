"""
Integration tests for Mirasurf Python Template.

These tests require a PostgreSQL database running via docker-compose.
"""

import os
import pytest
import psycopg2
from mirasurf_py_template.config import MirasurfConfig


@pytest.mark.integration
class TestDatabaseIntegration:
    """Integration tests with PostgreSQL database."""

    def test_database_connection(self):
        """Test connection to PostgreSQL database."""
        # Get database connection details from environment
        db_host = os.getenv("POSTGRES_HOST", "localhost")
        db_port = os.getenv("POSTGRES_PORT", "5432")
        db_name = os.getenv("POSTGRES_DB", "test_db")
        db_user = os.getenv("POSTGRES_USER", "test_user")
        db_password = os.getenv("POSTGRES_PASSWORD", "test_password")
        
        # Test connection
        conn = psycopg2.connect(
            host=db_host,
            port=db_port,
            database=db_name,
            user=db_user,
            password=db_password
        )
        
        assert conn is not None
        
        # Test basic query
        cursor = conn.cursor()
        cursor.execute("SELECT version();")
        result = cursor.fetchone()
        
        assert result is not None
        assert "PostgreSQL" in result[0]
        
        cursor.close()
        conn.close()

    def test_config_with_database(self):
        """Test configuration works with database integration."""
        config = MirasurfConfig(
            enable_logging=True,
            log_level="DEBUG",
            max_processing_time=60
        )
        
        # Verify config is valid for database operations
        assert config.max_processing_time > 0
        
        # Test that we can use the config in a database context
        db_host = os.getenv("POSTGRES_HOST", "localhost")
        db_name = os.getenv("POSTGRES_DB", "test_db")
        
        # This would typically be used to configure database connections
        # For now, just verify the config is suitable
        assert config.enable_logging is True
        assert config.log_level == "DEBUG"


@pytest.mark.integration
class TestEndToEndIntegration:
    """End-to-end integration tests."""

    def test_full_workflow(self):
        """Test a complete workflow with configuration and database."""
        # 1. Create configuration
        config = MirasurfConfig(
            enable_logging=True,
            log_level="INFO",
            max_processing_time=30
        )
        
        # 2. Verify configuration
        assert config.enable_logging is True
        
        # 3. Test database connectivity (if available)
        try:
            db_host = os.getenv("POSTGRES_HOST", "localhost")
            db_port = os.getenv("POSTGRES_PORT", "5432")
            db_name = os.getenv("POSTGRES_DB", "test_db")
            db_user = os.getenv("POSTGRES_USER", "test_user")
            db_password = os.getenv("POSTGRES_PASSWORD", "test_password")
            
            conn = psycopg2.connect(
                host=db_host,
                port=db_port,
                database=db_name,
                user=db_user,
                password=db_password
            )
            
            # Test a simple table creation and query
            cursor = conn.cursor()
            cursor.execute("""
                CREATE TABLE IF NOT EXISTS test_config (
                    id SERIAL PRIMARY KEY,
                    config_name VARCHAR(100),
                    config_value TEXT,
                    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
                )
            """)
            
            # Insert test data
            cursor.execute("""
                INSERT INTO test_config (config_name, config_value)
                VALUES (%s, %s)
            """, ("test_config", str(config.dict())))
            
            # Query the data
            cursor.execute("SELECT config_name, config_value FROM test_config WHERE config_name = %s", ("test_config",))
            result = cursor.fetchone()
            
            assert result is not None
            assert result[0] == "test_config"
            assert "enable_logging" in result[1]
            
            # Cleanup
            cursor.execute("DELETE FROM test_config WHERE config_name = %s", ("test_config",))
            conn.commit()
            
            cursor.close()
            conn.close()
            
        except psycopg2.OperationalError:
            # Database not available, skip this part of the test
            pytest.skip("PostgreSQL database not available for integration test") 