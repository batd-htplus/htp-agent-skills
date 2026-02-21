---
title: Module & Import Structure
impact: MAJOR
impactDescription: Deep relative imports and wrong type imports hurt refactors and bundling
tags: typescript, import, path alias, barrel, import type, verbatimModuleSyntax
---

# Module & Import Structure

**Impact:** MAJOR

## Rules

1. **Use path aliases instead of relative `../../` imports** — configure `paths` in `tsconfig.json` and keep imports readable.
2. **Barrel files (`index.ts`) only for public API surface** — do not create barrels inside every folder; they cause circular dependency risk and slow bundlers.
3. **Separate type imports with `import type`** — enforced by `verbatimModuleSyntax`; prevents value imports of type-only modules.
4. **Order imports consistently** — external packages → internal aliases → relative files → type imports.

## ✅ Correct

```json
// tsconfig.json — path aliases
{
  "compilerOptions": {
    "baseUrl": ".",
    "paths": {
      "@/*":         ["./src/*"],
      "@lib/*":      ["./src/lib/*"],
      "@types/*":    ["./src/types/*"],
      "@features/*": ["./src/features/*"]
    }
  }
}
```

```typescript
// ✅ Path aliases — clear, location-independent
import { db }         from '@lib/db'
import { requireAuth } from '@lib/middleware/auth'
import type { User }   from '@types/user'
```

```typescript
// ✅ Import order (5 groups, blank line between each)
import path from 'path'                    // 1. node built-ins
import express from 'express'              // 2. external packages
import { db } from '@lib/db'               // 3. internal aliases
import { validate } from './validate'      // 4. relative
import type { User } from '@types/user'    // 5. type-only
```

```typescript
// ✅ Barrel — only at the public feature boundary
// src/features/users/index.ts
export { usersRouter }         from './router'
export { usersController }     from './controller'
export type { User, UserRole } from './types'

// Internal files import directly — not through barrel
import { UserSchema } from './schemas'
import { db }         from '@lib/db'
```

## ❌ Incorrect

```typescript
// ❌ Deep relative imports — breaks on refactor
import { Errors } from '../../../lib/errors'
import { User } from '../../types/user'   // use import type

// ❌ Barrel for every folder — circular deps, slow bundler
// src/lib/index.ts export * from './db' export * from './errors' ...

// ❌ Importing a type without import type
import { User } from './types'   // ❌
import type { User } from './types'  // ✅

// ❌ Star imports — unclear what is used
import * as utils from '@lib/utils'  // use named imports
```

## Checklist

- [ ] `paths` configured in `tsconfig.json` — no `../../../` in codebase
- [ ] Barrel files exist only at feature public boundaries
- [ ] All type-only imports use `import type`
- [ ] Imports follow the 5-group order (node → external → alias → relative → types)
- [ ] No star imports (`import * as`) in application code

## See Also

- [ts-compiler-strict](ts-compiler-strict.md) (`verbatimModuleSyntax`, `paths`)
- [ts-type-declarations](ts-type-declarations.md) (`export type`)
