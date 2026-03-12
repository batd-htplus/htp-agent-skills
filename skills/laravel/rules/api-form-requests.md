---
title: Prefer Form Request Validation
impact: HIGH
impactDescription: Prefer FormRequest classes for HTTP validation; document exceptions for console jobs or internal tooling.
tags: api, validation, form-request, controllers
---

## Prefer Form Request Validation

Prefer extracting validation to a `FormRequest` class. If you validate in the controller for small internal endpoints, document the exception.

**Why it matters:** FormRequests centralize validation logic, make it reusable, and keep controllers thin.

**❌ Incorrect:**

```php
public function store(Request $request): JsonResponse
{
    // Validation in controller - messy and not reusable
    $request->validate([
        'name' => 'required|string|max:255',
        'email' => 'required|email|unique:users',
    ]);
    
    $user = User::create($request->all());
}
```

**✅ Correct:**

```php
// app/Http/Requests/User/StoreUserRequest.php
<?php

declare(strict_types=1);

namespace App\Http\Requests\User;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rules\Password;

class StoreUserRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'name'     => ['required', 'string', 'max:255'],
            'email'    => ['required', 'email:rfc,dns', 'unique:users,email'],
            'password' => [
                'required',
                'confirmed',
                Password::min(8)
                    ->letters()
                    ->mixedCase()
                    ->numbers()
                    ->symbols()
                    ->uncompromised(),
            ],
            'role' => ['sometimes', 'string', 'in:admin,user,moderator'],
        ];
    }

    public function messages(): array
    {
        return [
            'email.unique'          => 'This email is already in use.',
            'password.confirmed'    => 'Password confirmation does not match.',
        ];
    }
}
```

**Controller:**

```php
public function store(StoreUserRequest $request): JsonResponse
{
    // Validation happens automatically
    $user = User::create($request->validated());
}
```

**See also:** `security-validate-input.md`, `api-resources.md`
