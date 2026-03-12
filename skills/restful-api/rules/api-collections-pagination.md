---
title: Collections Support Filtering, Sorting, Pagination
impact: HIGH
impactDescription: Unpaginated collections don't scale
tags: rest, collections, pagination, filter, sort
---

## Collections Support Filtering, Sorting, Pagination

**Impact: HIGH**

Collection endpoints MUST support query parameters for filtering, sorting, and pagination for large datasets. Document exceptions for small, bounded collections.

**Required query parameters:**

| Parameter | Example | Purpose |
|-----------|---------|---------|
| `page` | `?page=2` | Page number (1-indexed) |
| `limit` | `?limit=25` | Items per page |
| `sort` | `?sort=created_at` | Field to sort by |
| `order` | `?order=desc` | Sort direction |
| `filter[field]` | `?filter[status]=active` | Field-level filter |

**Response envelope:**

```json
{
  "data": [...],
  "meta": {
    "page": 2,
    "limit": 25,
    "total": 134,
    "total_pages": 6
  }
}
```

**Incorrect:**

- `GET /v1/users` returns all records with no pagination ❌
- Filtering done via POST body instead of query params ❌
- No `meta` or pagination info in collection response ❌
