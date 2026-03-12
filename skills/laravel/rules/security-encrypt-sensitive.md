---
title: Encrypt Sensitive Data
impact: HIGH
impactDescription: Use Laravel's encryption for sensitive fields like API secrets, payment info, or personal data.
tags: security, encryption, sensitive-data, models
---

## Encrypt Sensitive Data

Use Laravel's `encrypt/decrypt` helpers or encrypted casts for sensitive fields.

**Why it matters:** Sensitive data should be encrypted at rest to protect against database breaches.

**❌ Incorrect:**

```php
// Stored in plain text
protected $fillable = ['api_secret', 'payment_info'];
```

**✅ Correct:**

```php
// In Model - use encrypted casts
protected $casts = [
    'api_secret'   => 'encrypted',
    'payment_info' => 'encrypted:array',
];

// Or manually encrypt/decrypt
$encrypted = encrypt($sensitiveData);
$decrypted = decrypt($encryptedData);
```

**See also:** `security-no-sensitive-logging.md`, `security-no-env-commit.md`
