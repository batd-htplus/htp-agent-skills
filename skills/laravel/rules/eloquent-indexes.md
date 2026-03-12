---
title: Index Strategy for Performance
impact: HIGH
impactDescription: Proper indexing dramatically improves query performance. Add indexes for foreign keys, WHERE clauses, and ORDER BY columns.
tags: database, performance, indexes, queries
---

## Index Strategy for Performance

Add indexes for columns used in queries to dramatically improve performance.

**Why it matters:** Indexes speed up WHERE, JOIN, and ORDER BY operations. Missing indexes cause full table scans.

**Index when:**
- Foreign keys (`user_id`, `order_id`)
- Columns used in `WHERE` clauses (`status`, `email`, `slug`)
- Columns used in `ORDER BY` (`created_at`, `published_at`)
- For `LIKE` searches → use full-text index instead

**❌ Incorrect:**

```php
// No indexes - slow queries
Schema::create('posts', function (Blueprint $table) {
    $table->id();
    $table->foreignId('user_id')->constrained();
    $table->string('status');
    $table->timestamp('created_at');
});
```

**✅ Correct:**

```php
Schema::create('posts', function (Blueprint $table) {
    $table->id();
    $table->foreignId('user_id')->constrained()->cascadeOnDelete();
    $table->string('status');
    $table->text('body');
    $table->timestamps();

    // Indexes for performance
    $table->index('user_id');
    $table->index('status');
    $table->index(['status', 'created_at']); // composite index
    $table->fullText('body');                 // for search
});
```

**See also:** `perf-select-columns.md`, `perf-pagination.md`
