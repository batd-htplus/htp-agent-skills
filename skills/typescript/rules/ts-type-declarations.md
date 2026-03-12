---
title: Type Declarations
impact: CRITICAL
impactDescription: any and wrong shapes cause runtime crashes; naming affects maintainability
tags: typescript, interface, type, unknown, as const, export type
---

# Type Declarations

**Impact:** CRITICAL

## Rules

1. **Prefer `interface` for object shapes, `type` for unions/aliases** — use `interface` when the shape may be extended; use `type` for unions, intersections, mapped types, and primitives.
2. **Never use `any` — use `unknown` for truly unknown values** — `any` disables the type system; `unknown` forces explicit narrowing before use.
3. **Use `as const` for literal values and config objects** — prevents widening to primitive types and enables precise literal types.
4. **Name types as nouns, not adjectives or verbs** — `User`, `OrderStatus`, `ApiResponse<T>` — not `IUser`, `TUser`, `Userable`.
5. **Export types with `export type`** — separates value exports from type exports; required with `verbatimModuleSyntax`.

## ✅ Correct

```typescript
// ✅ interface for object shapes (extensible)
interface User {
  id:         string
  email:      string
  role:       UserRole
  created_at: string
}

// ✅ type for unions
type UserRole = 'admin' | 'member' | 'guest'

// ✅ type for mapped/conditional types
type Nullable<T>  = T | null
type Optional<T>  = T | undefined
type ReadonlyUser = Readonly<User>

// ✅ as const — precise literal types
const ROUTES = {
  home:    '/',
  users:   '/users',
  orders:  '/orders',
} as const

type Route = typeof ROUTES[keyof typeof ROUTES]  // '/' | '/users' | '/orders'

// ✅ unknown forces narrowing before use
function parseJson(raw: string): unknown {
  return JSON.parse(raw)
}

const data = parseJson('{"id":1}')
if (typeof data === 'object' && data !== null && 'id' in data) {
  console.log(data)
}

// ✅ export type
export type { User, UserRole }
export type { ApiResponse } from './api'
```

```typescript
// ✅ Discriminated union — prefer over boolean flags
type ApiResult<T> =
  | { success: true;  data: T }
  | { success: false; error: string }

function handleResult<T>(result: ApiResult<T>) {
  if (result.success) {
    console.log(result.data)
  } else {
    console.log(result.error)
  }
}
```

## ❌ Incorrect

```typescript
// ❌ any — disables type checking entirely
function process(data: any) {
  data.whatever.nested.call()  // no error, runtime crash
}

// ❌ Hungarian prefixes (IUser, TUser)
interface IUser { id: string }
type TUserRole = 'admin'

// ❌ Widening with object literal — add as const
const STATUS = {
  active:   'active',
  inactive: 'inactive',
}
type Status = typeof STATUS[keyof typeof STATUS]  // string — too wide

// ❌ import without type when verbatimModuleSyntax is on
import { User } from './types'        // ❌ if User is only a type
import type { User } from './types'   // ✅
```

## Checklist

- [ ] All object shapes use `interface`
- [ ] All unions, aliases, mapped types use `type`
- [ ] Zero `any` in codebase — use `unknown` + narrowing
- [ ] All config/literal objects use `as const`
- [ ] No Hungarian prefixes (`I`, `T`, `E`) on type names
- [ ] All type-only exports use `export type`

## See Also

- [ts-narrowing-guards](ts-narrowing-guards.md)
- [ts-patterns-anti-patterns](ts-patterns-anti-patterns.md)
