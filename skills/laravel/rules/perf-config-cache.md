---
title: Config, Route & View Caching
impact: HIGH
impactDescription: Prefer optimization commands on deployment; document exceptions for platforms that manage caching differently.
tags: performance, caching, deployment, optimization
---

## Config, Route & View Caching

Prefer running these optimization commands on deployment to improve performance. If your platform manages caching differently, document the exception.

**Why it matters:** Caching config, routes, and views dramatically reduces bootstrap time and improves response times.

**Prefer on deployment:**

```bash
php artisan config:cache    # Cache all config files
php artisan route:cache     # Cache route registration
php artisan view:cache      # Cache Blade templates
php artisan event:cache     # Cache event/listener map
php artisan optimize        # Runs all of the above
```

**Never cache in local development** — run `php artisan optimize:clear` to clear all caches.

**See also:** `perf-redis-caching.md`, `scripts/optimize.sh`
