# Code Review Guidelines

Guidelines for reviewers and authors to ensure high-quality code reviews.

## For Pull Request Authors

### Before Submitting
- [ ] Run tests locally: `npm test`
- [ ] Run linter: `npm run lint`
- [ ] Format code: `npm run format`
- [ ] Update documentation
- [ ] Add/update tests for changes
- [ ] Keep PR focused (avoid mixing unrelated changes)
- [ ] Provide clear description of changes

### Creating a Good PR Description
```markdown
## Description
Brief overview of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Related Issues
Closes #123

## Testing
Describe testing performed

## Checklist
- [ ] Tests pass
- [ ] No linting errors
- [ ] Documentation updated
- [ ] Breaking changes documented
```

### PR Size Guidelines
- **Small**: < 200 lines of code changes
- **Medium**: 200-500 lines
- **Large**: 500-1000 lines (may require multiple reviews)
- **Very Large**: > 1000 lines (should be split)

### Responding to Feedback
- Respond promptly to comments
- Explain your reasoning if you disagree
- Make requested changes or discussion alternatives
- Request re-review after making changes
- Don't dismiss feedback without discussion

## For Code Reviewers

### Review Principles
1. **Be Respectful** - Treat authors and their code with respect
2. **Be Clear** - Provide constructive feedback with reasoning
3. **Be Helpful** - Suggest improvements or alternatives
4. **Be Thorough** - Check logic, security, performance, tests
5. **Be Timely** - Review within 24-48 hours when possible

### Review Checklist
- [ ] Code follows style guidelines
- [ ] No obvious bugs or issues
- [ ] Tests are adequate and passing
- [ ] Documentation is clear and updated
- [ ] No performance regressions
- [ ] No security vulnerabilities
- [ ] No unnecessary complexity
- [ ] Breaking changes are documented

### What to Look For

#### Functionality
- Does the code do what it's supposed to?
- Are edge cases handled?
- Is error handling appropriate?

#### Code Quality
- Is the code readable and maintainable?
- Are variable/function names clear?
- Is there unnecessary duplication?
- Could logic be simplified?

#### Testing
- Are tests comprehensive?
- Do tests cover happy path and edge cases?
- Are tests maintainable?
- Is coverage adequate?

#### Performance
- Are there performance issues?
- Could queries be optimized?
- Are algorithms efficient?
- Is memory usage appropriate?

#### Security
- Are inputs validated?
- Is sensitive data protected?
- Are there injection vulnerabilities?
- Are authentication/authorization correct?

#### Documentation
- Is code self-documenting?
- Are complex sections commented?
- Is public API documented?
- Are breaking changes noted?

### Comment Guidelines

#### Constructive Comments
```
"This logic could be simplified with Array.find() instead of 
looping and checking each item. See example: ..."
```

#### Problematic Comments
```
"This is wrong"
"Why would you do it this way?"
"Bad variable name"
```

### Approval Standards

Approve when:
- ✅ All review items addressed
- ✅ Tests pass and are adequate
- ✅ Code quality is good
- ✅ No unresolved questions
- ✅ Breaking changes documented (if applicable)

Request changes when:
- ❌ Critical issues or bugs
- ❌ Insufficient test coverage
- ❌ Security concerns
- ❌ Breaking changes not documented
- ❌ Major code quality issues

Comment when:
- 💬 Minor suggestions
- 💬 Questions to author
- 💬 Compliments (specific)
- 💬 Alternative approaches

### Building Relationships

**Be Constructive**
```
"Have you considered using X? It might be clearer than Y."
```

**Explain Your Reasoning**
```
"This could be a performance issue because [reason]. 
Consider [alternative]."
```

**Acknowledge Good Work**
```
"Nice refactor! The code is much clearer now."
```

**Learn from Disagreements**
```
"I hadn't thought of it that way. Help me understand 
your approach."
```

## Review Turnaround

| Priority | Target Time | Maximum Time |
|----------|-------------|--------------|
| Critical Fix | 2 hours | 4 hours |
| Bug Fix | 4 hours | 12 hours |
| Feature | 24 hours | 48 hours |
| Documentation | 24 hours | 72 hours |
| Refactor | 48 hours | 1 week |

## Special Cases

### Large PRs
- May require longer review time
- Prefer to split into smaller PRs
- May be reviewed by multiple reviewers
- Schedule focused review session if needed

### Security-Related PRs
- Requires security team review
- May need additional testing
- Must include security implications

### Breaking Changes
- Must be clearly documented
- Requires migration guide
- May need version coordination
- Should have deprecation period when possible

### Performance Changes
- Should include benchmarks
- May need performance review
- Document performance impact

## Tools & Automation

### Automated Checks
- Unit tests must pass
- Linting must pass
- Code coverage must be adequate
- Build must succeed

### Review Tools
- Use GitHub review features
- Suggest code changes directly
- Request specific reviewers
- Use conversation threading

## Escalation

If disagreement occurs:
1. Discuss in review comments
2. Schedule sync discussion
3. Involve maintainer if needed
4. Document decision

## Training & Development

### For New Reviewers
- Start with small PRs
- Observe experienced reviewers
- Ask questions in reviews
- Get feedback on your reviews

### For Authors
- Start with small PRs
- Learn from feedback
- Ask questions when unclear
- Review others' code

---

**Remember**: The goal is to write great code together, not to be "right."
