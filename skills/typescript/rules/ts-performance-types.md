---
title: Type System Performance
impact: MAJOR
impactDescription: Overly complex types slow builds and degrade editor performance
tags: typescript, performance, types, conditional, recursion
---

# Type System Performance

**Impact:** MAJOR

## Rules

1. **Avoid deeply recursive conditional types** — prefer simpler types or helpers.
2. **Keep unions and mapped types reasonable** — very large unions slow inference.
3. **Prefer explicit types over clever type-level programming** — optimize for editor speed.

## ✅ Correct

```typescript
type UserId = string
type UserMap = Record<UserId, User>
```

## ❌ Incorrect

```typescript
// Deeply recursive type-level computation
type DeepPartial<T> = {
  [K in keyof T]?: T[K] extends object ? DeepPartial<T[K]> : T[K]
}
```

## Checklist

- [ ] Type-level recursion is limited and justified
- [ ] Unions are kept small and purposeful
- [ ] Types prioritize editor performance and clarity

## See Also

- [ts-utility-types](ts-utility-types.md)
