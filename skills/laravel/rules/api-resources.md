---
title: Always Use API Resources
impact: HIGH
impactDescription: Never return raw model arrays. Always transform with JsonResource for consistent API responses.
tags: api, resources, json-resource, transformation
---

## Always Use API Resources

Never return raw model arrays. Always transform with `JsonResource` for consistent API responses.

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

            // Conditional: only include in specific routes
            'token' => $this->when(
                $request->routeIs('v1.auth.*'),
                fn () => $this->createToken('api')->plainTextToken
            ),
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

**See also:** `api-unified-response.md`, `api-form-requests.md`
