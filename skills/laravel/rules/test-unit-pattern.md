---
title: Unit Test Pattern for Services
impact: HIGH
impactDescription: Follow the standard Unit test pattern for testing services with proper mocking and isolation.
tags: testing, unit-tests, services, mocking
---

## Unit Test Pattern for Services

Follow the standard Unit test pattern for testing services with proper mocking and isolation.

**Why it matters:** Unit tests should test business logic in isolation without external dependencies.

**✅ Correct Pattern:**

```php
<?php

declare(strict_types=1);

namespace Tests\Unit\Services;

use App\Models\User;
use App\Repositories\Contracts\UserRepositoryInterface;
use App\Services\UserService;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\Event;
use Illuminate\Support\Facades\Hash;
use Tests\TestCase;

class UserServiceTest extends TestCase
{
    use RefreshDatabase;

    private UserService $service;
    private UserRepositoryInterface $repository;

    protected function setUp(): void
    {
        parent::setUp();
        $this->repository = $this->app->make(UserRepositoryInterface::class);
        $this->service    = new UserService($this->repository);
    }

    public function it_should_hash_password_when_creating_user(): void
    {
        Event::fake();

        $data = [
            'name'     => 'Test User',
            'email'    => 'test@example.com',
            'password' => 'plain-password',
        ];

        $user = $this->service->create($data);

        $this->assertNotEquals('plain-password', $user->password);
        $this->assertTrue(Hash::check('plain-password', $user->password));
    }

    public function it_should_fire_user_registered_event_on_create(): void
    {
        Event::fake([\App\Events\UserRegistered::class]);

        $this->service->create([
            'name'     => 'Test',
            'email'    => 'test@example.com',
            'password' => 'password',
        ]);

        Event::assertDispatched(\App\Events\UserRegistered::class);
    }
}
```

**See also:** `test-feature-pattern.md`, `test-mock-external.md`
