# API Response Examples

## Standard Controller Template

```php
<?php

declare(strict_types=1);

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Http\Requests\User\StoreUserRequest;
use App\Http\Requests\User\UpdateUserRequest;
use App\Http\Resources\UserResource;
use App\Services\UserService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class UserController extends Controller
{
    public function __construct(
        private readonly UserService $userService,
    ) {}

    public function index(Request $request): JsonResponse
    {
        $users = $this->userService->paginate(
            perPage: (int) $request->get('per_page', 15)
        );

        return response()->json([
            'success' => true,
            'data'    => [
                'items'      => UserResource::collection($users),
                'pagination' => [
                    'current_page' => $users->currentPage(),
                    'per_page'     => $users->perPage(),
                    'total'        => $users->total(),
                    'last_page'    => $users->lastPage(),
                    'from'         => $users->firstItem(),
                    'to'           => $users->lastItem(),
                ],
            ],
        ]);
    }

    public function store(StoreUserRequest $request): JsonResponse
    {
        $user = $this->userService->create($request->validated());

        return response()->json([
            'success' => true,
            'message' => 'User created successfully.',
            'data'    => new UserResource($user),
        ], 201);
    }

    public function show(int $id): JsonResponse
    {
        $user = $this->userService->findOrFail($id);

        return response()->json([
            'success' => true,
            'data'    => new UserResource($user),
        ]);
    }

    public function update(UpdateUserRequest $request, int $id): JsonResponse
    {
        $user = $this->userService->update($id, $request->validated());

        return response()->json([
            'success' => true,
            'message' => 'User updated successfully.',
            'data'    => new UserResource($user),
        ]);
    }

    public function destroy(int $id): JsonResponse
    {
        $this->userService->delete($id);

        return response()->json([
            'success' => true,
            'message' => 'User deleted successfully.',
        ]);
    }
}
```

## Error Response Examples

```json
// 401 Unauthorized
{
    "success": false,
    "message": "Unauthenticated."
}

// 403 Forbidden
{
    "success": false,
    "message": "This action is unauthorized."
}

// 404 Not Found
{
    "success": false,
    "message": "User not found."
}

// 422 Validation Error
{
    "success": false,
    "message": "Validation failed.",
    "errors": {
        "email": ["The email field is required.", "The email must be a valid email address."],
        "password": ["The password must be at least 8 characters."]
    }
}

// 429 Rate Limited
{
    "success": false,
    "message": "Too Many Attempts."
}

// 500 Server Error (production — never expose details)
{
    "success": false,
    "message": "Internal server error."
}
```
