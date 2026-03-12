---
title: Idempotency & Retries
impact: HIGH
impactDescription: Safe retries prevent duplicate side effects
tags: rest, idempotency, retry, idempotency-key
---

## Idempotency & Retries

**Impact: HIGH**

For non-idempotent operations (typically POST create), support safe retries via `Idempotency-Key`.

**Correct:**

```
POST /v1/payments
Idempotency-Key: 6f1a2f7e-...
```

Server behavior:
- Store key + request hash + response
- Return the same response for duplicate keys within TTL

**Incorrect:**

```
POST /v1/payments
// no idempotency key for retryable clients ❌
```

**Note:** GET/PUT/DELETE are already idempotent by definition.
