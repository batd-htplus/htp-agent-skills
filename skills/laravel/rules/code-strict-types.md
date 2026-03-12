---
title: Strict Types Declaration
impact: CRITICAL
impactDescription: Every PHP file MUST begin with declare(strict_types=1) to enable type safety at runtime.
tags: coding-standards, types, php, strict-types
---

## Strict Types Declaration

Every PHP file MUST begin with `declare(strict_types=1)`.

**Why it matters:** Strict types enable type safety at runtime, catch type errors early, and improve code reliability.

**❌ Incorrect:**

```php
<?php

namespace App\Services;
// Missing declare(strict_types=1)
```

**✅ Correct:**

```php
<?php

declare(strict_types=1);

namespace App\Services;
```

**Never omit this.** It enables type safety at runtime.

**See also:** `code-type-declarations.md`, `code-psr-12.md`
