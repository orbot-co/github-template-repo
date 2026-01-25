# Release Guide

How to create and publish new releases of the project.

## Release Process

### Prerequisites
- Main branch is stable and all tests pass
- CHANGELOG.md is updated
- Version numbers follow Semantic Versioning
- All PRs merged and reviewed
- Release notes written

## Semantic Versioning

Format: `MAJOR.MINOR.PATCH`

- **MAJOR**: Breaking changes
- **MINOR**: New features (backwards compatible)
- **PATCH**: Bug fixes

### Examples
- `1.0.0` → `1.0.1`: Bug fix
- `1.0.0` → `1.1.0`: New feature
- `1.0.0` → `2.0.0`: Breaking change

## Release Checklist

### 1. Preparation (1-2 days before)
- [ ] Create release branch: `git checkout -b release/v1.x.x`
- [ ] Update version in `package.json`
- [ ] Update version in documentation
- [ ] Update `CHANGELOG.md`
- [ ] Review breaking changes
- [ ] Create PR and get approvals

### 2. Update Files

#### package.json
```json
{
  "version": "1.1.0"
}
```

#### CHANGELOG.md
```markdown
## [1.1.0] - 2026-02-15

### Added
- New feature X
- Enhancement Y

### Changed
- Performance improvement

### Fixed
- Bug in component Z
```

#### Git Tag
```bash
git tag -a v1.1.0 -m "Release version 1.1.0"
git push origin v1.1.0
```

### 3. Build & Test

```bash
# Run full test suite
npm test

# Run linting
npm run lint

# Build project
npm run build

# Test build output
npm run preview
```

### 4. Create Release

#### Create GitHub Release

```bash
# Push changes
git push origin main

# Create release via GitHub UI or CLI
gh release create v1.1.0 \
  --title "Version 1.1.0" \
  --notes "Release notes here"
```

#### Build Docker Image

```bash
# Build image
docker build -t professional-project:1.1.0 .
docker tag professional-project:1.1.0 professional-project:latest

# Push to registry
docker push professional-project:1.1.0
docker push professional-project:latest
```

#### Publish to NPM (if applicable)

```bash
# Login to npm
npm login

# Publish
npm publish

# View published version
npm view professional-project version
```

### 5. Deploy

#### Staging Environment
```bash
docker pull registry.example.com/professional-project:1.1.0
# Deploy to staging
kubectl set image deployment/app-deployment \
  app=registry.example.com/professional-project:1.1.0 \
  -n staging
```

#### Production Environment
```bash
# Monitor staging for 24 hours
# Review logs and metrics
# Get approval from maintainers

# Deploy to production
kubectl set image deployment/app-deployment \
  app=registry.example.com/professional-project:1.1.0 \
  -n production
```

### 6. Verification

```bash
# Check deployment status
kubectl get deployment app-deployment

# Check pod health
kubectl get pods -l app=professional-project

# Monitor metrics
kubectl logs -l app=professional-project -f

# Run smoke tests
npm run test:e2e
```

### 7. Announcement

- [ ] Create release notes
- [ ] Update website/documentation
- [ ] Announce on social media
- [ ] Email notification to users
- [ ] Blog post (if major release)

## Version Release Template

```markdown
# v1.1.0 - 2026-02-15

## 🎉 Highlights
- Key feature 1
- Key feature 2
- Important fix

## ✨ New Features
- Feature A (#123)
- Feature B (#124)

## 🐛 Bug Fixes
- Fixed issue in component X (#125)
- Fixed memory leak in service Y (#126)

## 📈 Performance
- Improved query performance by 30%
- Reduced bundle size by 15%

## 💥 Breaking Changes
**Note**: This release includes breaking changes

- Endpoint `/api/v1/users` moved to `/api/v2/users`
  - See [Migration Guide](MIGRATION.md#v1-to-v2)

## 🔒 Security
- Fixed XSS vulnerability in markdown parser
- Updated dependencies with security patches

## 📦 Installation
```bash
npm install professional-project@1.1.0
```

## 🙏 Thanks
- Thanks to @contributor1 for feature X
- Thanks to @contributor2 for bug fix Y

## 📚 Full Changelog
[See all changes](https://github.com/username/project/compare/v1.0.0...v1.1.0)
```

## Rollback Procedure

If critical issues occur after release:

### Immediate Actions
1. Assess severity (P0, P1, P2)
2. Gather logs and error information
3. Identify root cause
4. Decide: Fix or Rollback?

### Rollback Steps

```bash
# Kubernetes rollback
kubectl rollout undo deployment/app-deployment

# Or roll back to specific version
kubectl set image deployment/app-deployment \
  app=registry.example.com/professional-project:1.0.0

# Monitor rollback
kubectl rollout status deployment/app-deployment

# Verify
kubectl logs -l app=professional-project -f
```

### Post-Rollback
- [ ] Create incident report
- [ ] Document root cause
- [ ] Plan fix
- [ ] Test thoroughly
- [ ] Plan new release

## Release Schedule

| Release Type | Frequency | Schedule |
|-------------|-----------|----------|
| Patch | Weekly | Monday 10 AM UTC |
| Minor | Bi-weekly | 1st Monday of month |
| Major | Quarterly | Feb, May, Aug, Nov |

## Maintenance Releases

### LTS (Long Term Support)
- Released for major versions
- Supported for 2 years
- Receive critical fixes only

### Regular
- Supported for 6 months
- Receive features and fixes

## Release Notes Template

See [Release Template](#version-release-template) above for detailed example.

## Tools & Automation

### Semantic Release
Automate versioning and releases:

```bash
npm install -D semantic-release
npx semantic-release
```

### Changelog Generation
```bash
npm install -D standard-version
npx standard-version
```

## Communication

- 📧 Email users about releases
- 🐦 Tweet about new releases
- 📝 Blog post for major releases
- 💬 Announce in Discord
- 📢 Changelog page updated

---

**Remember**: A well-planned release prevents issues and keeps users happy!
