---
title: Public API Surface
impact: MAJOR
impactDescription: Explicit public exports prevent leaking internal types
tags: typescript, api, exports, barrel, public-surface
---

# Public API Surface

**Impact:** MAJOR

## Rules

1. **Define a clear public export surface** — expose only what consumers should use.
2. **Avoid deep imports for consumers** — export from a single boundary module.
3. **Separate type exports from values** — use `export type` where possible.

## ✅ Correct

```typescript
// src/index.ts (public boundary)
export { createClient } from './client'
export type { ClientOptions } from './types'
```

## ❌ Incorrect

```typescript
// Consumer imports internals
import { internalHelper } from './src/internal/helpers'
```

## Checklist

- [ ] Public exports are centralized at a boundary file
- [ ] Consumers do not import deep internals
- [ ] Type exports use `export type`

## See Also

- [ts-modules-imports](ts-modules-imports.md)
