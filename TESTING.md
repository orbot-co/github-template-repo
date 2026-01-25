# Testing Strategy & Guide

Comprehensive testing approach for maintaining code quality and reliability.

## Testing Pyramid

```
        /\
       /  \        E2E Tests (5%)
      /____\
     /      \
    /        \     Integration Tests (15%)
   /          \
  /____________\
 /              \
/                \ Unit Tests (80%)
/_________________\
```

## Testing Levels

### Unit Tests (80%)
**Focus**: Individual functions and components

```bash
npm test
```

#### What to Test
- Function logic and return values
- Error handling and edge cases
- State changes
- Input validation
- Boundary conditions

#### Tools
- Jest
- Vitest
- Mocha + Chai

#### Example
```typescript
describe('calculateTotal', () => {
  it('should sum array of numbers', () => {
    expect(calculateTotal([1, 2, 3])).toBe(6);
  });

  it('should handle empty array', () => {
    expect(calculateTotal([])).toBe(0);
  });

  it('should throw on non-numeric values', () => {
    expect(() => calculateTotal([1, 'two', 3])).toThrow();
  });
});
```

### Integration Tests (15%)
**Focus**: Multiple components working together

#### What to Test
- API endpoints
- Database operations
- Service interactions
- Workflow scenarios
- Data flow between systems

#### Tools
- Supertest (API testing)
- Jest with database fixtures
- Test containers

#### Example
```typescript
describe('User Registration API', () => {
  it('should create user and send welcome email', async () => {
    const response = await request(app)
      .post('/api/users/register')
      .send({ email: 'user@test.com', password: 'secure' });

    expect(response.status).toBe(201);
    expect(mockEmailService.send).toHaveBeenCalled();
  });
});
```

### E2E Tests (5%)
**Focus**: Complete user workflows

#### What to Test
- Critical user journeys
- Happy paths
- Major features
- Cross-browser compatibility

#### Tools
- Cypress
- Playwright
- Selenium

#### Example
```typescript
describe('User Login Flow', () => {
  it('should login and access dashboard', () => {
    cy.visit('/login');
    cy.get('input[name="email"]').type('user@example.com');
    cy.get('input[name="password"]').type('password');
    cy.get('button[type="submit"]').click();
    cy.url().should('include', '/dashboard');
  });
});
```

## Test Coverage

### Minimum Coverage Requirements
- **Overall**: 80%
- **Statements**: 80%
- **Branches**: 75%
- **Functions**: 80%
- **Lines**: 80%

### Coverage Report
```bash
npm run test:coverage
```

### Viewing Coverage
```
coverage/
├── index.html      # Open in browser
├── lcov.info       # For CI/CD
└── coverage-final.json
```

## Writing Good Tests

### Test Structure (Arrange-Act-Assert)
```typescript
it('should calculate discount correctly', () => {
  // Arrange
  const product = { price: 100, discount: 0.2 };

  // Act
  const finalPrice = applyDiscount(product);

  // Assert
  expect(finalPrice).toBe(80);
});
```

### Test Naming
```typescript
// Good
it('should return user data when ID exists');
it('should throw error when ID is invalid');
it('should handle null gracefully');

// Bad
it('returns data');
it('works');
it('test 1');
```

### Avoiding Common Mistakes
```typescript
// ❌ Don't: Shared state between tests
describe('User', () => {
  let user;
  beforeEach(() => {
    user = { id: 1 }; // Shared mutable state
  });
});

// ✅ Do: Isolated setup
describe('User', () => {
  it('should create user', () => {
    const user = createUser({ id: 1 });
  });
});
```

## Mocking & Fixtures

### Mocking External Services
```typescript
jest.mock('../services/emailService');

const mockEmailService = require('../services/emailService');

it('should send email on registration', () => {
  mockEmailService.send.mockResolvedValue({ success: true });
  
  register({ email: 'user@test.com' });
  
  expect(mockEmailService.send).toHaveBeenCalledWith({
    to: 'user@test.com',
    subject: 'Welcome'
  });
});
```

### Test Fixtures
```typescript
// fixtures/userData.ts
export const validUser = {
  id: 1,
  email: 'user@example.com',
  password: 'hashedPassword',
  createdAt: new Date('2024-01-01')
};

// In test
import { validUser } from './fixtures/userData';

it('should load user', async () => {
  const user = await loadUser(validUser.id);
  expect(user).toEqual(validUser);
});
```

## Test Organization

### File Structure
```
src/
├── components/
│   ├── Button.tsx
│   └── Button.test.tsx
├── utils/
│   ├── helpers.ts
│   └── helpers.test.ts
└── services/
    ├── api.ts
    └── api.test.ts
```

### Test Suite Organization
```typescript
describe('UserService', () => {
  describe('createUser', () => {
    it('should create user with valid data');
    it('should validate email format');
  });

  describe('updateUser', () => {
    it('should update user data');
    it('should not update password here');
  });
});
```

## Running Tests

### Run All Tests
```bash
npm test
```

### Watch Mode
```bash
npm run test:watch
```

### Coverage Report
```bash
npm run test:coverage
```

### Run Specific Test
```bash
npm test -- Button.test.ts
npm test -- --testNamePattern="should create user"
```

## Continuous Integration Testing

### Before Merge
- All tests must pass
- Coverage must meet minimum
- No flaky tests
- Performance benchmarks OK

### Automated Testing
```yaml
# GitHub Actions
- run: npm test
- run: npm run test:coverage
- run: npm run test:e2e
```

## Performance Testing

### Load Testing
```bash
npm run test:load
```

### Memory Profiling
```bash
npm run test:memory
```

## Testing Best Practices

### ✅ Do
- Write tests alongside code
- Test behavior, not implementation
- Keep tests focused and simple
- Use descriptive test names
- Test edge cases
- Mock external dependencies
- Keep tests DRY with fixtures

### ❌ Don't
- Test implementation details
- Write tests after code (usually)
- Skip error scenarios
- Use hard-coded data
- Share state between tests
- Test multiple things per test
- Make tests depend on order

## Debugging Tests

### Debug Single Test
```bash
node --inspect-brk node_modules/.bin/jest --runInBand
```

### Verbose Output
```bash
npm test -- --verbose
```

### Watch Specific Tests
```bash
npm run test:watch -- --testNamePattern="specific test"
```

## Resources

- [Jest Documentation](https://jestjs.io/)
- [Cypress Documentation](https://docs.cypress.io/)
- [Testing Library](https://testing-library.com/)
- [Test Driven Development](https://en.wikipedia.org/wiki/Test-driven_development)

---

**Remember**: Tests are documentation. Write them with clarity and maintainability in mind.
