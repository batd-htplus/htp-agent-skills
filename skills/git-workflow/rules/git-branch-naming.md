---
title: Branch Naming Convention
impact: CRITICAL
impactDescription: Branch name must be ticket-centric for traceability and clean filtering. Default format: <type>/<ticket-id>; optional short suffix only when needed.
tags: git, branches, naming, conventions
---

## Branch Naming Convention

Default format: `<type>/ID-<number>`
Optional format: `<type>/ID-<number>-<short-slug>`

Ticket ID is the primary identifier. Use one unified ticket prefix `ID-` for all tracked work.

## Rules

- If work is tied to a ticket, branch MUST include that ticket ID.
- Use `type/ID-<number>` as default naming style.
- Add `-<short-slug>` only when disambiguation is necessary.
- Keep slug <= 3 words and lowercase-kebab-case.
- Never omit ticket ID for feature/bugfix/hotfix/refactor/docs work.

## Branch types

| Type | Ticket Link | When to use | Example |
|------|-------------|-------------|---------|
| `feature/` | Required | New functionality | `feature/ID-12345` |
| `bugfix/` | Required | Non-urgent bug fix | `bugfix/ID-12345` |
| `hotfix/` | Required | Urgent production fix | `hotfix/ID-12345` |
| `refactor/` | Required (default) | Code refactoring tied to work item | `refactor/ID-12345` |
| `docs/` | Required (default) | Documentation tied to ticket/spec | `docs/ID-12345` |
| `chore/` | Optional (policy-based) | Maintenance, dependency updates | `chore/upgrade-laravel-10` |
| `release/` | Optional (policy-based) | Release preparation | `release/v2.1.0` |

If team policy tracks `chore/` or `release/` with tickets, use `chore/ID-<number>` and `release/ID-<number>`.

## Invalid

```bash
fix-bug
my-feature
john/update
wip-auth
feature/user-login
bugfix/fix-total-price
feature/AUTH-123
```

## Valid

```bash
feature/ID-12345
bugfix/ID-12345
hotfix/ID-12345-timeout
refactor/ID-12345-split-payment-gateway
```

**See also:** `git-pr-workflow.md`, `git-flow-lifecycle.md`
