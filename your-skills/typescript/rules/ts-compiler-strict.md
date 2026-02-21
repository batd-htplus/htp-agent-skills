---
title: Compiler Configuration
impact: CRITICAL
impactDescription: strict mode and flags prevent type holes and runtime crashes
tags: typescript, tsconfig, strict, noUncheckedIndexedAccess, exactOptionalPropertyTypes
---

# Compiler Configuration

**Impact:** CRITICAL

## Rules

1. **Enable `strict` mode** — always set `"strict": true`; never disable individual strict flags unless absolutely necessary and documented.
2. **Use `noUncheckedIndexedAccess`** — always enable to prevent silent `undefined` from array/object index access.
3. **Set `exactOptionalPropertyTypes`** — distinguish between a property being `undefined` vs missing.
4. **Never use `skipLibCheck: true` in source code** — only acceptable in monorepo root for build speed, never in library packages.

## ✅ Correct

```json
// tsconfig.json — production baseline
{
  "compilerOptions": {
    "target": "ES2022",
    "module": "ESNext",
    "moduleResolution": "bundler",
    "lib": ["ES2022", "DOM", "DOM.Iterable"],

    "strict": true,
    "noUncheckedIndexedAccess": true,
    "exactOptionalPropertyTypes": true,
    "noImplicitReturns": true,
    "noFallthroughCasesInSwitch": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true,

    "esModuleInterop": true,
    "isolatedModules": true,
    "verbatimModuleSyntax": true,

    "declaration": true,
    "declarationMap": true,
    "sourceMap": true,
    "outDir": "./dist"
  }
}
```

```typescript
// noUncheckedIndexedAccess forces you to handle undefined
const items = ['a', 'b', 'c']
const first = items[0]  // type: string | undefined  ✅ must handle both

if (first !== undefined) {
  console.log(first.toUpperCase())  // safe ✅
}

// exactOptionalPropertyTypes distinguishes undefined vs missing
interface Config {
  timeout?: number        // property may be ABSENT
  retries: number | undefined  // property must be PRESENT, value may be undefined
}
```

## ❌ Incorrect

```json
// ❌ strict disabled — type holes everywhere
{
  "compilerOptions": {
    "strict": false,
    "strictNullChecks": false
  }
}

// ❌ suppressImplicitAnyIndexErrors — silences real bugs
{
  "compilerOptions": {
    "suppressImplicitAnyIndexErrors": true
  }
}
```

```typescript
// ❌ Without noUncheckedIndexedAccess — silent runtime crash
const items = ['a', 'b', 'c']
const item = items[99]        // type: string — but runtime: undefined
item.toUpperCase()            // 💥 TypeError at runtime

// ❌ ts-ignore to bypass compiler — use @ts-expect-error with comment if needed
// @ts-ignore
const x: string = 42
```

## Checklist

- [ ] `"strict": true` in all `tsconfig.json` files
- [ ] `"noUncheckedIndexedAccess": true` enabled
- [ ] `"exactOptionalPropertyTypes": true` enabled
- [ ] `"noUnusedLocals"` and `"noUnusedParameters"` are `true`
- [ ] `"verbatimModuleSyntax": true` for correct `import type` usage
- [ ] No `@ts-ignore` in codebase — only `@ts-expect-error` with explanation

## See Also

- [ts-type-declarations](ts-type-declarations.md)
- [ts-patterns-anti-patterns](ts-patterns-anti-patterns.md)
