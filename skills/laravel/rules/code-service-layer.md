---
title: Service Layer — Business Logic
impact: HIGH
impactDescription: Controllers must be thin. All business logic goes in Services. Controllers only resolve request, call service, return response.
tags: coding-standards, service-layer, architecture, controllers
---

## Service Layer — Business Logic

Controllers must be thin. All business logic goes in Services.

**Why it matters:** Service layer separates business logic from HTTP concerns, makes code reusable and testable.

**Service:**

```php
// app/Services/UserService.php
<?php

declare(strict_types=1);

namespace App\Services;

use App\Events\UserRegistered;
use App\Models\User;
use App\Repositories\Contracts\UserRepositoryInterface;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

class UserService
{
    public function __construct(
        private readonly UserRepositoryInterface $userRepository,
    ) {}

    public function create(array $data): User
    {
        return DB::transaction(function () use ($data): User {
            $data['password'] = Hash::make($data['password']);
            $user = $this->userRepository->create($data);
            event(new UserRegistered($user));

            return $user;
        });
    }
}
```

**Controller should only:**

1. Resolve the request
2. Call the service
3. Return the response

```php
public function store(StoreUserRequest $request): JsonResponse
{
    $user = $this->userService->create($request->validated());

    return response()->json([
        'success' => true,
        'data'    => new UserResource($user),
        'message' => 'User created successfully.',
    ], 201);
}
```

**See also:** `code-repository-pattern.md`, `api-form-requests.md`
