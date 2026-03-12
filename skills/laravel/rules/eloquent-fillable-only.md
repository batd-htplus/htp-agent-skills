---
title: Always Use $fillable (Never $guarded = [])
impact: CRITICAL
impactDescription: Using $guarded = [] opens all columns to mass assignment, creating security vulnerabilities.
tags: eloquent, security, mass-assignment, fillable
---

## Always Use $fillable (Never $guarded = [])

Always use `$fillable` with an explicit whitelist. Never use `$guarded = []` as it opens all columns to mass assignment.

**Why it matters:** Mass assignment vulnerabilities allow attackers to modify fields they shouldn't have access to (like `role`, `is_admin`, `balance`).

**❌ Incorrect:**

```php
// Opens all columns to mass assignment
protected $guarded = [];
```

**✅ Correct:**

```php
// Whitelist approach - explicit and secure
protected $fillable = [
    'name',
    'email',
    'password',
    'role',
    'avatar_url',
];
```

**Important:** Never include sensitive fields like `role`, `is_admin`, `balance` in `$fillable` unless the endpoint explicitly allows changing them.

**See also:** `security-fillable-only.md`, `eloquent-prevent-n-plus-one.md`
