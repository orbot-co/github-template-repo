# Dev Container Setup

This directory contains configuration for developing the Probot GitHub App in a containerized environment.

## What's Included

- **Node.js 18**: Alpine-based image matching production
- **PostgreSQL 15**: Database service with health checks
- **Redis 7**: Cache service
- **Development Tools**: git, make, curl, bash, PostgreSQL client, Redis CLI
- **VS Code Extensions**: ESLint, Prettier, Docker, GitHub Copilot, Jest, YAML support

## Getting Started

### Prerequisites

- [Visual Studio Code](https://code.visualstudio.com/)
- [Docker Desktop](https://www.docker.com/products/docker-desktop)
- [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

### Opening the Dev Container

1. Open this project in VS Code
2. Press `F1` and select **Dev Containers: Reopen in Container**
3. Wait for the container to build and start
4. Once ready, you'll have a full development environment

### First Time Setup

The container automatically runs `npm ci` after creation. To verify everything works:

```bash
# See available commands
make help

# Run tests
make test

# Start development server
make dev
```

## Services

The dev container includes these services:

- **App Container** (port 3000): Your development workspace
- **PostgreSQL** (port 5432): Database service
  - Database: `project_dev`
  - User: `postgres`
  - Password: `postgres`
- **Redis** (port 6379): Cache service

## Environment Variables

Default environment variables are set in `docker-compose.yml`. To customize:

1. Copy `.env.example` to `.env` in the root directory
2. Modify values as needed
3. Rebuild the container: **Dev Containers: Rebuild Container**

## Working with the Database

```bash
# Connect to PostgreSQL
psql -h localhost -U postgres -d project_dev

# Run migrations (if configured)
make db-migrate

# Reset database
make db-reset
```

## Working with Redis

```bash
# Connect to Redis CLI
redis-cli

# Test connection
redis-cli ping
```

## Troubleshooting

### Container won't start

1. Ensure Docker Desktop is running
2. Check Docker has enough resources (4GB RAM minimum)
3. Rebuild container: `F1` → **Dev Containers: Rebuild Container**

### Ports already in use

If ports 3000, 5432, or 6379 are in use:
1. Stop conflicting services
2. Or modify `forwardPorts` in `devcontainer.json`

### Database connection issues

Verify PostgreSQL is healthy:
```bash
docker compose -f .devcontainer/docker-compose.yml ps
```

## Customization

### Adding VS Code Extensions

Edit `devcontainer.json` → `customizations.vscode.extensions` array

### Adding System Packages

Edit `.devcontainer/Dockerfile` and add packages to the `apk add` command

### Changing Node Version

Edit `.devcontainer/Dockerfile` and change `FROM node:18-alpine` to desired version

## Benefits

- ✅ Consistent environment across all developers
- ✅ No need to install Node.js, PostgreSQL, Redis locally
- ✅ Isolated from your host system
- ✅ Quick onboarding for new team members
- ✅ Matches production environment closely
