---
title: Machine-Readable Errors
impact: HIGH
impactDescription: Inconsistent errors prevent client logic and i18n
tags: rest, errors, error_code, validation
---

## Machine-Readable Errors

**Impact: HIGH**

Errors MUST follow a consistent, machine-readable structure with `error_code` and `message`.

**Required shape:**

```json
{
  "error": {
    "code": "RESOURCE_NOT_FOUND",
    "message": "The requested user does not exist.",
    "details": [
      { "field": "user_id", "issue": "No user found with this ID." }
    ]
  }
}
```

- `code` — Machine-readable constant (SCREAMING_SNAKE_CASE). Clients use for logic.
- `message` — Human-readable description.
- `details` — Optional array for field-level validation errors.

**Incorrect:**

```json
{ "msg": "not found" }                     ❌ no code
{ "error": true, "description": "..." }   ❌ no machine-readable code
{ "status": "fail" }                      ❌ useless to clients
```

**Standard codes (examples):** `USER_NOT_FOUND`, `USER_EMAIL_TAKEN`, `ORDER_ALREADY_CANCELLED`, `VALIDATION_ERROR`, `RATE_LIMIT_EXCEEDED`. Never expose stack traces or internal paths in 500 responses.
