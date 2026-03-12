---
title: Declaration Files (.d.ts)
impact: MAJOR
impactDescription: Incorrect ambient declarations create global type pollution
tags: typescript, dts, declarations, ambient, module-augmentation
---

# Declaration Files (.d.ts)

**Impact:** MAJOR

## Rules

1. **Keep ambient types in a dedicated `types/` folder** — avoid scattering globals.
2. **Prefer module augmentation over global pollution** — only add to global when required.
3. **Keep `.d.ts` minimal and documented** — avoid broad `declare global` blocks.

## ✅ Correct

```typescript
// types/express.d.ts
import 'express'

declare module 'express' {
  interface Request {
    userId?: string
  }
}
```

## ❌ Incorrect

```typescript
// In random file
declare global { var __DEV__: boolean }
```

## Checklist

- [ ] Ambient declarations live in `types/`
- [ ] Module augmentation preferred to global declarations
- [ ] `.d.ts` files are minimal and documented

## See Also

- [ts-modules-imports](ts-modules-imports.md)
