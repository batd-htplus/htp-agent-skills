---
title: Always Add SoftDeletes for Main Entities
impact: HIGH
impactDescription: Soft deletes allow data recovery and maintain referential integrity. Hard delete only for log/audit tables.
tags: eloquent, soft-deletes, models
---

## Always Add SoftDeletes for Main Entities

Every main entity model MUST use `SoftDeletes`. Hard delete is only allowed for log/audit tables.

**Why it matters:** Soft deletes allow data recovery, maintain audit trails, and preserve referential integrity.

**❌ Incorrect:**

```php
class Post extends Model
{
    // Missing SoftDeletes
}
```

**✅ Correct:**

```php
use Illuminate\Database\Eloquent\SoftDeletes;

class Post extends Model
{
    use SoftDeletes;
    // ...
}
```

**In migration:**

```php
$table->softDeletes(); // adds deleted_at column
```

**See also:** `db-migrations-only.md`, `eloquent-fillable-only.md`
