---
title: Constructor Property Promotion with readonly
impact: HIGH
impactDescription: Use PHP 8.1 readonly constructor promotion for injected dependencies to reduce boilerplate.
tags: coding-standards, php81, constructor, readonly
---

## Constructor Property Promotion with readonly

Use PHP 8.1 `readonly` constructor promotion for injected dependencies.

**Why it matters:** Constructor promotion reduces boilerplate code and makes dependencies immutable.

**❌ Incorrect:**

```php
// Old style - verbose
private UserRepository $userRepository;

public function __construct(UserRepository $userRepository)
{
    $this->userRepository = $userRepository;
}
```

**✅ Correct:**

```php
// PHP 8.1 readonly promotion
public function __construct(
    private readonly UserRepository $userRepository,
    private readonly MailService $mailService,
) {}
```

**See also:** `code-type-declarations.md`, `code-repository-pattern.md`
