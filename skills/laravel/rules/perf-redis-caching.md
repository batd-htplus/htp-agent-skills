---
title: Caching with Redis Tags
impact: HIGH
impactDescription: Use Redis caching with tags for targeted invalidation. Cache frequently accessed data with appropriate TTLs.
tags: performance, caching, redis, optimization
---

## Caching with Redis Tags

Use Redis caching with tags for targeted invalidation. Cache frequently accessed data with appropriate TTLs.

**Why it matters:** Caching reduces database load and improves response times. Tags allow efficient cache invalidation.

**✅ Cache with tags (allows targeted invalidation):**

```php
use Illuminate\Support\Facades\Cache;

public function getActiveCategories(): Collection
{
    return Cache::tags(['categories'])
        ->remember('categories:active', now()->addHours(6), function () {
            return Category::active()->withCount('products')->get();
        });
}

// User-specific cache
public function getUserStats(int $userId): array
{
    return Cache::tags(['users', "user:{$userId}"])
        ->remember("user:{$userId}:stats", now()->addMinutes(15), function () use ($userId) {
            return $this->userRepository->computeStats($userId);
        });
}

// Invalidate cache on write
public function createCategory(array $data): Category
{
    $category = $this->categoryRepository->create($data);
    Cache::tags(['categories'])->flush();

    return $category;
}

// Invalidate only a specific user's cache
public function updateUser(int $userId, array $data): User
{
    $user = $this->userRepository->update($userId, $data);
    Cache::tags(["user:{$userId}"])->flush();

    return $user;
}
```

**Cache TTL guidelines:**

| Data type | TTL |
|-----------|-----|
| App config / static enums | 24 hours |
| Category / tag lists | 6 hours |
| User profile | 15 minutes |
| Dashboard stats | 5 minutes |
| Real-time / live data | No cache |

**See also:** `perf-config-cache.md`, `perf-select-columns.md`
