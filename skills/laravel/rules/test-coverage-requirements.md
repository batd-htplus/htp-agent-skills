---
title: Coverage Targets
impact: HIGH
impactDescription: Recommended coverage targets; document exceptions for legacy code or low-risk areas.
tags: testing, coverage, quality, metrics
---

## Coverage Targets

Aim for coverage targets to ensure code quality and catch bugs early. Document exceptions for legacy or low-risk areas.

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
