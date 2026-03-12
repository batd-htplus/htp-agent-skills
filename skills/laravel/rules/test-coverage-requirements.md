---
title: Coverage Requirements
impact: CRITICAL
impactDescription: Feature tests must achieve ≥70% coverage, Unit tests ≥80%. Critical flows must have 100% coverage.
tags: testing, coverage, quality, metrics
---

## Coverage Requirements

Maintain minimum coverage thresholds to ensure code quality and catch bugs early.

**Why it matters:** Coverage metrics help identify untested code and ensure critical paths are tested.

| Test Type | Target | Scope |
|-----------|--------|-------|
| Feature Tests | ≥ 70% | All API endpoints |
| Unit Tests | ≥ 80% | Services, Repositories |
| Critical Flows | 100% | Auth, Payment, Order |

**Run with coverage:**

```bash
./vendor/bin/pest --coverage --min=80
```

**See also:** `test-refresh-database.md`, `test-naming-convention.md`
