---
title: Feature Test Pattern
impact: HIGH
impactDescription: Follow the standard Feature test pattern with proper setup, assertions, and cleanup.
tags: testing, feature-tests, pattern, api
---

## Feature Test Pattern

Follow the standard Feature test pattern with proper setup, assertions, and cleanup.

**Why it matters:** Consistent test patterns make tests easier to read, maintain, and debug.

**✅ Correct Pattern:**

```php
<?php

declare(strict_types=1);

namespace Tests\Feature\Api\V1;

use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class UserControllerTest extends TestCase
{
    use RefreshDatabase;

    // ─── index() ──────────────────────────────────────────────────

    public function it_should_return_paginated_users(): void
    {
        $admin = User::factory()->admin()->create();
        User::factory()->count(5)->create();

        $response = $this->actingAs($admin)
            ->getJson('/api/v1/users');

        $response
            ->assertOk()
            ->assertJsonStructure([
                'success',
                'data' => [
                    'items' => [
                        '*' => ['id', 'name', 'email', 'role', 'created_at'],
                    ],
                    'pagination' => [
                        'current_page', 'per_page', 'total', 'last_page',
                    ],
                ],
            ])
            ->assertJsonPath('success', true)
            ->assertJsonCount(5, 'data.items');
    }

    // ─── store() ──────────────────────────────────────────────────

    public function it_should_create_user_when_valid_data_provided(): void
    {
        $admin = User::factory()->admin()->create();

        $payload = [
            'name'                  => 'John Doe',
            'email'                 => 'nva@example.com',
            'password'              => 'Password@123',
            'password_confirmation' => 'Password@123',
        ];

        $response = $this->actingAs($admin)
            ->postJson('/api/v1/users', $payload);

        $response
            ->assertCreated()
            ->assertJsonPath('success', true)
            ->assertJsonPath('data.email', 'nva@example.com');

        $this->assertDatabaseHas('users', ['email' => 'nva@example.com']);
    }

    public function it_should_fail_when_email_is_duplicate(): void
    {
        $admin = User::factory()->admin()->create();
        User::factory()->create(['email' => 'exist@example.com']);

        $response = $this->actingAs($admin)
            ->postJson('/api/v1/users', [
                'name'                  => 'Test',
                'email'                 => 'exist@example.com',
                'password'              => 'Password@123',
                'password_confirmation' => 'Password@123',
            ]);

        $response
            ->assertUnprocessable()
            ->assertJsonPath('success', false)
            ->assertJsonValidationErrors(['email']);
    }

    public function it_should_return_401_when_not_authenticated(): void
    {
        $response = $this->postJson('/api/v1/users', []);
        $response->assertUnauthorized();
    }

    public function it_should_return_403_when_regular_user_creates(): void
    {
        $user = User::factory()->create(); // regular user

        $response = $this->actingAs($user)
            ->postJson('/api/v1/users', [
                'name'  => 'Test',
                'email' => 'test@example.com',
                'password' => 'Password@123',
                'password_confirmation' => 'Password@123',
            ]);

        $response->assertForbidden();
    }
}
```

**See also:** `test-unit-pattern.md`, `test-factories.md`, `references/assertion-cheatsheet.md`
