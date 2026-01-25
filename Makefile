.PHONY: help install dev build test lint format clean deploy

# Variables
NODE_VERSION := 18
DOCKER_IMAGE := professional-project
DOCKER_REGISTRY := registry.example.com

help:
	@echo "Professional Project - Available Commands"
	@echo ""
	@echo "Setup & Installation:"
	@echo "  make install          Install dependencies"
	@echo "  make setup            Run full development setup"
	@echo ""
	@echo "Development:"
	@echo "  make dev              Start development server"
	@echo "  make dev-watch        Run in watch mode"
	@echo ""
	@echo "Code Quality:"
	@echo "  make lint             Run ESLint"
	@echo "  make lint-fix         Fix linting issues"
	@echo "  make format           Format code with Prettier"
	@echo "  make type-check       Run TypeScript type checking"
	@echo ""
	@echo "Testing:"
	@echo "  make test             Run all tests"
	@echo "  make test-watch       Run tests in watch mode"
	@echo "  make test-coverage    Generate coverage report"
	@echo ""
	@echo "Building:"
	@echo "  make build            Build for production"
	@echo "  make build-docker     Build Docker image"
	@echo ""
	@echo "Docker & Deployment:"
	@echo "  make docker-up        Start Docker containers"
	@echo "  make docker-down      Stop Docker containers"
	@echo "  make docker-logs      View Docker logs"
	@echo "  make deploy-staging   Deploy to staging"
	@echo "  make deploy-prod      Deploy to production"
	@echo ""
	@echo "Database:"
	@echo "  make db-setup         Initialize database"
	@echo "  make db-reset         Reset database (careful!)"
	@echo "  make db-migrate       Run migrations"
	@echo ""
	@echo "Utilities:"
	@echo "  make clean            Clean build artifacts"
	@echo "  make clean-all        Deep clean (node_modules, etc)"
	@echo "  make version          Show version info"

# Setup & Installation
.PHONY: install setup
install:
	@echo "📦 Installing dependencies..."
	npm ci

setup:
	@echo "🚀 Running full setup..."
	./scripts/setup.sh

# Development
.PHONY: dev dev-watch
dev:
	@echo "🔨 Starting development server..."
	npm run dev

dev-watch:
	@echo "👀 Starting development server in watch mode..."
	npm run dev -- --watch

# Code Quality
.PHONY: lint lint-fix format type-check
lint:
	@echo "🔍 Running ESLint..."
	npm run lint

lint-fix:
	@echo "🔧 Fixing linting issues..."
	npm run lint:fix

format:
	@echo "✨ Formatting code..."
	npm run format

type-check:
	@echo "📝 Running type check..."
	npm run type-check

check: lint type-check
	@echo "✅ All checks passed!"

# Testing
.PHONY: test test-watch test-coverage
test:
	@echo "🧪 Running tests..."
	npm test

test-watch:
	@echo "👀 Running tests in watch mode..."
	npm run test:watch

test-coverage:
	@echo "📊 Generating coverage report..."
	npm run test:coverage
	@echo "📁 Coverage report generated: coverage/index.html"

# Building
.PHONY: build build-docker build-clean
build:
	@echo "🏗️  Building for production..."
	./scripts/build.sh

build-docker:
	@echo "🐳 Building Docker image..."
	docker build -t $(DOCKER_IMAGE):latest -t $(DOCKER_IMAGE):v1 .
	@echo "✅ Docker image built: $(DOCKER_IMAGE):latest"

build-clean: clean build
	@echo "✅ Clean build complete"

# Docker & Deployment
.PHONY: docker-up docker-down docker-logs docker-rebuild
docker-up:
	@echo "🐳 Starting Docker containers..."
	docker-compose up -d
	@echo "✅ Containers started"
	docker-compose ps

docker-down:
	@echo "🛑 Stopping Docker containers..."
	docker-compose down
	@echo "✅ Containers stopped"

docker-logs:
	@echo "📋 Docker logs..."
	docker-compose logs -f

docker-rebuild:
	@echo "🔨 Rebuilding Docker containers..."
	docker-compose down
	docker-compose build --no-cache
	docker-compose up -d
	@echo "✅ Containers rebuilt and started"

deploy-staging:
	@echo "🧪 Deploying to staging..."
	./scripts/deploy.sh staging
	@echo "✅ Staging deployment complete"

deploy-prod:
	@echo "🚀 Deploying to production..."
	@read -p "⚠️  Are you sure? (y/n) " -n 1 -r; \
	echo; \
	if [[ $$REPLY =~ ^[Yy]$$ ]]; then \
		./scripts/deploy.sh production; \
		echo "✅ Production deployment complete"; \
	else \
		echo "❌ Deployment cancelled"; \
	fi

# Database
.PHONY: db-setup db-reset db-migrate
db-setup:
	@echo "🗄️  Setting up database..."
	docker-compose exec postgres psql -U postgres -c "CREATE DATABASE project_dev;"
	@echo "✅ Database created"

db-reset:
	@echo "🗄️  Resetting database..."
	@read -p "⚠️  This will delete all data. Continue? (y/n) " -n 1 -r; \
	echo; \
	if [[ $$REPLY =~ ^[Yy]$$ ]]; then \
		docker-compose exec postgres psql -U postgres -c "DROP DATABASE IF EXISTS project_dev; CREATE DATABASE project_dev;"; \
		echo "✅ Database reset"; \
	else \
		echo "❌ Reset cancelled"; \
	fi

db-migrate:
	@echo "🔄 Running migrations..."
	npm run migrate
	@echo "✅ Migrations complete"

# Utilities
.PHONY: clean clean-all version
clean:
	@echo "🧹 Cleaning build artifacts..."
	rm -rf dist
	rm -rf build
	rm -rf coverage
	rm -rf .next
	@echo "✅ Clean complete"

clean-all: clean
	@echo "🧹 Deep cleaning..."
	rm -rf node_modules
	rm -f package-lock.json
	@echo "✅ Deep clean complete"

version:
	@echo "Version Information:"
	@echo "Node: $$(node -v)"
	@echo "npm: $$(npm -v)"
	@echo "Project: $$(npm run --silent get-version 2>/dev/null || echo 'unknown')"

# Shortcuts
.PHONY: all ci full-test
all: lint test build
	@echo "✅ All tasks complete!"

ci: lint type-check test build
	@echo "✅ CI pipeline complete!"

full-test: clean install test test-coverage
	@echo "✅ Full test suite complete!"

# Development workflow shortcuts
.PHONY: start start-fresh
start: install dev

start-fresh: clean-all install setup dev

# Git & Release
.PHONY: git-status git-diff git-log
git-status:
	@git status

git-diff:
	@git diff

git-log:
	@git log --oneline -10

# Dependencies
.PHONY: deps-update deps-audit
deps-update:
	@echo "📦 Updating dependencies..."
	npm update
	@echo "✅ Dependencies updated"

deps-audit:
	@echo "🔍 Running npm audit..."
	npm audit
