---
title: Machine-Readable Errors
impact: HIGH
impactDescription: Inconsistent errors prevent client logic and i18n
tags: rest, errors, error_code, validation
---

## Machine-Readable Errors

**Impact: HIGH**

Errors MUST follow a consistent, machine-readable structure with `error.code` and `error.message`.

**Required shape:**

```json
{
  "error": {
    "code": "RESOURCE_NOT_FOUND",
    "message": "The requested user does not exist.",
    "details": [
      { "field": "user_id", "issue": "No user found with this ID." }
    ],
    "request_id": "req_01J9..." 
  }
}
```

- `code` — Machine-readable constant (SCREAMING_SNAKE_CASE). Clients use it for logic.
- `message` — Human-readable description (safe to show to end users; do not leak internals).
- `details` — Optional array for field-level or item-level errors (validation, conflicts, partial failures).
- `request_id` — Recommended identifier to correlate logs/traces with support tickets (also commonly returned via `X-Request-Id` header).

### Details shape (recommended)

When `details` is present, each item SHOULD be an object with stable keys:

```json
{ "field": "email", "issue": "must be a valid email", "location": "body" }
```

Avoid nested ad-hoc strings/arrays that clients cannot reliably parse.

### Examples

**Validation error (422):**

```json
{
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Validation failed.",
    "details": [
      { "field": "email", "issue": "must be a valid email", "location": "body" }
    ],
    "request_id": "req_01J9..."
  }
}
```

**Rate limit (429):**

```json
{
  "error": {
    "code": "RATE_LIMIT_EXCEEDED",
    "message": "Too many requests.",
    "details": [],
    "request_id": "req_01J9..."
  }
}
```

**Incorrect:**

```json
{ "msg": "not found" }                     ❌ no code
{ "error": true, "description": "..." }   ❌ no machine-readable code
{ "status": "fail" }                      ❌ useless to clients
{ "error": "USER_NOT_FOUND" }             ❌ code must be structured, not overloaded
```

**Standard codes (examples):** `USER_NOT_FOUND`, `USER_EMAIL_TAKEN`, `ORDER_ALREADY_CANCELLED`, `VALIDATION_ERROR`, `RATE_LIMIT_EXCEEDED`.

Never expose stack traces, SQL queries, internal file paths, or infrastructure identifiers in 500 responses; keep `message` generic and use `request_id` for diagnosis.
