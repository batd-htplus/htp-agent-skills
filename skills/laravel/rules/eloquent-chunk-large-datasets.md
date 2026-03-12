---
title: Chunk for Large Datasets
impact: MEDIUM
impactDescription: Never use ->get() on potentially large result sets. Use chunk() or lazy() to process data in batches.
tags: eloquent, performance, memory, large-datasets
---

## Chunk for Large Datasets

Never use `->get()` on potentially large result sets. Use `chunk()` or `lazy()` to process data in batches.

**Why it matters:** Loading all records into memory can cause memory exhaustion. Chunking processes data in manageable batches.

**❌ Incorrect:**

```php
// Loads all records into memory
$users = User::all();
foreach ($users as $user) {
    dispatch(new SendNewsletterJob($user));
}
```

**✅ Correct:**

```php
// Process in chunks
User::active()->chunk(200, function (Collection $users) {
    foreach ($users as $user) {
        dispatch(new SendNewsletterJob($user));
    }
});

// Or use lazy collection (cursor) - memory efficient
User::active()->lazy()->each(function (User $user) {
    // Process one at a time, memory efficient
    dispatch(new SendNewsletterJob($user));
});
```

**See also:** `perf-pagination.md`, `perf-select-columns.md`
