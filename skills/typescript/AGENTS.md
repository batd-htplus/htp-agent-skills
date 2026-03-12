# TypeScript Best Practices — Agent Reference

> Compiled from `rules/ts-*.md`. Do not edit directly — edit individual rule files.
> Language: **TypeScript** | Version: 1.0.0 | License: MIT

This document is the authoritative reference for writing, reviewing, and refactoring TypeScript code.
Apply all rules strictly. CRITICAL violations must be fixed before any code ships.

---

## Section Index

| Rule file                    | Section                      | Impact   |
|-----------------------------|------------------------------|----------|
| ts-compiler-strict          | Compiler Configuration       | CRITICAL |
| ts-type-declarations        | Type Declarations            | CRITICAL |
| ts-narrowing-guards         | Type Narrowing & Guards      | CRITICAL |
| ts-async-errors             | Async & Error Handling       | CRITICAL |
| ts-generics                 | Generics                     | MAJOR    |
| ts-utility-types            | Utility Types                | MAJOR    |
| ts-modules-imports          | Module & Import Structure    | MAJOR    |
| ts-patterns-anti-patterns   | Patterns & Anti-Patterns     | MAJOR    |
| ts-project-references       | Project References           | MAJOR    |
| ts-module-resolution        | Module Resolution & ESM/CJS  | MAJOR    |
| ts-runtime-validation       | Runtime Validation           | CRITICAL |
| ts-env-config               | Environment Configuration    | CRITICAL |
| ts-error-handling           | Error Handling Model         | MAJOR    |
| ts-immutable-updates        | Immutable Updates            | MAJOR    |
| ts-public-api-surface       | Public API Surface           | MAJOR    |
| ts-testing-types            | Types in Tests               | MAJOR    |
| ts-declaration-files        | Declaration Files            | MAJOR    |
| ts-performance-types        | Type System Performance      | MAJOR    |

---

## [ts-compiler-strict] Compiler Configuration — CRITICAL

**Rules:** Enable `strict`, `noUncheckedIndexedAccess`, `exactOptionalPropertyTypes`. Never use `skipLibCheck` in lib packages. Never use `@ts-ignore`.

```json
{
  "compilerOptions": {
    "strict": true,
    "noUncheckedIndexedAccess": true,
    "exactOptionalPropertyTypes": true,
    "noImplicitReturns": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "verbatimModuleSyntax": true,
    "isolatedModules": true
  }
}
```

```typescript
// noUncheckedIndexedAccess — forces undefined handling
const items = ['a', 'b']
const first = items[0]  // string | undefined — must handle ✅

// @ts-expect-error — only when truly needed, always with comment
// @ts-expect-error: external lib missing type for deprecated option
legacyLib.oldMethod()
```

**Checklist:**
- [ ] `strict: true` in every `tsconfig.json`
- [ ] `noUncheckedIndexedAccess: true`
- [ ] `exactOptionalPropertyTypes: true`
- [ ] Zero `@ts-ignore` — use `@ts-expect-error` with explanation

---

## [ts-type-declarations] Type Declarations — CRITICAL

**Rules:** `interface` for shapes, `type` for unions/aliases. Avoid `any` in application code — use `unknown` (exceptions documented). Use `as const` when literal inference is required. No Hungarian prefixes. Always `export type`.

```typescript
// ✅ interface for extensible shapes
interface User { id: string; email: string; role: UserRole }

// ✅ type for unions
type UserRole = 'admin' | 'member' | 'guest'

// ✅ as const — preserves literal types
const ROUTES = { home: '/', users: '/users' } as const
type Route = typeof ROUTES[keyof typeof ROUTES]  // '/' | '/users'

// ✅ unknown — forces explicit narrowing
function parse(raw: string): unknown { return JSON.parse(raw) }

// ✅ discriminated union — explicit success/failure
type Result<T> = { success: true; data: T } | { success: false; error: string }

// ✅ type-only export
export type { User, UserRole }
```

