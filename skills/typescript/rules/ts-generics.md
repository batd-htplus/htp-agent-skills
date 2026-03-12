---
title: Generics
impact: MAJOR
impactDescription: Unconstrained generics and poor naming cause hard-to-catch bugs
tags: typescript, generics, extends, infer, type parameter
---

# Generics

**Impact:** MAJOR

## Rules

1. **Constrain type parameters with `extends`** — never leave a type parameter unconstrained when you know the shape it must satisfy.
2. **Name type parameters semantically** — `T` for a single generic; `TItem`, `TKey`, `TValue` for multiple; avoid `A`, `B`, `X`.
3. **Prefer generic functions over generic types** — type inference works better with function generics; avoid forcing callers to pass type args.
4. **Use `infer` in conditional types to extract sub-types** — instead of casting, derive types from existing structures.

## ✅ Correct

```typescript
// ✅ Constrained generics — T must be an object with an id
function findById<T extends { id: string }>(items: T[], id: string): T | undefined {
  return items.find(item => item.id === id)
}

const user    = findById(users, 'u1')    // T inferred as User
const product = findById(products, 'p1') // T inferred as Product
```

```typescript
// ✅ Semantic names for multiple params
function mapObject<TKey extends string, TValue, TResult>(
  obj:    Record<TKey, TValue>,
  mapper: (value: TValue, key: TKey) => TResult
): Record<TKey, TResult> { ... }
```

```typescript
// ✅ infer — extract return type from Promise
type Awaited<T> = T extends Promise<infer U> ? U : T
type ElementOf<T> = T extends (infer U)[] ? U : never
```

```typescript
// ✅ Default type parameter
interface ApiResponse<TData = unknown> {
  data: TData
  status: number
  message: string
}
```

## ❌ Incorrect

```typescript
// ❌ Unconstrained T used as if it has properties — runtime error
function getName<T>(item: T): string {
  return item.name  // ❌ Fix: T extends { name: string }
}

// ❌ Single-letter names for multiple params — unreadable
function merge<A, B>(a: A, b: B): A & B { ... }

// ❌ Forcing caller to pass type arg — poor inference
const x = identity<string>('hello')  // ❌ unnecessary — inferred automatically
```

## Checklist

- [ ] All type parameters have an `extends` constraint when a shape is expected
- [ ] Multiple type parameters use semantic names (`TKey`, `TValue`, `TResult`)
- [ ] Generic functions rely on inference — callers rarely need explicit type args
- [ ] `infer` is used to extract sub-types in conditional types
- [ ] Default type parameters are provided where `unknown` is a safe default

## See Also

- [ts-type-declarations](ts-type-declarations.md)
- [ts-utility-types](ts-utility-types.md)
