---
title: API Versioning in URL
impact: CRITICAL
impactDescription: All routes MUST be prefixed with version (/api/v1/) to allow breaking changes without breaking existing clients.
tags: api, versioning, routes, breaking-changes
---

## API Versioning in URL

All routes MUST be prefixed with version to allow breaking changes without breaking existing clients.

**Why it matters:** Versioning allows you to introduce breaking changes while maintaining backward compatibility for existing API consumers.

**❌ Incorrect:**

```php
// No versioning - breaking changes break all clients
Route::apiResource('users', UserController::class);
```

**✅ Correct:**

```php
// routes/api.php
Route::prefix('v1')->name('v1.')->group(function () {
    require __DIR__ . '/api/v1.php';
});

Route::prefix('v2')->name('v2.')->group(function () {
    require __DIR__ . '/api/v2.php';
});
```

```php
// routes/api/v1.php
use App\Http\Controllers\Api\V1\UserController;

Route::middleware('auth:sanctum')->group(function () {
    Route::apiResource('users', UserController::class);
    Route::apiResource('users.orders', UserOrderController::class);
});
```

**URLs:**
```
/api/v1/users
/api/v1/users/{id}
/api/v2/users        ← New version with breaking changes
```

**See also:** `api-unified-response.md`, `api-restful-routes.md`