```typescript
// ❌ any             — disables type checking
// ❌ IUser / TUser   — no Hungarian prefixes
// ❌ import { User } — use import type { User } with verbatimModuleSyntax
```

**Checklist:**
- [ ] No `any` in application code — use `unknown` + narrowing (exceptions documented)
- [ ] Config/literal objects use `as const` when literal inference is required
- [ ] No `I`, `T`, `E` prefixes on type names
- [ ] All type-only exports use `export type`

---

## [ts-narrowing-guards] Type Narrowing & Guards — CRITICAL

**Rules:** Discriminated unions with `kind` field for object-variant unions. Named type predicates. `never` exhaustiveness. Avoid `as` to bypass narrowing.

```typescript
// ✅ Discriminated union
type Shape =
  | { kind: 'circle';    radius: number }
  | { kind: 'rectangle'; width: number; height: number }

function area(s: Shape): number {
  switch (s.kind) {
    case 'circle':    return Math.PI * s.radius ** 2
    case 'rectangle': return s.width * s.height
    default:
      const _: never = s  // ✅ exhaustiveness check
      throw new Error(`Unhandled: ${JSON.stringify(_)}`)
  }
}

// ✅ Type predicate
function isApiError(r: ApiResponse<unknown>): r is ApiError {
  return 'code' in r && 'message' in r
}

// ✅ Zod — runtime + static narrowing in one step
const UserSchema = z.object({ id: z.string(), email: z.string().email() })
type User = z.infer<typeof UserSchema>
const user = UserSchema.parse(raw)  // throws if invalid ✅
```

```typescript
// ❌ as cast            — hides real type mismatch
// ❌ user!.email        — non-null assertion without prior guard
// ❌ boolean field      — use discriminated union instead
```

**Checklist:**
- [ ] All object-variant unions have a `kind`/`type` discriminant field
- [ ] All `switch` on discriminant have `default: never` check
- [ ] Zero `as` casts outside parse/test boundaries
- [ ] Zero `!` assertions without an immediately-preceding null check

---

## [ts-generics] Generics — MAJOR

**Rules:** Constrain with `extends`. Semantic names (`TKey`, `TValue`). Rely on inference. Use `infer` for sub-type extraction.

```typescript
// ✅ Constrained — T must have id
function findById<T extends { id: string }>(items: T[], id: string): T | undefined {
  return items.find(i => i.id === id)
}

// ✅ Semantic multi-param names
function mapObject<TKey extends string, TValue, TResult>(
  obj:    Record<TKey, TValue>,
  mapper: (v: TValue, k: TKey) => TResult
): Record<TKey, TResult> { ... }

// ✅ infer — extract sub-type
type Awaited<T>    = T extends Promise<infer U> ? U : T
type ElementOf<T>  = T extends (infer U)[] ? U : never

// ✅ Default type param
interface ApiResponse<TData = unknown> { data: TData; status: number }
```

```typescript
// ❌ Unconstrained T used as if it has properties → runtime error
// ❌ Single-letter A, B, X for multiple params → unreadable
// ❌ Forced explicit type args when inference works
```

**Checklist:**
- [ ] All type params have `extends` constraint when shape is expected
- [ ] Multiple params use `TKey`, `TValue`, `TResult` naming
- [ ] Generic functions infer type at call site — no forced explicit args

---

## [ts-utility-types] Utility Types — MAJOR

**Rules:** `Partial`/`Required` for update/replace schemas. `Pick`/`Omit` for scoped types. `Readonly` for immutable data. `ReturnType`/`Awaited` for derived types.

