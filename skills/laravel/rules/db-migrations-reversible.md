---
title: Reversible Migrations
impact: CRITICAL
impactDescription: Migrations should be reversible; document exceptions when rollbacks are not feasible.
tags: database, migrations, rollback
---

## Reversible Migrations

Migrations should be reversible. Implement the `down()` method to allow rollbacks; if not feasible, document the exception and mitigation.

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
