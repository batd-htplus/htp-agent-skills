---
title: Type Declarations on All Methods
impact: CRITICAL
impactDescription: All method parameters and return types MUST be declared for type safety and better IDE support.
tags: coding-standards, types, php, type-hints
---

## Type Declarations on All Methods

All method parameters and return types MUST be declared.

**Why it matters:** Type declarations catch errors at development time, improve IDE support, and make code self-documenting.

**❌ Incorrect:**

```php
// Missing type hints
public function findById($id)
{
    return User::find($id);
}

public function getActiveUsers($limit = 20)
{
    return User::active()->limit($limit)->get();
}
```

**✅ Correct:**

```php
// All types declared
public function findById(int $id): ?User
{
    return User::find($id);
}

public function getActiveUsers(int $limit = 20): Collection
{
    return User::active()->limit($limit)->get();
}
```

**See also:** `code-strict-types.md`, `code-constructor-promotion.md`
