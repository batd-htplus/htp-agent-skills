---
title: Use Policies for Authorization — Never in Controllers
impact: CRITICAL
impactDescription: All authorization logic must be in Policies, never in controllers. This ensures consistency and reusability.
tags: security, authorization, policies, controllers
---

## Use Policies for Authorization — Never in Controllers

All authorization logic must be in Policies, never in controllers. This ensures consistency and reusability.

**Why it matters:** Policies centralize authorization logic, make it testable, and prevent duplication across controllers.

**❌ Incorrect:**

```php
// Manual checks in controller
public function update(Request $request, Post $post): JsonResponse
{
    if ($request->user()->id !== $post->user_id) {
        abort(403);
    }
    // ...
}
```

**✅ Correct:**

```php
// app/Policies/PostPolicy.php
public function update(User $user, Post $post): bool
{
    return $user->id === $post->user_id
        || $user->hasRole('admin');
}
```

```php
// Controller:
public function update(UpdatePostRequest $request, Post $post): JsonResponse
{
    $this->authorize('update', $post);
    // ...
}
```

**Registration:** Register in `AuthServiceProvider`:

```php
protected $policies = [
    Post::class => PostPolicy::class,
];
```

**See also:** `security-no-sql-concatenation.md`, `api-form-requests.md`
