---
title: Type Narrowing & Guards
impact: CRITICAL
impactDescription: Wrong narrowing or as-casts hide bugs and cause runtime crashes
tags: typescript, narrowing, discriminated union, type predicate, never, zod
---

# Type Narrowing & Guards

**Impact:** CRITICAL

## Rules

1. **Use discriminated unions with a `kind`/`type` field for object-variant unions** — enables exhaustive narrowing with zero runtime cost.
2. **Write type predicates (`is`) for reusable narrowing logic** — encapsulate complex narrowing into typed functions.
3. **Use `never` for exhaustiveness checks** — guarantee at compile time that every union member is handled.
4. **Never use `as` casting to bypass narrowing** — casting hides real type errors; narrow properly instead.

## ✅ Correct

```typescript
// ✅ Discriminated union — single 'kind' field enables safe narrowing
type Shape =
  | { kind: 'circle';    radius: number }
  | { kind: 'rectangle'; width: number; height: number }
  | { kind: 'triangle';  base: number;  height: number }

function area(shape: Shape): number {
  switch (shape.kind) {
    case 'circle':
      return Math.PI * shape.radius ** 2
    case 'rectangle':
      return shape.width * shape.height
    case 'triangle':
      return (shape.base * shape.height) / 2
    default:
      const _exhaustive: never = shape
      throw new Error(`Unhandled shape: ${JSON.stringify(_exhaustive)}`)
  }
}
```

```typescript
// ✅ Type predicate — reusable, named narrowing
function isApiError(res: ApiResponse<unknown>): res is ApiError {
  return 'code' in res && 'message' in res
}

function handleResponse<T>(res: ApiResponse<T>) {
  if (isApiError(res)) {
    console.error(res.code, res.message)
  } else {
    console.log(res.data)
  }
}
```

```typescript
// ✅ Zod for runtime narrowing + static types
const UserSchema = z.object({
  id:    z.string().uuid(),
  email: z.string().email(),
  role:  z.enum(['admin', 'member', 'guest']),
})
type User = z.infer<typeof UserSchema>

function parseUser(raw: unknown): User {
  return UserSchema.parse(raw)
}
```

```typescript
// ✅ Narrowing with in, typeof, instanceof
function format(value: string | number | Date): string {
  if (typeof value === 'string')       return value.trim()
  if (typeof value === 'number')       return value.toFixed(2)
  if (value instanceof Date)           return value.toISOString()
  const _exhaustive: never = value
  throw new Error('Unhandled type')
}
```

## ❌ Incorrect

```typescript
// ❌ Type assertion instead of narrowing — hides real bugs
function process(value: unknown) {
  const user = value as User   // ❌ no runtime check
  console.log(user.email)
}

// ❌ Non-null assertion (!) without guarantee
function getEmail(user: User | null) {
  return user!.email  // ❌ crashes if user is null
}
// Fix: if (!user) throw new Error('User is required'); return user.email

// ❌ Missing exhaustiveness — new union member silently falls through
// ❌ Boolean flag instead of discriminated union — use { success: true; data } | { success: false; error }
```

## Checklist

- [ ] All object-variant unions have a discriminant field (`kind`, `type`, `status`)
- [ ] `switch` on discriminant always has a `default: never` exhaustiveness check
- [ ] Reusable narrowing logic is in a named type predicate (`x is T`)
- [ ] Zero non-null assertions (`!`) without an immediately-preceding guard
- [ ] Zero `as` casts outside of Zod/parse boundaries or explicit test fixtures

## See Also

- [ts-type-declarations](ts-type-declarations.md) (discriminated unions)
- [ts-async-errors](ts-async-errors.md) (Result pattern)
- [ts-patterns-anti-patterns](ts-patterns-anti-patterns.md) (`as`, `!`)
