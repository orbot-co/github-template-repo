# AI Agent Instructions

## Project Overview

This is a **Probot GitHub App** project using Node.js/TypeScript with comprehensive DevOps infrastructure. The core app ([index.js](../index.js)) responds to GitHub webhook events like `issues.opened`.

## Architecture

### Core Components
- **Probot App** ([index.js](../index.js)): GitHub webhook handler with event-driven architecture
- **Stack**: Node.js 18+, TypeScript (with Vite build), Jest for testing
- **Infrastructure**: Docker multi-stage builds, Kubernetes with HPA, PostgreSQL + Redis
- **Service Architecture**: Load balancer → App servers → Cache/DB/Queue/Search (see [architecture docs](../docs/architecture/README.md))

### Key Files
- [Dockerfile](../Dockerfile): Multi-stage build with non-root user (1001), dumb-init for signal handling
- [kubernetes/](../kubernetes/): Full K8s deployment with HPA, RBAC, ingress
- [docker-compose.yml](../docker-compose.yml): Local dev with postgres & redis dependencies
- [Makefile](../Makefile): Central command hub (see `make help`)

## Development Workflow

### Setup & Running
```bash
make install              # Install dependencies via npm ci
make dev                 # Start development server
make docker-up           # Start full stack with postgres/redis
```

### Code Quality Pipeline
Before commits, always run:
```bash
make check              # Runs both lint and type-check
make format             # Prettier formatting
make test               # Jest tests
```

### Build & Deploy
```bash
make build              # Uses scripts/build.sh with type-check → lint → build
make build-docker       # Multi-stage Docker build
make deploy-staging     # Deploy to staging
```

## Project Conventions

### Testing Pattern
- **Framework**: Jest with Probot test utilities
- **Structure**: Test files in [test/](../test/), fixtures in [test/fixtures/](../test/fixtures/)
- **Mocking**: Use Probot's `Application` class to mock GitHub API (see [index.test.js](../test/index.test.js))
- **Example**: Mock `github.issues.createComment` for webhook event testing

### Commit Convention
Follow **Conventional Commits** strictly:
- `feat(scope): description` for features
- `fix(scope): description` for bugs
- Include issue references: `Closes #123`
- See [CONTRIBUTING.md](../CONTRIBUTING.md) for full spec

### Code Style
- **TypeScript**: `camelCase` variables/functions, `PascalCase` classes, `UPPER_SNAKE_CASE` constants
- **Formatting**: Prettier (run `make format` before commits)
- **Linting**: ESLint with TypeScript support (`make lint-fix` for auto-fixes)

## Critical Infrastructure Details

### Docker Strategy
- **Build stage**: Full deps + build in node:18-alpine
- **Production stage**: Production deps only, runs as non-root user `nodejs:1001`
- **Health check**: HTTP GET on port 3000 with 30s interval
- **Entry point**: Uses dumb-init for proper signal handling

### Kubernetes Deployment
- **Replicas**: 3 with RollingUpdate (maxSurge: 1, maxUnavailable: 0)
- **Security**: Non-root execution (runAsUser: 1001), serviceAccountName for RBAC
- **Config**: Environment from ConfigMaps ([kubernetes/configmap.yaml](../kubernetes/configmap.yaml))
- **Scaling**: HPA configured in [kubernetes/hpa.yaml](../kubernetes/hpa.yaml)

### Local Dev Environment
- **Dependencies**: PostgreSQL 15 + Redis 7 via docker-compose
- **Health checks**: postgres uses `pg_isready`, services wait for healthy state
- **Volumes**: Source code mounted for hot reload, persistent data volumes for databases
- **Network**: Isolated `app-network` for service communication

## Helper Scripts

Scripts in [scripts/](../scripts/) follow consistent patterns:
- `build.sh`: Cleans dist/, runs type-check (warns only), lint (warns only), then builds with size report
- `test.sh`: Supports flags: `-w` (watch), `-c` (coverage), `-v` (verbose)
- `setup.sh`: Full development environment initialization
- `deploy.sh`: Deployment automation

## Important Notes

- **Node version**: Requires Node.js 16+, project uses 18 (see [Dockerfile](../Dockerfile) and [package.json](../package.json) engines)
- **Port**: Application listens on port 3000 (configured in Docker/K8s)
- **Main entry**: Production uses `dist/index.js` (compiled), dev uses source
- **Makefile**: Always prefer Makefile commands over direct npm scripts for consistency
- **Documentation**: Comprehensive docs in [docs/](../docs/) - check architecture, deployment, and development guides before making structural changes