```typescript
interface User { id: string; email: string; name: string; role: 'admin' | 'member'; created_at: string }

// ✅ Update (PATCH) input
type UpdateUserInput  = Partial<Omit<User, 'id' | 'created_at'>>

// ✅ Replace (PUT) input
type ReplaceUserInput = Required<Omit<User, 'id' | 'created_at'>>

// ✅ Scoped view — no manual redeclaration
type UserPreview = Pick<User, 'id' | 'name'>
type PublicUser  = Omit<User, 'created_at'>

// ✅ Immutable param
function process(user: Readonly<User>) { ... }

// ✅ Derived from function — stays in sync automatically
type FetchUserResult = Awaited<ReturnType<typeof fetchUser>>  // User

// ✅ Typed map
type StatusLabel = Record<'active' | 'inactive', string>

// ✅ Filter union
type ActiveStatus = Exclude<'draft' | 'published' | 'deleted', 'deleted'>
```

```typescript
// ❌ Manual interface redeclaration — drifts with parent
// ❌ { [key: string]: V } — use Record<K, V>
```

**Checklist:**
- [ ] PATCH/update inputs use `Partial<Omit<T, ...>>`
- [ ] PUT/replace inputs use `Required<Omit<T, ...>>`
- [ ] Subsets use `Pick<T, K>` — no manual redeclaration
- [ ] Maps use `Record<K, V>` — not `{ [key: string]: V }`

---

## [ts-async-errors] Async & Error Handling — CRITICAL

**Rules:** Always `await` Promises. `catch(error: unknown)` + narrow. Use `Result<T, E>` for expected failures. Avoid `async` without `await` unless required by an interface.

```typescript
// ✅ Result pattern
type Result<T, E = Error> = { ok: true; value: T } | { ok: false; error: E }
const ok  = <T>(value: T): Result<T, never> => ({ ok: true,  value })
const err = <E>(error: E): Result<never, E> => ({ ok: false, error })

async function findUser(id: string): Promise<Result<User, 'NOT_FOUND' | 'DB_ERROR'>> {
  try {
    const user = await db.users.findUnique({ where: { id } })
    return user ? ok(user) : err('NOT_FOUND')
  } catch { return err('DB_ERROR') }
}

// ✅ catch with unknown — narrow before access
try { await riskyOp() } catch (error: unknown) {
  if (error instanceof Error) throw new Error('Failed', { cause: error })
  throw new Error('Unknown failure')
}

// ✅ Parallel independent queries
const [users, orders] = await Promise.all([db.users.findMany(), db.orders.findMany()])
```

```typescript
// ❌ Unhandled promise      — silent production failure
// ❌ catch(error: Error)    — error may not be Error instance
// ❌ async without await    — unnecessary microtask overhead
// ❌ Empty catch {}         — swallows errors silently
// ❌ Sequential awaits      — use Promise.all for independent ops
```

**Checklist:**
- [ ] Every Promise is `await`-ed or explicitly `void`-ed with comment
- [ ] All `catch` use `unknown` + narrowing before property access
- [ ] Expected failures return `Result<T, E>` — not `throw`
- [ ] Avoid `async` functions without at least one `await` inside (exceptions documented)
- [ ] Re-throws use `{ cause: error }` for error chain

---

## [ts-modules-imports] Module & Import Structure — MAJOR

**Rules:** Path aliases over `../..`. Barrels only at public boundaries (exceptions documented). `import type` for types. Consistent import order.

```typescript
// tsconfig paths
{ "paths": { "@/*": ["./src/*"], "@lib/*": ["./src/lib/*"] } }

// ✅ Import order (5 groups, blank line between each)
import path from 'path'                    // 1. node built-ins
import express from 'express'              // 2. external packages
import { db } from '@lib/db'               // 3. internal aliases
import { validate } from './validate'      // 4. relative
import type { User } from '@types/user'    // 5. type-only
```

```typescript
// ❌ import { User } from './types'  — use import type
// ❌ import * as utils              — avoid star imports; use named imports unless required by library
// ❌ ../../../../lib/db             — use @lib/db alias
// ❌ barrel re-exports everything   — only at feature public boundary
```

