---
title: Runtime Validation at Boundaries
impact: CRITICAL
impactDescription: Unvalidated inputs are the main source of runtime crashes
tags: typescript, validation, zod, io, boundaries, unknown
---

# Runtime Validation at Boundaries

**Impact:** CRITICAL

## Rules

1. **Validate all untrusted input** — API payloads, env vars, localStorage, and JSON must be validated at boundaries.
2. **Parse to `unknown` and narrow with a schema** — never `as` cast raw input.
3. **Keep schemas close to boundary code** — controllers, handlers, adapters.

## ✅ Correct

```typescript
const UserSchema = z.object({
  id: z.string().uuid(),
  email: z.string().email(),
})

export type User = z.infer<typeof UserSchema>

export function parseUser(raw: unknown): User {
  return UserSchema.parse(raw)
}
```

```typescript
const data = await res.json()
const user = parseUser(data)
```

## ❌ Incorrect

```typescript
const user = (await res.json()) as User  // unsafe cast
```

## Checklist

- [ ] All boundary inputs are validated by a schema
- [ ] Raw inputs are `unknown` before validation
- [ ] No `as` casts for untrusted data

## See Also

- [ts-narrowing-guards](ts-narrowing-guards.md)
- [ts-patterns-anti-patterns](ts-patterns-anti-patterns.md)
