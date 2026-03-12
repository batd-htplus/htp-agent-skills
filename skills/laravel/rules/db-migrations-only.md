---
title: Never Modify Database Directly
impact: CRITICAL
impactDescription: All schema changes MUST go through migration files. Never use DB::statement to alter tables or run DDL manually in production.
tags: database, migrations, schema
---

## Never Modify Database Directly

All schema changes MUST go through migration files. Never use `DB::statement` to alter tables or run DDL manually in production.

**Why it matters:** Migrations provide version control for your database schema, allow rollbacks, and ensure consistency across environments.

**❌ Incorrect:**

```php
// Never do this in production code
DB::statement('ALTER TABLE users ADD COLUMN avatar_url VARCHAR(255)');
```

**✅ Correct:**

```bash
# Always create a migration
php artisan make:migration add_avatar_url_to_users_table
```

```php
// In the migration file
public function up(): void
{
    Schema::table('users', function (Blueprint $table) {
        $table->string('avatar_url')->nullable()->after('email');
    });
}

public function down(): void
{
    Schema::table('users', function (Blueprint $table) {
        $table->dropColumn('avatar_url');
    });
}
```

**See also:** `db-migrations-reversible.md`, `references/migration-naming.md`
