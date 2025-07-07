# Mirasurf Python Template

A minimal, production-ready template for building Python libraries with modern development practices.

## 🚀 Quick Start

```bash
# Clone and customize
git clone https://github.com/mirasurf/mirasurf-py-template.git my-library
cd my-library

# Install development dependencies
pip install -e ".[dev]"

# Run tests
make test
```

## ✨ Features

- **Python 3.11+** with type hints
- **Modern tooling**: pytest, black, isort, mypy, flake8
- **Integration testing** with PostgreSQL
- **Docker Compose** for development
- **Read the Docs** ready
- **GitHub Actions** workflow

## 📦 Usage

```python
from mirasurf_py_template import MirasurfConfig

# Create configuration
config = MirasurfConfig(
    enable_logging=True,
    log_level="DEBUG",
    max_processing_time=60
)
```

## 🛠️ Development

```bash
# Code quality
make format      # Format code
make lint        # Run linters
make quality     # All quality checks

# Testing
make test        # All tests
make test-unit   # Unit tests only
make test-integration  # Integration tests

# Build
make build       # Build package
make clean       # Clean artifacts
```

## 📁 Project Structure

```
├── mirasurf_py_template/  # Main package
├── tests/                 # Test suite
├── docs/                  # Documentation
├── docker-compose.yml     # Development environment
├── pyproject.toml        # Project configuration
└── Makefile              # Development commands
```

## 🔧 Customization

1. **Rename the package**: Update `mirasurf_py_template` to your package name
2. **Update metadata**: Modify `pyproject.toml` with your project details
3. **Add your code**: Replace the example config with your library code
4. **Update tests**: Write tests for your functionality
5. **Configure CI/CD**: Update GitHub Actions for your repository

## 📚 Documentation

- [Python Packaging Guide](https://packaging.python.org/)
- [Pytest Documentation](https://docs.pytest.org/)
- [Pydantic Documentation](https://docs.pydantic.dev/)

## 📄 License

MIT License - see [LICENSE](LICENSE) file for details. 