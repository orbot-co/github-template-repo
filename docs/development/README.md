# Development Guide

This directory contains guides for developers working on this project.

## Contents

- `setup.md` - Development environment setup
- `local-development.md` - Running the project locally
- `testing.md` - Testing guidelines and how-tos
- `debugging.md` - Debugging techniques and tools
- `code-style.md` - Code style and conventions

## Getting Started

1. Read [setup.md](./setup.md) for environment setup
2. Follow [local-development.md](./local-development.md) to run locally
3. Review [code-style.md](./code-style.md) for coding standards
4. Check [testing.md](./testing.md) for testing requirements

## Quick Start

```bash
# Install dependencies
npm install

# Set up environment
cp .env.example .env

# Start development server
npm run dev

# Run tests
npm test
```

## Development Workflow

1. Create a feature branch
2. Make changes and write tests
3. Run linting and tests
4. Commit with meaningful messages
5. Push and create a pull request

See [CONTRIBUTING.md](../../CONTRIBUTING.md) for detailed contribution guidelines.

## Common Tasks

### Running the Development Server

```bash
npm run dev
```

The application will be available at `http://localhost:3000`

### Running Tests

```bash
npm test           # Run all tests
npm run test:watch # Watch mode
npm run test:coverage # Coverage report
```

### Formatting and Linting

```bash
npm run format     # Format code
npm run lint       # Check for issues
npm run lint:fix   # Fix issues automatically
```

## Troubleshooting

If you encounter issues, check [debugging.md](./debugging.md) for common solutions.

## Additional Resources

- [README](../../README.md) - Project overview
- [CONTRIBUTING.md](../../CONTRIBUTING.md) - Contribution guidelines
- [Code of Conduct](../../CODE_OF_CONDUCT.md) - Community standards
