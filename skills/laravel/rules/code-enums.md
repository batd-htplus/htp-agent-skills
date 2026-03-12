---
title: PHP 8.1 Enums
impact: MEDIUM
impactDescription: Use native PHP 8.1 Enums instead of string/int constants for better type safety and IDE support.
tags: coding-standards, enums, php81, types
---

## PHP 8.1 Enums

Use native PHP 8.1 Enums instead of string/int constants for better type safety and IDE support.

**Why it matters:** Enums provide type safety, better IDE support, and prevent invalid values.

**❌ Incorrect:**

```php
// String constants - no type safety
class UserRole
{
    const ADMIN = 'admin';
    const USER = 'user';
}
```

**✅ Correct:**

```php
// app/Enums/UserRole.php
<?php

declare(strict_types=1);

namespace App\Enums;

enum UserRole: string
{
    case Admin     = 'admin';
    case User      = 'user';
    case Moderator = 'moderator';

    public function label(): string
    {
        return match($this) {
            self::Admin     => 'Administrator',
            self::User      => 'Regular User',
            self::Moderator => 'Moderator',
        };
    }
}
```

**Usage:**

```php
$user->role = UserRole::Admin;
if ($user->role === UserRole::Admin) { ... }
```

**See also:** `code-type-declarations.md`, `eloquent-fillable-only.md`
