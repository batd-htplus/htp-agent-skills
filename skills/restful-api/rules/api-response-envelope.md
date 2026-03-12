---
title: Consistent Response Envelope
impact: HIGH
impactDescription: Inconsistent success shapes make clients brittle
tags: rest, response, envelope, data, meta, links
---

## Consistent Response Envelope

**Impact: HIGH**

Success responses SHOULD use a consistent envelope to keep client parsing predictable.

**Recommended shape:**

```json
{
  "data": { },
  "meta": { },
  "links": { }
}
```

**Correct:**

```
200 /v1/users/{id} → { "data": { ... } }
GET /v1/users      → { "data": [ ... ], "meta": { ... }, "links": { ... } }
```

**Incorrect:**

```
{ "user": { ... } }                ❌ ad-hoc key
{ "result": { ... }, "ok": true }  ❌ inconsistent envelope
```

**Note:** Error responses are covered by `api-error-structure`.
