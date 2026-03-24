---
title: Consistent Response Envelope
impact: HIGH
impactDescription: Inconsistent success shapes make clients brittle
tags: rest, response, envelope, data, meta, links
---

## Consistent Response Envelope

**Impact: HIGH**

Success responses SHOULD use a consistent envelope to keep client parsing predictable.

This rule applies to **successful** responses only. Error responses MUST follow `api-error-structure`.

**Recommended shape:**

```json
{
  "data": {},
  "meta": {},
  "links": {}
}
```

### Guidelines

- `data` — Required for responses that include a body (object or array).
- `meta` — Optional. Use for non-domain metadata (pagination, counts, warnings). Omit when not needed (do not return empty `{}`).
- `links` — Optional. Use for navigation (`self`, `next`, `prev`) or related resources. Omit when not needed.
- For `204 No Content` (e.g. DELETE), return **no body**.

**Correct (single resource):**

```json
{ "data": { "id": "u_123", "email": "a@example.com" } }
```

**Correct (collection + pagination):**

```json
{
  "data": [{ "id": "u_123" }, { "id": "u_456" }],
  "meta": { "page": 1, "limit": 20, "total": 57, "total_pages": 3 },
  "links": {
    "self": "/v1/users?page=1&limit=20",
    "next": "/v1/users?page=2&limit=20",
    "prev": null
  }
}
```

**Correct (delete):**

```
DELETE /v1/users/u_123 → 204 No Content    ✅ no body
```

```
200 /v1/users/{id} → { "data": { ... } }
GET /v1/users      → { "data": [ ... ], "meta": { ... }, "links": { ... } }
```

**Incorrect:**

```
{ "user": { ... } }                ❌ ad-hoc key
{ "result": { ... }, "ok": true }  ❌ inconsistent envelope
{ "data": { ... }, "error": { ... } } ❌ never mix success + error in one response
```

**Note:** Error responses are covered by `api-error-structure`.
