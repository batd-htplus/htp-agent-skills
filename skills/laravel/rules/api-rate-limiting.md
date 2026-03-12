---
title: Rate Limiting
impact: MEDIUM
impactDescription: Apply rate limiting to endpoints to prevent abuse and ensure fair usage.
tags: api, rate-limiting, security, throttling
---

## Rate Limiting

Define named rate limiters and apply them to endpoints to prevent abuse.

**Why it matters:** Rate limiting prevents API abuse, protects against DDoS attacks, and ensures fair resource usage.

**Define rate limiters in `RouteServiceProvider`:**

```php
RateLimiter::for('api', function (Request $request) {
    return Limit::perMinute(60)->by(
        $request->user()?->id ?: $request->ip()
    );
});

RateLimiter::for('auth', function (Request $request) {
    return Limit::perMinute(5)->by($request->ip());
});
```

**Apply in routes:**

```php
Route::middleware(['auth:sanctum', 'throttle:api'])->group(function () {
    Route::apiResource('users', UserController::class);
});

Route::middleware('throttle:auth')->prefix('auth')->group(function () {
    Route::post('login', [AuthController::class, 'login']);
});
```

**See also:** `security-sanctum-auth.md`, `api-unified-response.md`
