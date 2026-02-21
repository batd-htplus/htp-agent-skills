---
title: Consistency and Predictability (Naming)
impact: MEDIUM
impactDescription: Inconsistent naming confuses clients and tooling
tags: rest, naming, kebab-case, plural, id
---

## Naming Conventions

**Impact: MEDIUM**

Naming MUST be consistent across all endpoints.

**URLs:** Lowercase only. Kebab-case for multi-word (`/user-profiles`). Plural for collections. No verbs. No trailing slash. Generic `{id}` (not `{userId}`); context comes from path. Max 2 levels of nesting.

**Correct:**

```
GET    /v1/products
GET    /v1/products/{id}
POST   /v1/products
PATCH  /v1/products/{id}
DELETE /v1/products/{id}
```

**Incorrect:**

```
/v1/Users          ❌ uppercase
/v1/getuser        ❌ verb + singular
/v1/user_profiles  ❌ snake_case in URLs
/v1/orderId/items  ❌ ID without parent resource
```

**Query params:** Use `page`, `limit`, `sort`, `order`, `filter[field]`, `from`, `to` (ISO 8601). Prefer snake_case for custom params (e.g. `sort_by=created_at`).

**JSON body/response:** Use snake_case for field names. Booleans: `is_active`, `has_children`. Dates: ISO 8601 with UTC (`created_at`, `updated_at`).
