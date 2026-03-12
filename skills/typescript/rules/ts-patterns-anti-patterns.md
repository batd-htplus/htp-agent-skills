---
title: Patterns & Anti-Patterns
impact: MAJOR
impactDescription: any, as, enum, object type reduce safety and maintainability
tags: typescript, any, as, enum, satisfies, Record, unknown, never
---

# Patterns & Anti-Patterns

**Impact:** MAJOR

## Rules

1. **Avoid `any` — use `unknown`, `never`, or a proper type** — `any` is a type hole that silently disables all safety downstream. Allow it only in generated or third-party types with a brief justification.
2. **Avoid type assertions (`as`) except at validated boundaries** — use narrowing instead; `as` hides real mismatches.
3. **Prefer string literal unions over `enum`** — unions are erased at runtime, simpler to iterate, and work better with `as const`. Allow `enum` for interop with external APIs or legacy code.
4. **Use `satisfies` instead of type annotation when you want both inference and constraint** — preserves literal types while still checking against the constraint.
5. **Avoid `object` type — use `Record<string, unknown>` or a typed interface** — `object` matches too broadly and loses key information.

## ✅ Correct

```typescript
// ✅ unknown + narrowing — safe alternative to any
function processPayload(raw: unknown): string {
  if (typeof raw === 'string') return raw.trim()
  if (typeof raw === 'number') return String(raw)
  throw new Error('Unexpected payload type')
}

// ✅ never — for code paths that must not be reached
function assertNever(x: never): never {
  throw new Error(`Unexpected value: ${JSON.stringify(x)}`)
}
```

```typescript
// ✅ String literal union — no runtime enum object
type Direction = 'north' | 'south' | 'east' | 'west'

const DIRECTIONS = ['north', 'south', 'east', 'west'] as const
type Direction = typeof DIRECTIONS[number]
```

```typescript
// ✅ satisfies — infers literal type, still checks constraint
type Config = {
  port: number
  host: string
  mode: 'development' | 'production'
}

const config = {
  port: 3000,
  host: 'localhost',
  mode: 'development',
} satisfies Config
// config.mode is 'development' (literal) — not widened ✅
```

```typescript
// ✅ Record instead of object for typed maps
type FeatureFlags = Record<'darkMode' | 'betaFeatures', boolean>

const flags: FeatureFlags = {
  darkMode:     true,
  betaFeatures: false,
}
```

## ❌ Incorrect

```typescript
// ❌ any — disables type checking
function handleEvent(event: any) {
  event.target.value.trim()   // no error even if event is null

// ❌ as unknown as X — double cast to escape type system
const user = (serverData as unknown) as User

// ❌ Enum — use string literal union + as const array
enum Status { Active = 'active', Inactive = 'inactive' }

// ❌ object type — loses key information
function merge(a: object, b: object): object { ... }
// Fix: function merge<T extends object, U extends object>(a: T, b: U): T & U

// ❌ @ts-ignore — use @ts-expect-error with comment
```

## Checklist

- [ ] No `any` in application code — use `unknown`, `never`, or proper types (exceptions must be justified)
- [ ] Zero `as` casts outside parse/test boundaries — use narrowing
- [ ] Avoid `enum` declarations — use string literal unions + `as const` arrays unless interop requires it
- [ ] Avoid `object` type — use `Record<K, V>` or typed interfaces
- [ ] `satisfies` used when both literal inference and constraint check are needed
- [ ] No double cast (`as unknown as T`) anywhere
- [ ] Zero `@ts-ignore`; `@ts-expect-error` only with a comment

## See Also

- [ts-type-declarations](ts-type-declarations.md)
- [ts-narrowing-guards](ts-narrowing-guards.md)
- [ts-compiler-strict](ts-compiler-strict.md) (strict mode)
