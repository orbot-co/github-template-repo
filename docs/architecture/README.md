# Architecture

This directory contains system architecture documentation and diagrams.

## Contents

- `overview.md` - System architecture overview
- `components.md` - Component descriptions and interactions
- `data-model.md` - Data model and database schema
- `design-decisions.md` - Key architectural decisions and rationale

## Architecture Overview

### High-Level Design

```
┌─────────────┐
│   Client    │
└──────┬──────┘
       │
┌──────▼──────────┐
│   Load Balancer │
└──────┬──────────┘
       │
┌──────▼─────────────────┐
│   Application Servers  │
└──────┬─────────────────┘
       │
    ┌──┴──┬────────┬─────────┐
    │     │        │         │
┌───▼──┐┌─▼───┐┌──▼──┐┌────▼─┐
│Cache ││ DB  ││Queue││Search│
└──────┘└─────┘└─────┘└──────┘
```

## Key Components

1. **API Server** - Handles incoming requests
2. **Database** - PostgreSQL for persistent storage
3. **Cache Layer** - Redis for caching
4. **Message Queue** - For async processing
5. **Search Service** - Elasticsearch integration

## Technologies

- **Language**: Node.js / TypeScript
- **Framework**: Express / Fastify
- **Database**: PostgreSQL
- **Cache**: Redis
- **Container**: Docker

## Further Reading

See the individual markdown files in this directory for detailed documentation.
