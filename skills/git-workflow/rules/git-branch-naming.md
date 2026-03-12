---
title: Branch Naming Convention
impact: CRITICAL
impactDescription: Consistent branch naming makes Git history easier to navigate and enables automated tooling. Format: <type>/<ticket-id>-<short-description>
tags: git, branches, naming, conventions
---

## Branch Naming Convention

Format: `<type>/<ticket-id>-<short-description>`

**Why it matters:** Consistent branch naming makes Git history easier to navigate, enables automated tooling, and helps team members understand branch purpose at a glance.

**Branch types:**

| Type | When to use | Example |
|------|-------------|---------|
| `feature/` | New functionality | `feature/AUTH-123-user-login` |
| `bugfix/` | Non-urgent bug fix | `bugfix/ORDER-456-fix-total-price` |
| `hotfix/` | Urgent production fix | `hotfix/PAY-789-stripe-timeout` |
| `release/` | Release preparation | `release/v2.1.0` |
| `chore/` | Maintenance, deps | `chore/upgrade-laravel-10` |
| `refactor/` | Code refactoring | `refactor/extract-payment-service` |
| `docs/` | Documentation only | `docs/update-api-swagger` |

**❌ Incorrect:**

```bash
fix-bug
my-feature
john/update
wip-auth
```

**✅ Correct:**

```bash
feature/AUTH-123-user-login
bugfix/ORDER-456-fix-total-price
hotfix/PAY-789-stripe-timeout
```

**See also:** `git-pr-workflow.md`, `git-flow-lifecycle.md`
