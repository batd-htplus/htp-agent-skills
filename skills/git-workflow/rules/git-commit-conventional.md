---
title: Conventional Commits Format
impact: CRITICAL
impactDescription: Conventional Commits enable automated changelog generation, semantic versioning, and clear Git history. Format: <type>(<scope>): <subject>
tags: git, commits, conventional-commits, changelog
---

## Conventional Commits — Commit Message Format

Format: `<type>(<scope>): <subject>`

Use Conventional Commits for every non-merge commit.
This keeps history searchable, enables release automation, and improves PR review.

## Structure

```
<type>(<scope>): <subject>

[optional body]

[optional footer]
```

## Allowed Types

| Type | When to use |
|------|-------------|
| `feat` | New feature |
| `fix` | Bug fix |
| `docs` | Documentation only |
| `style` | Formatting, no logic change |
| `refactor` | Refactor (not feat/fix) |
| `perf` | Performance improvement |
| `test` | Add or update tests |
| `chore` | Maintenance, tooling |
| `ci` | CI/CD pipeline changes |
| `revert` | Revert a previous commit |

## Rules

- Subject line <= 72 characters
- Subject in imperative mood, lowercase, no trailing period
- Scope SHOULD be present and match touched area (`auth`, `api`, `payment`)
- Body SHOULD explain intent and impact, not implementation details
- Breaking change MUST use `!` and `BREAKING CHANGE:` footer

## Good Examples

```bash
feat(auth): add JWT refresh token endpoint
fix(order): correct total price calculation with discount
docs(api): update swagger docs for user endpoints
test(user): add feature tests for registration flow
refactor(payment): extract stripe logic to gateway service
perf(query): add index on orders.user_id column
chore(deps): upgrade laravel to 10.48.0
```

## Breaking Change Example

```bash
feat(api)!: change user response format to include nested profile

BREAKING CHANGE: The `name` field is removed. Use `first_name` and `last_name` instead.
```

## Invalid Patterns

- `WIP`, `update code`, `fix bug`, `asdf`
- Missing type or malformed prefix (`FEAT: ...`, `fixed: ...`)
- Multi-purpose commit that mixes unrelated scopes

## Commit Quality Gate

Before commit:

1. Commit contains one logical change set.
2. Message type/scope matches actual change.
3. Subject is specific enough to understand impact without opening diff.

**See also:** `git-branch-naming.md`, `references/conventional-commits-cheatsheet.md`
