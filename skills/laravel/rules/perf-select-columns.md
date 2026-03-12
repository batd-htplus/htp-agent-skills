---
title: Select Only Required Columns
impact: MEDIUM
impactDescription: Never use SELECT *. Always select only the columns you actually need to reduce memory usage and improve performance.
tags: performance, queries, memory, optimization
---

## Select Only Required Columns

Never use `SELECT *`. Always select only the columns you actually need.

**Why it matters:** Selecting unnecessary columns wastes memory and bandwidth, especially with large tables or many relationships.

**❌ Incorrect:**

```php
// SELECT * (loads all columns)
$users = User::with('orders')->get();
```

**✅ Correct:**

```php
// Select specific columns
$users = User::select('id', 'name', 'email')
    ->with(['orders:id,user_id,total,status'])
    ->paginate(15);
```

**See also:** `eloquent-prevent-n-plus-one.md`, `perf-pagination.md`
