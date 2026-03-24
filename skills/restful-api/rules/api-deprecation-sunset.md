---
title: Deprecation & Sunset
impact: MEDIUM
impactDescription: Reduces breaking-change risk and provides predictable migration for clients.
tags: rest, api, http, deprecation, sunset, versioning
---

## Deprecation & Sunset

**Impact: MEDIUM (client stability)**

When removing or changing behavior in a breaking way:

- Announce deprecation before removal
- Provide a concrete sunset date/time
- Include a migration link (docs, changelog, or upgrade guide)

Prefer additive changes within a version; use `/v2/` for breaking changes (see `api-versioning`).

**Incorrect (breaking changes with no notice):**

```
GET /v1/users/{id}    ❌ field removed with no warning
200 OK
{ "data": { "id": "u_123" } }
```

**Correct (explicit deprecation headers + migration guidance):**

```
GET /v1/users/{id}
200 OK
Deprecation: true    ✅ endpoint/field is deprecated
Sunset: Wed, 01 Jul 2026 00:00:00 GMT    ✅ removal date
Link: </docs/migrations/v1-to-v2>; rel="deprecation"    ✅ migration guidance
{ "data": { "id": "u_123", "display_name": "alice" } }
```

Reference: [MDN — Sunset header](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Sunset)
