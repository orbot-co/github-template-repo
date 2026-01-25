# Contributing to This Project

Thank you for your interest in contributing! We appreciate your efforts to improve this project.

## Table of Contents

- [Contributing to This Project](#contributing-to-this-project)
  - [Table of Contents](#table-of-contents)
  - [Code of Conduct](#code-of-conduct)
  - [Getting Started](#getting-started)
  - [Development Environment Setup](#development-environment-setup)
    - [Prerequisites](#prerequisites)
    - [Setup Steps](#setup-steps)
  - [Coding Standards](#coding-standards)
    - [General Guidelines](#general-guidelines)
    - [Language-Specific Standards](#language-specific-standards)
      - [JavaScript/TypeScript](#javascripttypescript)
      - [Python](#python)
    - [Formatting](#formatting)
  - [Commit Message Conventions](#commit-message-conventions)
    - [Format](#format)
    - [Types](#types)
    - [Examples](#examples)
  - [Testing Requirements](#testing-requirements)
    - [Running Tests](#running-tests)
    - [Test Structure](#test-structure)
  - [Pull Request Process](#pull-request-process)
    - [Pull Request Template](#pull-request-template)
  - [Branch Naming Conventions](#branch-naming-conventions)
    - [Examples](#examples-1)
  - [Code Review Process](#code-review-process)
    - [For Authors](#for-authors)
    - [For Reviewers](#for-reviewers)
  - [Local Development Workflow](#local-development-workflow)
  - [Questions or Need Help?](#questions-or-need-help)

## Code of Conduct

This project and everyone participating in it is governed by our [Code of Conduct](./CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code.

## Getting Started

1. Fork the repository
2. Clone your fork: `git clone https://github.com/your-username/project.git`
3. Add the upstream remote: `git remote add upstream https://github.com/original-username/project.git`
4. Create a feature branch (see [Branch Naming Conventions](#branch-naming-conventions))

## Development Environment Setup

### Prerequisites

- Node.js 16+ (or Python 3.8+, depending on the project)
- Git
- npm or yarn (for Node.js projects)

### Setup Steps

```bash
# Install dependencies
npm install

# Set up environment variables
cp .env.example .env

# Run the development server
npm run dev

# Run tests
npm test
```

For detailed setup instructions, see the [Development Guide](./docs/development/setup.md).

## Coding Standards

### General Guidelines

- Use meaningful variable and function names
- Keep functions small and focused
- Add comments for complex logic
- Follow the language's standard conventions
- Use an editor config tool to maintain consistency

### Language-Specific Standards

#### JavaScript/TypeScript

- Use ESLint configuration provided in the project
- Use Prettier for code formatting
- Follow naming conventions:
  - `camelCase` for variables and functions
  - `PascalCase` for classes and components
  - `UPPER_SNAKE_CASE` for constants

#### Python

- Follow PEP 8 style guide
- Use `black` for code formatting
- Use `pylint` or `flake8` for linting
- Type hints are encouraged

### Formatting

Run the formatter before committing:

```bash
npm run format  # For JavaScript/TypeScript
# or
black .        # For Python
```

## Commit Message Conventions

We follow the Conventional Commits specification.

### Format

```
type(scope): subject

body

footer
```

### Types

- `feat`: A new feature
- `fix`: A bug fix
- `docs`: Documentation only changes
- `style`: Changes that do not affect the meaning of the code
- `refactor`: A code change that neither fixes a bug nor adds a feature
- `perf`: A code change that improves performance
- `test`: Adding missing tests or correcting existing tests
- `chore`: Changes to build process, dependencies, or tools

### Examples

```
feat(auth): add JWT token refresh mechanism

Implement automatic token refresh to improve user experience
and security. Users will no longer be logged out unexpectedly.

Closes #123
```

```
fix(api): resolve null pointer exception in user service

The getUserById method was not checking for null values
before accessing properties.

Fixes #456
```

## Testing Requirements

- Write tests for new features
- Ensure all tests pass before submitting a pull request
- Maintain or improve code coverage
- Run tests locally before pushing

### Running Tests

```bash
npm test                    # Run all tests
npm run test:watch        # Watch mode
npm run test:coverage     # Coverage report
```

### Test Structure

```
src/
├── components/
│   ├── Button.js
│   └── Button.test.js
└── utils/
    ├── helpers.js
    └── helpers.test.js
```

## Pull Request Process

1. **Create a Feature Branch**: Use the naming conventions below
2. **Make Your Changes**: Follow coding standards
3. **Write/Update Tests**: Ensure coverage
4. **Update Documentation**: If applicable
5. **Commit**: Follow commit conventions
6. **Push**: `git push origin feature/your-feature`
7. **Create Pull Request**: Use the provided template
8. **Respond to Reviews**: Address feedback promptly

### Pull Request Template

Your PR should include:

- Clear title and description
- Related issue numbers (e.g., `Fixes #123`)
- Type of change (feature, fix, docs, etc.)
- Testing performed
- Checklist:
  - [ ] Tests pass locally
  - [ ] No new warnings
  - [ ] Code follows style guidelines
  - [ ] Documentation updated
  - [ ] No breaking changes (or documented)

## Branch Naming Conventions

Create branches from `main` with these prefixes:

```
feature/feature-name          # New features
fix/bug-description           # Bug fixes
docs/documentation-update     # Documentation changes
refactor/component-name       # Code refactoring
chore/task-description        # Build, dependencies, etc.
test/test-description         # Test additions
```

### Examples

```
feature/user-authentication
fix/login-page-styling
docs/api-endpoints
refactor/utils-module
```

## Code Review Process

### For Authors

- Respond to feedback professionally and promptly
- Make requested changes in new commits or amend existing ones
- Re-request review after addressing changes
- Keep the PR focused and reasonably sized

### For Reviewers

- Review within 24-48 hours if possible
- Be constructive and respectful
- Approve when satisfied
- Use GitHub's "Request Changes" only for blocking issues

## Local Development Workflow

```bash
# Update main branch
git checkout main
git pull upstream main

# Create feature branch
git checkout -b feature/my-feature

# Make changes and commit
git add .
git commit -m "feat: add my feature"

# Keep branch updated
git pull upstream main --rebase

# Push to your fork
git push origin feature/my-feature

# Create pull request on GitHub
```

## Questions or Need Help?

- Check existing issues and discussions
- Read the [Documentation](./docs/)
- Create a GitHub discussion or issue
- Contact maintainers (see [SUPPORT.md](./SUPPORT.md))

---

Thank you for contributing! Your help makes this project better for everyone.
