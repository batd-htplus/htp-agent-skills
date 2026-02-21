---
title: Utility Types
impact: MAJOR
impactDescription: Manual redeclaration drifts; Record/Pick/Omit keep types in sync
tags: typescript, Partial, Required, Pick, Omit, Readonly, ReturnType, Awaited, Record
---

# Utility Types

**Impact:** MAJOR

## Rules

1. **Use `Partial<T>` and `Required<T>` for update schemas** — derive patch/replace types from the canonical interface instead of duplicating fields.
2. **Use `Pick<T, K>` and `Omit<T, K>` to scope types** — never manually redeclare a subset of an interface.
3. **Use `Readonly<T>` and `ReadonlyArray<T>` for immutable data** — prevents accidental mutation at the type level.
4. **Use `ReturnType<T>`, `Parameters<T>`, `Awaited<T>` to derive types from functions** — keeps derived types in sync automatically.

## ✅ Correct

```typescript
interface User {
  id:         string
  email:      string
  name:       string
  role:       'admin' | 'member'
  created_at: string
}

// ✅ Partial — PATCH/update input
type UpdateUserInput = Partial<Omit<User, 'id' | 'created_at'>>

// ✅ Required — PUT/replace input
type ReplaceUserInput = Required<Omit<User, 'id' | 'created_at'>>

// ✅ Pick — only the fields needed
type UserPreview = Pick<User, 'id' | 'name'>

// ✅ Omit — remove fields that should not be exposed
type PublicUser = Omit<User, 'created_at'>

// ✅ Readonly — immutable at type level
function processUser(user: Readonly<User>) { ... }

// ✅ ReturnType / Awaited — derived from function
type FetchUserResult = Awaited<ReturnType<typeof fetchUser>>

// ✅ Record — typed map
type StatusLabel = Record<'active' | 'inactive', string>

// ✅ Exclude / Extract — filter union
type ActiveStatus = Exclude<'draft' | 'published' | 'deleted', 'deleted'>
```

## ❌ Incorrect

```typescript
// ❌ Manually redeclaring a subset — drifts out of sync
interface UserPreview {
  id:   string
  name: string
}
// Fix: type UserPreview = Pick<User, 'id' | 'name'>

// ❌ Duplicating User with optional fields for update
// Fix: type UpdateUser = Partial<Omit<User, 'id' | 'created_at'>>

// ❌ { [key: string]: V } — use Record<K, V>
```

## Checklist

- [ ] Update/patch input types use `Partial<Omit<T, 'id' | 'created_at'>>`
- [ ] Replace/full input types use `Required<Omit<T, ...>>`
- [ ] Subset types use `Pick<T, K>` — no manual redeclaration
- [ ] Typed maps use `Record<K, V>` — not `{ [key: string]: V }`
- [ ] Derived types use `ReturnType`, `Parameters`, `Awaited`

## See Also

- [ts-generics](ts-generics.md)
- [ts-type-declarations](ts-type-declarations.md)
