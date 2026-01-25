# Migration Guide

How to upgrade from one version to another and handle breaking changes.

## Version Upgrade Path

```
v1.0.x ──→ v1.1.x ──→ v1.2.x
   ↓         ↓         ↓
   └─────────┴─────────→ v2.0.x
```

## General Upgrade Steps

### 1. Backup
```bash
# Backup database
pg_dump -U username database > backup.sql

# Backup configuration
cp -r config config.backup
```

### 2. Read Release Notes
Check [CHANGELOG.md](CHANGELOG.md) for breaking changes

### 3. Update Application
```bash
# Stop application
npm stop

# Update code
git pull origin main
git checkout v1.1.0

# Install dependencies
npm install

# Run migrations (if applicable)
npm run migrate

# Run tests
npm test
```

### 4. Verify
```bash
# Check logs
npm run dev

# Run smoke tests
npm run test:e2e

# Verify features work
```

### 5. Deploy
```bash
# For Docker
docker build -t app:1.1.0 .
docker run -d app:1.1.0

# For Kubernetes
kubectl set image deployment/app app=app:1.1.0
```

## Version-Specific Migrations

### v1.0.x → v1.1.x (Minor Upgrade)

**Changes**: New features, bug fixes, performance improvements

**Migration Time**: < 5 minutes

```bash
# Update version
npm install professional-project@1.1.0

# No breaking changes
# Deploy and restart
npm start
```

### v1.x → v2.0.x (Major Upgrade)

**⚠️ BREAKING CHANGES**

#### What Changed
- API endpoints restructured
- Database schema updated
- Configuration format changed
- Some dependencies updated

#### Migration Steps

**Step 1: Pre-upgrade**
```bash
# Backup everything
pg_dump -U postgres mydb > backup_v1.sql
cp .env .env.backup
cp config config.backup
```

**Step 2: Code Changes**

**API Endpoints**
```typescript
// Old (v1)
GET /api/users
POST /api/users/:id/update

// New (v2)
GET /api/v2/users
PUT /api/v2/users/:id
```

Update your API calls:
```typescript
// Before
const response = await fetch('/api/users');

// After
const response = await fetch('/api/v2/users');
```

**Configuration**
```yaml
# Old format (v1)
server:
  port: 3000
  host: localhost

database:
  url: postgresql://localhost/mydb

# New format (v2)
server:
  port: 3000
  host: localhost

db:
  uri: postgresql://localhost/mydb
```

Update `.env`:
```bash
# Old
DB_URL=postgresql://localhost/mydb

# New
DATABASE_URI=postgresql://localhost/mydb
```

**Database Migration**
```bash
# Run migration script
npm run migrate:v1-to-v2

# Or manually:
# 1. Export v1 data
npm run export:v1

# 2. Transform data
npm run transform:data

# 3. Import v2 data
npm run import:v2

# 4. Verify
npm run verify:migration
```

**Step 3: Update Code**
```bash
# Update dependencies
npm install professional-project@2.0.0

# Update code to use new API
# Update configuration files
# Update database connection strings
```

**Step 4: Run Migrations**
```bash
npm run migrate

# Verify database
npm run db:verify
```

**Step 5: Testing**
```bash
# Test locally
npm run dev

# Run test suite
npm test

# Run E2E tests
npm run test:e2e
```

**Step 6: Staging Deployment**
```bash
# Deploy to staging
docker build -t app:2.0.0 .
docker run -d -p 3000:3000 app:2.0.0

# Test thoroughly
# Monitor for 24 hours
```

**Step 7: Production Deployment**
```bash
# Get approval
# Deploy with canary release
kubectl set image deployment/app app=app:2.0.0

# Monitor
kubectl logs -f deployment/app

# Rollback if needed
kubectl rollout undo deployment/app
```

## API Migration Example

### User Service Example

**v1.0 API**
```typescript
// Create user
POST /api/users
{ "name": "John", "email": "john@example.com" }

// Get user
GET /api/users/123

// Update user (custom endpoint)
POST /api/users/123/update
{ "name": "Jane" }

// Delete user
POST /api/users/123/delete
```

**v2.0 API**
```typescript
// Create user (same)
POST /api/v2/users
{ "name": "John", "email": "john@example.com" }

// Get user
GET /api/v2/users/123

// Update user (RESTful)
PUT /api/v2/users/123
{ "name": "Jane" }

// Delete user (RESTful)
DELETE /api/v2/users/123
```

### Migration Code
```typescript
// Before
class UserService {
  async createUser(data) {
    // v1 logic
  }

  async updateUser(id, data) {
    // Old: POST to /api/users/:id/update
  }
}

// After
class UserService {
  async createUser(data) {
    // v2 logic (can still use v1)
  }

  async updateUser(id, data) {
    // New: PUT to /api/v2/users/:id
  }

  // Backwards compatibility layer
  async updateUserLegacy(id, data) {
    // Still supports old endpoint
    return this.updateUser(id, data);
  }
}
```

## Database Migration Example

**v1 Schema**
```sql
CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  name VARCHAR(255),
  email VARCHAR(255),
  created_at TIMESTAMP
);
```

**v2 Schema**
```sql
CREATE TABLE users (
  id BIGINT PRIMARY KEY,
  name VARCHAR(255),
  email VARCHAR(255) UNIQUE,
  user_role VARCHAR(50),
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);
```

**Migration SQL**
```sql
-- Add new columns
ALTER TABLE users ADD COLUMN user_role VARCHAR(50) DEFAULT 'user';
ALTER TABLE users ADD COLUMN updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

-- Add constraint
ALTER TABLE users ADD CONSTRAINT users_email_unique UNIQUE (email);

-- Update ID type (requires recreation)
ALTER TABLE users DROP PRIMARY KEY;
ALTER TABLE users MODIFY id BIGINT;
ALTER TABLE users ADD PRIMARY KEY (id);
```

## Rollback Procedure

If migration fails:

```bash
# Stop application
npm stop

# Restore from backup
psql -U postgres mydb < backup_v1.sql

# Restore configuration
cp .env.backup .env

# Downgrade version
npm install professional-project@1.x.x

# Restart
npm start
```

## Common Issues & Solutions

### Issue: Database Connection Failed
```
Error: connect ECONNREFUSED 127.0.0.1:5432
```

**Solution**:
- Check DATABASE_URI in .env
- Verify PostgreSQL is running
- Check credentials are correct

### Issue: API Responses Changed Format
```
TypeError: Cannot read property 'data' of undefined
```

**Solution**:
- Update code to use new response format
- Check API documentation
- Use response mapping if needed

### Issue: Missing Data After Migration
**Solution**:
- Verify migration script completed
- Check backup wasn't corrupted
- Run data verification script
- Contact support if needed

## Getting Help

- 📖 [Release Notes](CHANGELOG.md)
- 💬 [GitHub Discussions](https://github.com/username/project/discussions)
- 📧 [Support Email](mailto:support@example.com)
- 🐛 [Report Issues](https://github.com/username/project/issues)

---

**Always test migrations in a staging environment first!**