**Checklist:**
- [ ] `paths` in `tsconfig.json` — no `../../../` in codebase
- [ ] Barrels only at feature entry points (exceptions documented)
- [ ] All type-only imports use `import type`
- [ ] Imports in 5-group order
- [ ] Avoid star imports (`import * as`) in application code unless library requires it

---

## [ts-patterns-anti-patterns] Patterns & Anti-Patterns — MAJOR

**Rules:** Avoid `any` in application code. Avoid `as` outside validated boundaries. Prefer unions over `enum` (allow for interop). `satisfies` for literal inference + constraint. Avoid `object` type.

```typescript
// ✅ unknown + narrowing — replaces any
function handle(raw: unknown) {
  if (typeof raw === 'string') return raw.trim()
  throw new Error('Unexpected type')
}

// ✅ String union — erased at runtime, simpler than enum
type Direction = 'north' | 'south' | 'east' | 'west'
const DIRECTIONS = ['north', 'south', 'east', 'west'] as const

// ✅ satisfies — literal inference + shape check
const config = {
  port: 3000,
  mode: 'development',
} satisfies { port: number; mode: 'development' | 'production' }
// config.mode is 'development' (literal) — not widened ✅

// ✅ Record — typed map, never object
function merge<T extends object, U extends object>(a: T, b: U): T & U {
  return { ...a, ...b }
}
```

```typescript
// ❌ any                    — type hole, silently disables checks
// ❌ as X                   — hides real mismatches
// ❌ as unknown as X        — double cast, completely bypasses checks
// ❌ enum Status {}         — use string literal union
// ❌ object type            — use Record<K, V> or typed interface
// ❌ @ts-ignore             — use @ts-expect-error with comment
```

**Checklist:**
- [ ] No `any` in application code — `unknown`, `never`, or proper types (exceptions documented)
- [ ] Zero `as` casts outside validated parse boundaries
- [ ] Avoid `enum` — use string literal union + `as const` array unless interop requires it
- [ ] Avoid `object` type — use `Record<K, V>` or interface
- [ ] `satisfies` used when literal inference AND constraint both needed
- [ ] Zero `@ts-ignore`; `@ts-expect-error` always has a comment

---

## [ts-project-references] Project References — MAJOR

**Rules:** Use project references in multi-package repos. Enable `composite` and `declaration`. Build with `tsc -b`.

```json
// packages/api/tsconfig.json
{ "compilerOptions": { "composite": true, "declaration": true }, "references": [{ "path": "../shared" }] }
```

**Checklist:**
- [ ] Monorepos use project references
- [ ] Referenced projects have `composite: true`

---

## [ts-module-resolution] Module Resolution & ESM/CJS — MAJOR

**Rules:** Align `module`/`moduleResolution`/`target` with runtime. Do not mix ESM/CJS without intent.

```json
{ "compilerOptions": { "module": "NodeNext", "moduleResolution": "NodeNext", "target": "ES2022" } }
```

**Checklist:**
- [ ] Module settings match runtime or bundler
- [ ] ESM/CJS mode is consistent per package

---

## [ts-runtime-validation] Runtime Validation at Boundaries — CRITICAL

**Rules:** Validate all untrusted input. Parse to `unknown` and validate with schema. Never cast raw data.

```typescript
const UserSchema = z.object({ id: z.string().uuid() })
const user = UserSchema.parse(raw)
```

**Checklist:**
- [ ] Boundary inputs are validated
- [ ] No `as` casts for untrusted data

---

## [ts-env-config] Environment Configuration — CRITICAL

**Rules:** Centralize env parsing. Validate required vars. Avoid scattered `process.env`.

```typescript
export const env = EnvSchema.parse(process.env)
```

**Checklist:**
- [ ] Env vars are parsed once and validated
- [ ] No direct `process.env` usage outside config

---

## [ts-error-handling] Error Handling Model — MAJOR

