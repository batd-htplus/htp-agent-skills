---
title: Pagination — Never Return All Records
impact: MEDIUM
impactDescription: Never use ->get() on potentially large result sets. Always paginate results.
tags: performance, pagination, memory, queries
---

## Pagination — Never Return All Records

Never use `->get()` on potentially large result sets. Always paginate results.

**Why it matters:** Loading all records into memory can cause memory exhaustion and slow responses.

**❌ Incorrect:**

```php
// Loads entire table into memory
$users = User::all();
```

**✅ Correct:**

```php
// Always paginate
$users = User::paginate(15);
$users = User::simplePaginate(15);  // Faster — no total count query

// Cursor pagination for very large tables
$users = User::orderBy('id')->cursorPaginate(20);
```

**See also:** `eloquent-chunk-large-datasets.md`, `perf-select-columns.md`
