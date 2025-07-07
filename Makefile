# Mirasurf Python Template - Makefile

# Configuration
PYTHON := python3
PYTHON_MODULES := mirasurf_py_template
TEST_DIR := tests
LINE_LENGTH := 120
PROJECT_NAME := mirasurf-py-template

# Colors for output
GREEN := \033[0;32m
BLUE := \033[0;34m
YELLOW := \033[0;33m
RED := \033[0;31m
RESET := \033[0m

# Development Commands
.PHONY: install install-dev

install:
	@echo "$(BLUE)📦 Installing dependencies...$(RESET)"
	@pip install -e .

install-dev:
	@echo "$(BLUE)🔧 Installing development dependencies...$(RESET)"
	@pip install -e ".[dev]"

# Code Quality Commands
.PHONY: format format-check lint lint-fix quality

# Format code (black, isort)
format:
	@echo "$(BLUE)🎨 Formatting code...$(RESET)"
	@isort $(PYTHON_MODULES) --line-length $(LINE_LENGTH)
	@black $(PYTHON_MODULES) --line-length $(LINE_LENGTH)

# Check if code is properly formatted
format-check:
	@echo "$(BLUE)🔍 Checking code formatting...$(RESET)"
	@black --check $(PYTHON_MODULES) --line-length $(LINE_LENGTH)
	@isort --check-only $(PYTHON_MODULES) --line-length $(LINE_LENGTH)

# Lint code
lint:
	@echo "$(BLUE)🔍 Running linters...$(RESET)"
	@flake8 --max-line-length=$(LINE_LENGTH) --extend-ignore=E203,W503 $(PYTHON_MODULES)
	@mypy $(PYTHON_MODULES)

# Auto-fix linting issues where possible
lint-fix:
	@echo "$(BLUE)🔧 Auto-fixing linting issues...$(RESET)"
	@autoflake --in-place --recursive --remove-all-unused-imports --remove-unused-variables $(PYTHON_MODULES)

# Run all quality checks
quality: format-check lint
	@echo "$(GREEN)🎉 All quality checks passed!$(RESET)"

# Testing Commands
.PHONY: test test-unit test-integration test-coverage test-watch test-core test-config test-utils

test:
	@echo "$(BLUE)🧪 Running all tests...$(RESET)"
	@pytest $(TEST_DIR) -v

test-unit:
	@echo "$(BLUE)🧪 Running unit tests...$(RESET)"
	@pytest $(TEST_DIR) -v -m "not integration"

test-integration:
	@echo "$(BLUE)🧪 Running integration tests...$(RESET)"
	@pytest $(TEST_DIR) -v -m "integration"

test-coverage:
	@echo "$(BLUE)🧪 Running tests with coverage...$(RESET)"
	@pytest $(TEST_DIR) --cov=mirasurf_py_template --cov-report=html --cov-report=term-missing

# Build Commands
.PHONY: build build-wheel build-sdist package

build:
	@echo "$(BLUE)🔨 Building package...$(RESET)"
	@$(PYTHON) -m build

build-wheel:
	@echo "$(BLUE)🔨 Building wheel...$(RESET)"
	@$(PYTHON) -m build --wheel

build-sdist:
	@echo "$(BLUE)🔨 Building source distribution...$(RESET)"
	@$(PYTHON) -m build --sdist

package: clean build

# Utility Commands
.PHONY: clean clean-all shell check-env requirements

clean:
	@echo "$(BLUE)🧹 Cleaning Python cache and build artifacts...$(RESET)"
	@find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
	@find . -type f -name "*.pyc" -delete 2>/dev/null || true
	@find . -type f -name "*.pyo" -delete 2>/dev/null || true
	@find . -type f -name "*.pyd" -delete 2>/dev/null || true
	@find . -type f -name ".coverage" -delete 2>/dev/null || true
	@find . -type d -name "*.egg-info" -exec rm -rf {} + 2>/dev/null || true
	@find . -type d -name "*.egg" -exec rm -rf {} + 2>/dev/null || true
	@find . -type d -name ".pytest_cache" -exec rm -rf {} + 2>/dev/null || true
	@find . -type d -name "htmlcov" -exec rm -rf {} + 2>/dev/null || true
	@find . -type d -name ".mypy_cache" -exec rm -rf {} + 2>/dev/null || true
	@rm -rf dist/ build/ 2>/dev/null || true

clean-all: clean
	@echo "$(GREEN)✅ Complete cleanup finished!$(RESET)"

shell:
	@echo "$(BLUE)🐚 Activating development shell...$(RESET)"
	@$(PYTHON) -m venv .venv && source .venv/bin/activate

check-env:
	@echo "$(BLUE)🔍 Checking environment...$(RESET)"
	@echo "Python version: $$($(PYTHON) --version)"
	@echo "Working directory: $$(pwd)"
	@echo "Python modules: $(PYTHON_MODULES)"
	@echo "Test directory: $(TEST_DIR)"

requirements:
	@echo "$(BLUE)📋 Generating requirements files...$(RESET)"
	@pip freeze > requirements.txt
	@pip freeze --exclude-editable > requirements-prod.txt

run-examples:
	@echo "$(BLUE)🚀 Running examples...$(RESET)"
	@$(PYTHON) -c "from mirasurf_py_template import MirasurfCore; core = MirasurfCore(); print('Mirasurf Core initialized successfully!')"

# Documentation Commands
.PHONY: docs docs-serve docs-build

docs-build:
	@echo "$(BLUE)📚 Building documentation...$(RESET)"
	@cd docs && make html

docs-serve:
	@echo "$(BLUE)📚 Serving documentation...$(RESET)"
	@cd docs && python -m http.server 8000

# Help
.PHONY: help

help:
	@echo "$(BLUE)Mirasurf Python Template - Makefile$(RESET)"
	@echo "$(YELLOW)=====================================$(RESET)"
	@echo ""
	@echo "$(GREEN)Development Commands:$(RESET)"
	@echo "  $(YELLOW)make install$(RESET)     - Install dependencies"
	@echo "  $(YELLOW)make install-dev$(RESET) - Install development dependencies"
	@echo "  $(YELLOW)make shell$(RESET)       - Activate development shell"
	@echo ""
	@echo "$(GREEN)Code Quality Commands:$(RESET)"
	@echo "  $(YELLOW)make format$(RESET)      - Format code (black, isort, autoflake)"
	@echo "  $(YELLOW)make format-check$(RESET) - Check code formatting"
	@echo "  $(YELLOW)make lint$(RESET)        - Run linters (flake8, mypy)"
	@echo "  $(YELLOW)make lint-fix$(RESET)    - Auto-fix linting issues"
	@echo "  $(YELLOW)make quality$(RESET)     - Run all quality checks"
	@echo ""
	@echo "$(GREEN)Testing Commands:$(RESET)"
	@echo "  $(YELLOW)make test$(RESET)        - Run all tests"
	@echo "  $(YELLOW)make test-unit$(RESET)   - Run unit tests only"
	@echo "  $(YELLOW)make test-integration$(RESET) - Run integration tests only"
	@echo "  $(YELLOW)make test-coverage$(RESET) - Run tests with coverage"
	@echo ""
	@echo "$(GREEN)Build Commands:$(RESET)"
	@echo "  $(YELLOW)make build$(RESET)       - Build package"
	@echo "  $(YELLOW)make package$(RESET)     - Build and package for distribution"
	@echo ""
	@echo "$(GREEN)Documentation Commands:$(RESET)"
	@echo "  $(YELLOW)make docs-build$(RESET)  - Build documentation"
	@echo "  $(YELLOW)make docs-serve$(RESET)  - Serve documentation locally"
	@echo ""
	@echo "$(GREEN)Utility Commands:$(RESET)"
	@echo "  $(YELLOW)make clean$(RESET)       - Clean Python cache and build artifacts"
	@echo "  $(YELLOW)make clean-all$(RESET)   - Clean everything"
	@echo "  $(YELLOW)make check-env$(RESET)   - Check environment setup"
	@echo "  $(YELLOW)make requirements$(RESET) - Generate requirements files"
	@echo "  $(YELLOW)make run-examples$(RESET) - Run examples"

.DEFAULT_GOAL := help 