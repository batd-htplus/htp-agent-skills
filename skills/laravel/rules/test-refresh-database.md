---
title: Use RefreshDatabase Trait
impact: CRITICAL
impactDescription: Tests that touch the database should use RefreshDatabase; document exceptions for performance-critical suites.
tags: testing, database, isolation, refresh
---

## Use RefreshDatabase Trait

Tests that touch the database should use `RefreshDatabase` to ensure isolation. If you use another strategy (transactions, dedicated DB), document the exception.

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
