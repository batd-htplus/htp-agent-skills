---
title: Types in Tests
impact: MAJOR
impactDescription: Type-safe tests catch incorrect fixtures and contracts
tags: typescript, testing, fixtures, types, any
---

# Types in Tests

**Impact:** MAJOR

## Rules

1. **Keep tests type-safe** — avoid `as any` in tests.
2. **Use builders or fixtures with `satisfies`** — validates shape without widening.
3. **Prefer narrow helpers over broad mocks** — reduce test brittleness.

## ✅ Correct

```typescript
const user = {
  id: 'u1',
  email: 'test@example.com',
} satisfies User
```

```typescript
function makeUser(overrides: Partial<User> = {}): User {
  return { id: 'u1', email: 'a@b.com', ...overrides }
}
```

## ❌ Incorrect

```typescript
const user = { id: 1 } as any  // type hole in tests
```

## Checklist

- [ ] Tests avoid `as any`
- [ ] Fixtures use `satisfies` or builders
- [ ] Mocks are minimal and typed

## See Also

- [ts-type-declarations](ts-type-declarations.md)
- [ts-runtime-validation](ts-runtime-validation.md)
