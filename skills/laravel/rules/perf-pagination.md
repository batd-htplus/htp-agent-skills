---
title: Pagination for Large Result Sets
impact: MEDIUM
impactDescription: Prefer pagination for potentially large result sets; document exceptions for small, bounded datasets.
tags: performance, pagination, memory, queries
---

## Pagination for Large Result Sets

Prefer pagination for potentially large result sets. If the dataset is small and bounded, document the exception.

**Why it matters:** Loading all records into memory can cause memory exhaustion and slow responses.

**❌ Incorrect:**

```php
// Loads entire table into memory
$users = User::all();
```

**✅ Correct:**

```php
// Prefer pagination
$users = User::paginate(15);
$users = User::simplePaginate(15);  // Faster — no total count query

// Cursor pagination for very large tables
$users = User::orderBy('id')->cursorPaginate(20);
```

**See also:** `eloquent-chunk-large-datasets.md`, `perf-select-columns.md`