**Rules:** Use typed error codes. Use `Result<T, E>` for expected failures. Preserve `cause`.

```typescript
class AppError extends Error { constructor(public readonly code: string, msg: string, opts?: { cause?: unknown }) { super(msg, opts) } }
```

**Checklist:**
- [ ] Expected failures use `Result<T, E>`
- [ ] Wrapped errors preserve `cause`

---

## [ts-immutable-updates] Immutable Updates — MAJOR

**Rules:** Avoid mutating inputs. Prefer `Readonly` and structural sharing.

```typescript
const next = { ...user, name }
```

**Checklist:**
- [ ] Inputs treated as immutable
- [ ] Updates use structural sharing

---

## [ts-public-api-surface] Public API Surface — MAJOR

**Rules:** Expose a clear public boundary. Avoid deep imports. Use `export type`.

```typescript
export { createClient } from './client'
export type { ClientOptions } from './types'
```

**Checklist:**
- [ ] Public exports are centralized
- [ ] Consumers do not import deep internals

---

## [ts-testing-types] Types in Tests — MAJOR

**Rules:** Keep tests type-safe. Avoid `as any`. Use `satisfies` or builders.

```typescript
const user = { id: 'u1', email: 'a@b.com' } satisfies User
```

**Checklist:**
- [ ] Tests avoid `as any`
- [ ] Fixtures are typed

---

## [ts-declaration-files] Declaration Files — MAJOR

**Rules:** Keep ambient types in `types/`. Prefer module augmentation over globals.

```typescript
declare module 'express' { interface Request { userId?: string } }
```

**Checklist:**
- [ ] Ambient declarations are scoped and minimal
- [ ] Module augmentation preferred

---

## [ts-performance-types] Type System Performance — MAJOR

**Rules:** Avoid deep recursive types and huge unions. Prefer simpler types.

**Checklist:**
- [ ] Recursive conditional types are limited and justified
- [ ] Type complexity stays reasonable

---

## Global Compliance Checklist

### Critical (ship-blocking)
- [ ] `strict: true`, `noUncheckedIndexedAccess`, `exactOptionalPropertyTypes` in all tsconfig files
- [ ] No `any` in application code — `unknown` + narrowing instead (exceptions documented)
- [ ] All object-variant unions have a discriminant; all `switch` have `default: never`
- [ ] All `catch` use `unknown` + narrow before property access
- [ ] Every Promise is `await`-ed or explicitly `void`-ed

### Major (pre-release)
- [ ] All type params constrained with `extends`
- [ ] PATCH inputs use `Partial<Omit<T,...>>`, PUT inputs use `Required<Omit<T,...>>`
- [ ] Path aliases configured; no `../../../` in imports
- [ ] `import type` used for all type-only imports
- [ ] Avoid `enum` — string literal unions used instead unless interop requires it
- [ ] Zero `as` casts outside parse/test boundaries

### Quick Violation Reference

| Violation | Severity | Fix |
|-----------|----------|-----|
| `any` in application code | critical | Use `unknown` + narrow |
| `strict: false` | critical | Enable `strict: true` |
| `catch(e: Error)` | critical | `catch(e: unknown)` + narrow |
| Unhandled Promise | critical | `await` or `void` with comment |
| `as X` to bypass types | major | Narrow with `typeof`/`instanceof`/predicate |
| Manual interface redeclaration | major | Use `Pick<T, K>` or `Omit<T, K>` |
| `enum` | major | String literal union + `as const` (unless interop requires enum) |
| `object` type | major | `Record<K, V>` or typed interface |
| `../../../` imports | major | Path alias via `@lib/...` |
| `import { T }` for type | major | `import type { T }` |
| Unconstrained generic | major | Add `extends` constraint |
| `async` without `await` | major | Remove `async` keyword |
| `@ts-ignore` | major | `@ts-expect-error` + comment |
