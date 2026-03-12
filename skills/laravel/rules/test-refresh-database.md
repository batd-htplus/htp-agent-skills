---
title: Use RefreshDatabase Trait
impact: CRITICAL
impactDescription: Every test class that touches the database MUST use RefreshDatabase to ensure test isolation.
tags: testing, database, isolation, refresh
---

## Use RefreshDatabase Trait

Every test class that touches the database MUST use `RefreshDatabase` to ensure test isolation.

**Why it matters:** RefreshDatabase ensures each test starts with a clean database state, preventing test interdependencies.

**❌ Incorrect:**

```php
class UserControllerTest extends TestCase
{
    // Missing RefreshDatabase - tests may interfere with each other
}
```

**✅ Correct:**

```php
use Illuminate\Foundation\Testing\RefreshDatabase;

class UserControllerTest extends TestCase
{
    use RefreshDatabase;
    // ...
}
```

**See also:** `test-coverage-requirements.md`, `test-feature-pattern.md`
