---
title: Repository Pattern
impact: HIGH
impactDescription: All database access MUST go through a Repository. Direct Eloquent calls in Controllers or Services are not allowed.
tags: coding-standards, repository, architecture, database
---

## Repository Pattern

Default: database access goes through a Repository. Direct Eloquent calls in Controllers or Services should be avoided.
Exception: small read-only endpoints or internal tools may use Eloquent directly if justified in code review.

**Why it matters:** Repository pattern abstracts database access, makes code testable, and allows switching implementations.

**Interface:**

```php
// app/Repositories/Contracts/UserRepositoryInterface.php
<?php

declare(strict_types=1);

namespace App\Repositories\Contracts;

use App\Models\User;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;

interface UserRepositoryInterface
{
    public function findById(int $id): ?User;
    public function findByEmail(string $email): ?User;
    public function create(array $data): User;
    public function update(int $id, array $data): User;
    public function delete(int $id): bool;
    public function paginate(int $perPage = 15): LengthAwarePaginator;
}
```

**Implementation:**

```php
// app/Repositories/Eloquent/UserRepository.php
<?php

declare(strict_types=1);

namespace App\Repositories\Eloquent;

use App\Models\User;
use App\Repositories\Contracts\UserRepositoryInterface;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;

class UserRepository implements UserRepositoryInterface
{
    public function __construct(private readonly User $model) {}

    public function findById(int $id): ?User
    {
        return $this->model->find($id);
    }

    public function create(array $data): User
    {
        return $this->model->create($data);
    }

    public function findByEmail(string $email): ?User
    {
        return $this->model->where('email', $email)->first();
    }

    public function update(int $id, array $data): User
    {
        $user = $this->model->findOrFail($id);
        $user->update($data);

        return $user;
    }

    public function delete(int $id): bool
    {
        return (bool) $this->model->whereKey($id)->delete();
    }

    public function paginate(int $perPage = 15): LengthAwarePaginator
    {
        return $this->model->latest()->paginate($perPage);
    }
}
```

**Bind in AppServiceProvider:**

```php
$this->app->bind(UserRepositoryInterface::class, UserRepository::class);
```

**See also:** `code-service-layer.md`, `code-folder-structure.md`
