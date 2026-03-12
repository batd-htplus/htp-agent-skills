---
title: Never Log Sensitive Data
impact: HIGH
impactDescription: Never log passwords, tokens, card numbers, or personally identifiable information (PII).
tags: security, logging, sensitive-data, privacy
---

## Never Log Sensitive Data

Never log passwords, tokens, card numbers, or personally identifiable information (PII).

**Why it matters:** Logs can be accessed by unauthorized users. Logging sensitive data creates security and privacy risks.

**❌ Incorrect:**

```php
// Logs password in plain text
Log::info('Login attempt', ['email' => $email, 'password' => $password]);
```

**✅ Correct:**

```php
// Never log passwords, tokens, card numbers, PII
Log::info('Login attempt', [
    'email'      => $email,
    'ip'         => $request->ip(),
    'user_agent' => $request->userAgent(),
]);
```

**See also:** `security-encrypt-sensitive.md`, `security-no-error-details-production.md`
