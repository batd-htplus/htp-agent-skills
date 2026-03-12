---
title: Pagination Links
impact: MEDIUM
impactDescription: Link-based pagination improves client navigation
tags: rest, pagination, links, collections
---

## Pagination Links

**Impact: MEDIUM**

Collection responses SHOULD include navigational links alongside `meta`.

**Recommended:**

```json
{
  "data": [ ... ],
  "meta": { "page": 2, "limit": 25, "total": 134, "total_pages": 6 },
  "links": {
    "self": "/v1/users?page=2&limit=25",
    "next": "/v1/users?page=3&limit=25",
    "prev": "/v1/users?page=1&limit=25"
  }
}
```

**Incorrect:**

```
No pagination links for collections ❌
```
