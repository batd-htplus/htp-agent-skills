---
title: RESTful Route Conventions
impact: HIGH
impactDescription: Follow RESTful conventions for route naming and HTTP method usage.
tags: api, routes, rest, conventions
---

## RESTful Route Conventions

Follow RESTful conventions for route naming and HTTP method usage.

**Why it matters:** RESTful conventions make APIs predictable, intuitive, and easier to consume.

**Standard RESTful routes:**

```
GET    /api/v1/users              → index()   — list (paginated)
POST   /api/v1/users              → store()   — create
GET    /api/v1/users/{id}         → show()    — single resource
PUT    /api/v1/users/{id}         → update()  — full update
PATCH  /api/v1/users/{id}         → update()  — partial update
DELETE /api/v1/users/{id}         → destroy() — delete

GET    /api/v1/users/{id}/orders  → nested resource
```

**Use `apiResource()` for standard CRUD:**

```php
Route::apiResource('users', UserController::class);
```

**Define custom routes explicitly:**

```php
// Non-CRUD actions
Route::post('users/{user}/activate', [UserController::class, 'activate'])
    ->name('users.activate');
```

**See also:** `api-versioning.md`, `api-status-codes.md`
