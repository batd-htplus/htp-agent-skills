---
title: Caching & ETags
impact: MEDIUM
impactDescription: Improves performance and reduces bandwidth for cacheable GET responses.
tags: rest, api, http, caching, etag, conditional-requests
---

## Caching & ETags

**Impact: MEDIUM (performance and scalability)**

For cacheable `GET` endpoints, APIs SHOULD support conditional requests:

- Include an `ETag` on successful `GET` responses
- Accept `If-None-Match` and return `304 Not Modified` when unchanged
- Avoid using ETags for endpoints with highly volatile responses unless the semantics are clear

**Incorrect (always returns full payload):**

```
GET /v1/users/u_123    ❌ no ETag; clients must re-download every time
200 OK
{ "data": { "id": "u_123", "name": "alice" } }
```

**Correct (conditional GET):**

```
GET /v1/users/u_123
200 OK
ETag: "v7"    ✅ enables conditional requests
{ "data": { "id": "u_123", "name": "alice" } }
```

```
GET /v1/users/u_123
If-None-Match: "v7"

304 Not Modified    ✅ no body needed
```

Reference: [MDN — ETag](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/ETag)
