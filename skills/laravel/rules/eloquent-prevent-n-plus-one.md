---
title: Prevent N+1 Queries — Always Eager Load
impact: CRITICAL
impactDescription: This is the most common Laravel performance bug. Always eager load relationships to prevent N+1 queries.
tags: eloquent, performance, queries, relationships
---

## Prevent N+1 Queries — Always Eager Load

**This is the most common Laravel performance bug.** Always eager load relationships to prevent N+1 queries.

**Why it matters:** N+1 queries can cause hundreds of unnecessary database queries, severely impacting performance.

**❌ Incorrect:**

```php
// N+1: 1 query for users + 1 query per user for orders
$users = User::all();
foreach ($users as $user) {
    echo $user->orders->count(); // Separate query each iteration!
}
```

**✅ Correct:**

```php
// 2 queries total: users + orders
$users = User::with('orders')->paginate(15);

// Single query with subquery
$users = User::withCount('orders')->paginate(15);

// Conditional eager loading with constraints
$users = User::with([
    'orders' => fn($q) => $q->whereYear('created_at', now()->year),
    'profile',
])->paginate(15);
```

**Detection:** Use Laravel Telescope or Debugbar in development to detect N+1 queries.

**See also:** `perf-select-columns.md`, `perf-pagination.md`
