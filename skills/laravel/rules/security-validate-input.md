---
title: Always Validate Input
impact: HIGH
impactDescription: All input MUST be validated before use. Use FormRequest for validation with security-focused rules.
tags: security, validation, input, form-request
---

## Always Validate Input

All input MUST be validated before use. Use `FormRequest` for validation (see `api-form-requests.md`).

**Why it matters:** Unvalidated input is a major security risk. Validation prevents injection attacks, data corruption, and ensures data integrity.

**Extra security rules:**

```php
// Email validation with DNS check
'email' => ['required', 'email:rfc,dns'],

// File upload validation
'avatar' => ['required', 'image', 'mimes:jpg,jpeg,png', 'max:2048'],

// Slug must be safe
'slug' => ['required', 'string', 'regex:/^[a-z0-9-]+$/'],
```

**❌ Incorrect:**

```php
public function store(Request $request): JsonResponse
{
    // No validation - dangerous!
    $user = User::create($request->all());
}
```

**✅ Correct:**

```php
public function store(StoreUserRequest $request): JsonResponse
{
    // FormRequest validates automatically
    $user = User::create($request->validated());
}
```

**See also:** `api-form-requests.md`, `security-no-sql-concatenation.md`
