---
title: Select Only Required Columns
impact: MEDIUM
impactDescription: Prefer selecting only the columns you need; document exceptions for small internal queries.
tags: performance, queries, memory, optimization
---

## Select Only Required Columns

Prefer selecting only the columns you need. If you use `SELECT *` in small internal queries, document the exception.

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
