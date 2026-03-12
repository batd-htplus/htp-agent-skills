---
title: Authentication with Laravel Sanctum
impact: HIGH
impactDescription: Use Laravel Sanctum for SPA or API token authentication. Token lifetime is a policy choice.
tags: security, authentication, sanctum, tokens, api
---

## Authentication with Laravel Sanctum

Use Laravel Sanctum for SPA or API token authentication. Token lifetime should follow your org security policy.

**Why it matters:** Sanctum provides secure token-based authentication. Short token lifetimes reduce the impact of token theft.

**✅ Correct:**

```php
// Token creation on login (personal access token)
$token = $user->createToken('api');

return response()->json([
    'success' => true,
    'data'    => [
        'token' => $token->plainTextToken,
    ],
]);
```

**Protect routes:**

```php
Route::middleware('auth:sanctum')->group(function () {
    Route::apiResource('users', UserController::class);
});
```

**Token rules (policy-driven):**
- Define a token lifetime policy for your org
- Revoke tokens on password change or account compromise
- If you require expiration, document how it is enforced for your Laravel/Sanctum version

**See also:** `security-policies.md`, `api-unified-response.md`
