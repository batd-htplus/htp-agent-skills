---
title: Model Factories with States
impact: MEDIUM
impactDescription: Prefer factories with states for models used in tests; document exceptions.
tags: testing, factories, models, states
---

## Model Factories with States

Prefer factories with states for models used in tests. Document exceptions for models that are never instantiated in tests.

**Why it matters:** Factories with states make tests more readable and maintainable by providing semantic ways to create test data.

**✅ Correct Pattern:**

```php
// database/factories/UserFactory.php
<?php

declare(strict_types=1);

namespace Database\Factories;

use App\Enums\UserRole;
use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Facades\Hash;

class UserFactory extends Factory
{
    public function definition(): array
    {
        return [
            'name'              => fake()->name(),
            'email'             => fake()->unique()->safeEmail(),
            'email_verified_at' => now(),
            'password'          => Hash::make('password'), // always 'password'
            'role'              => UserRole::User,
            'is_active'         => true,
        ];
    }

    // ─── States ───────────────────────────────────────────────────

    public function admin(): static
    {
        return $this->state(['role' => UserRole::Admin]);
    }

    public function unverified(): static
    {
        return $this->state(['email_verified_at' => null]);
    }

    public function inactive(): static
    {
        return $this->state(['is_active' => false]);
    }
}
```

**Usage in tests:**

```php
$admin        = User::factory()->admin()->create();
$unverified   = User::factory()->unverified()->create();
$batchOfUsers = User::factory()->count(10)->create();
```

**See also:** `test-feature-pattern.md`, `test-unit-pattern.md`
