# Mirasurf Python Template

A minimal template project for building Python libraries with modern development practices.

## Features

- **Python 3.11+** support
- **Pydantic** for data validation and configuration
- **Modern tooling**: pytest, black, isort, mypy
- **Integration testing** with PostgreSQL
- **Docker Compose** for development environment

## Quick Start

### Installation

```bash
# Clone the repository
git clone https://github.com/mirasurf/mirasurf-py-template.git
cd mirasurf-py-template

# Install in development mode
pip install -e ".[dev,test]"
```

### Basic Usage

```python
from mirasurf_py_template import MirasurfConfig, get_mirasurf_config

# Create a custom configuration
config = MirasurfConfig(
    enable_logging=True,
    log_level="DEBUG",
    enable_validation=True,
    enable_transformation=True,
    max_processing_time=60
)

# Or use default configuration
default_config = get_mirasurf_config()
```

## Development

### Running Tests

```bash
# Unit tests only
pytest tests/ -v

# Integration tests (requires PostgreSQL)
docker-compose up -d postgres
pytest tests/ -m integration -v

# All tests with coverage
pytest tests/ --cov=mirasurf_py_template --cov-report=html
```

### Code Quality

```bash
# Format code
black mirasurf_py_template/ tests/
isort mirasurf_py_template/ tests/

# Type checking
mypy mirasurf_py_template/

# Lint with pre-commit
pre-commit run --all-files
```

### Building

```bash
# Build package
python -m build

# Install from built package
pip install dist/*.whl
```

## Project Structure

```
mirasurf-py-template/
├── mirasurf_py_template/     # Main package
│   ├── __init__.py          # Package exports
│   └── config.py            # Configuration management
├── tests/                   # Test suite
│   ├── test_config.py       # Unit tests
│   └── test_integration.py  # Integration tests
├── docker-compose.yml       # Development environment
├── pyproject.toml          # Project configuration
└── README.md               # This file
```

## Configuration

The template provides a simple configuration system using Pydantic:

- `enable_logging`: Enable/disable logging
- `log_level`: Logging level (INFO, DEBUG, WARNING, ERROR)
- `enable_validation`: Enable data validation
- `enable_transformation`: Enable data transformation
- `max_processing_time`: Maximum processing time in seconds

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Run the test suite
6. Submit a pull request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details. 