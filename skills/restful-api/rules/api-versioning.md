---
title: Explicit Versioning
impact: HIGH
impactDescription: No versioning makes breaking changes unsafe
tags: rest, versioning, v1, breaking
---

## Explicit Versioning

**Impact: HIGH**

Prefer URI versioning for breaking changes. Header versioning is acceptable if documented and consistently applied.

**Correct:**

```
/v1/users
/v2/users
```

**When to bump version (breaking):** Removing or renaming a field, changing field type, changing HTTP method for an endpoint, adding a new required request field.

**Non-breaking (no version bump):** Adding optional response field, new endpoint, new optional query parameter.

**Incorrect:**

- No versioning at all ❌
- Query param versioning (`?version=2`) — fragile, avoid ❌
- Minor in URL (`/v1.0/`) — over-engineered for most APIs ❌

Header versioning (`Accept: application/vnd.api.v2+json`) is an acceptable alternative but must be documented and consistently applied.
