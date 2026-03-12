---
title: Always Implement down() in Migrations
impact: CRITICAL
impactDescription: Every migration must be reversible to allow rollbacks and maintain database consistency.
tags: database, migrations, rollback
---

## Always Implement down() in Migrations

Every migration must be reversible. Always implement the `down()` method to allow rollbacks.

**Why it matters:** Reversible migrations allow safe rollbacks, maintain database consistency, and enable proper version control.

**❌ Incorrect:**

```php
return new class extends Migration
{
    public function up(): void
    {
        Schema::create('posts', function (Blueprint $table) {
            $table->id();
            $table->string('title');
        });
    }

    // Missing down() method!
};
```

**✅ Correct:**

```php
return new class extends Migration
{
    public function up(): void
    {
        Schema::create('posts', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained()->cascadeOnDelete();
            $table->string('title');
            $table->text('body');
            $table->string('status')->default('draft');
            $table->timestamps();
            $table->softDeletes();

            $table->index('user_id');
            $table->index('status');
            $table->index('created_at');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('posts');
    }
};
```

**See also:** `db-migrations-only.md`, `references/migration-naming.md`
