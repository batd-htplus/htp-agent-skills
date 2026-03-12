---
title: Authentication with Laravel Sanctum
impact: HIGH
impactDescription: Use Laravel Sanctum for SPA/mobile API tokens. Tokens should expire within 24 hours max.
tags: security, authentication, sanctum, tokens, api
---

## Authentication with Laravel Sanctum

Use Laravel Sanctum for SPA/mobile API tokens. Tokens should expire within 24 hours maximum.

**Why it matters:** Sanctum provides secure token-based authentication. Short token lifetimes reduce the impact of token theft.

**❌ Incorrect:**

```php
// No expiration - token never expires
$token = $user->createToken('api');
```

**✅ Correct:**

```php
// Token creation on login
$token = $user->createToken('api', ['*'], now()->addDay());

return response()->json([
    'success' => true,
    'data'    => [
        'token'      => $token->plainTextToken,
        'expires_at' => $token->accessToken->expires_at,
    ],
]);
```

**Protect routes:**

```php
Route::middleware('auth:sanctum')->group(function () {
    Route::apiResource('users', UserController::class);
});
```

**Token rules:**
- Access token expires in **24 hours** max
- Refresh token stored in **HttpOnly cookie**
- Revoke all tokens on password change

**See also:** `security-policies.md`, `api-unified-response.md`
