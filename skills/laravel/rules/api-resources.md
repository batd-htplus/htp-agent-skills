---
title: Prefer API Resources
impact: HIGH
impactDescription: Prefer JsonResource for consistent responses; document exceptions for internal/admin endpoints.
tags: api, resources, json-resource, transformation
---

## Prefer API Resources

Prefer `JsonResource` for consistent API responses. If you return raw models for internal/admin endpoints, document the exception.

**Why it matters:** API Resources provide consistent formatting, hide sensitive fields, and allow conditional inclusion of relationships.

**❌ Incorrect:**

```php
// Returns raw model - exposes all fields
return response()->json(User::all());
```

**✅ Correct:**

```php
// app/Http/Resources/UserResource.php
<?php

declare(strict_types=1);

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class UserResource extends JsonResource
{
    public function toArray(Request $request): array
    {
        return [
            'id'         => $this->id,
            'name'       => $this->name,
            'email'      => $this->email,
            'role'       => $this->role,
            'avatar_url' => $this->avatar_url,
            'created_at' => $this->created_at?->toISOString(),
            'updated_at' => $this->updated_at?->toISOString(),

            // Conditional: only load if relation was eager-loaded
            'orders'     => OrderResource::collection(
                $this->whenLoaded('orders')
            ),

            // Conditional: only include fields when appropriate
            // Never create tokens or perform side effects in a Resource
        ];
    }
}
```

**For collections:**

```php
// Paginated collection with meta
return response()->json([
    'success' => true,
    'data'    => [
        'items'      => UserResource::collection($users),
        'pagination' => [
            'current_page' => $users->currentPage(),
            'per_page'     => $users->perPage(),
            'total'        => $users->total(),
            'last_page'    => $users->lastPage(),
        ],
    ],
    ]);
```

**Token creation should happen in controller/service, not in Resource:**

```php
$token = $user->createToken('api');

return response()->json([
    'success' => true,
    'data'    => [
        'user'  => new UserResource($user),
        'token' => $token->plainTextToken,
    ],
]);
```

**See also:** `api-unified-response.md`, `api-form-requests.md`
