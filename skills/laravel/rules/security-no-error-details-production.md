---
title: Never Expose Error Details in Production
impact: CRITICAL
impactDescription: Error details in production expose sensitive information about your application structure and vulnerabilities.
tags: security, errors, production, debugging
---

## Never Expose Error Details in Production

Never expose detailed error messages in production. Set `APP_DEBUG=false` and handle errors gracefully.

**Why it matters:** Error details expose application structure, file paths, database schema, and potential vulnerabilities to attackers.

**❌ Incorrect:**

```php
// app/Exceptions/Handler.php
default => response()->json([
    'message' => $e->getMessage(), // Exposes details in production!
], 500),
```

**✅ Correct:**

```php
// app/Exceptions/Handler.php
default => response()->json([
    'success' => false,
    'message' => app()->isProduction()
        ? 'Internal server error.'   // ✅ Safe for production
        : $e->getMessage(),           // ✅ Full detail in dev
], 500),
```

**Configuration:** Always set `APP_DEBUG=false` in production `.env`:

```env
APP_DEBUG=false
APP_ENV=production
```

**See also:** `security-no-sensitive-logging.md`, `api-unified-response.md`
