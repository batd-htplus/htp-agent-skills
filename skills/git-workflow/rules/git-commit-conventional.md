---
title: Conventional Commits Format
impact: CRITICAL
impactDescription: Conventional Commits enable automated changelog generation, semantic versioning, and clear Git history. Format: <type>(<scope>): <subject>
tags: git, commits, conventional-commits, changelog
---

## Conventional Commits — Commit Message Format

Format: `<type>(<scope>): <subject>`

**Why it matters:** Conventional Commits enable automated changelog generation, semantic versioning, and make Git history clear and searchable.

**Structure:**

```
<type>(<scope>): <subject>

[optional body]

[optional footer]
```

**Types:**

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

**Rules:**
- Subject line: max **72 characters**
- Subject: **present tense**, **lowercase**, **no period** at end
- Body (optional): explain the **why**, not the how
- Breaking changes: append `!` after type and add `BREAKING CHANGE:` in footer

**❌ Incorrect:**

```bash
fix bug
WIP
update code
asdfgh
Fixed the thing
FEAT: new endpoint
```

**✅ Correct:**

```bash
feat(auth): add JWT refresh token endpoint
fix(order): correct total price calculation with discount
docs(api): update swagger docs for user endpoints
test(user): add feature tests for registration flow
refactor(payment): extract stripe logic to gateway service
perf(query): add index on orders.user_id column
chore(deps): upgrade laravel to 10.48.0
```

**Breaking change:**

```bash
feat(api)!: change user response format to include nested profile

BREAKING CHANGE: The `name` field is removed. Use `first_name` and `last_name` instead.
```

**See also:** `git-branch-naming.md`, `references/conventional-commits-cheatsheet.md`
