---
name: typescript-best-practices
description: >
  Strict TypeScript coding rules and patterns for production-grade codebases.
  Use when writing, reviewing, or refactoring TypeScript code.
  Covers: compiler configuration (tsconfig), type declarations, type narrowing,
  discriminated unions, generics, utility types (Partial/Pick/Omit/Readonly),
  async/await, error handling, Result pattern, module structure, path aliases,
  and anti-patterns (any, as, enum, object type, @ts-ignore).
  Triggers on: TypeScript, tsconfig, strict, generic, interface, type guard,
  narrowing, utility type, async, Promise, import, module, any, enum, satisfies.
license: MIT
metadata:
  version: 1.0.0
  language: TypeScript
  tags: [typescript, types, generics, strict, patterns, async, modules]
---

# TypeScript Best Practices — Skill Entry Point

## What This Skill Does

Enforces production-grade TypeScript across 18 rule sections.

- **Review** code for type safety violations
- **Refactor** unsafe patterns (`any`, `as`, `enum`, unhandled Promises)
- **Design** correct type structures (discriminated unions, generics, utility types)
- **Configure** `tsconfig.json` for maximum safety
- **Audit** module structure, import order, and path aliases

## When To Use

Activate when the user:
- Writes, reviews, or refactors TypeScript code
- Asks about `tsconfig.json` settings
- Uses or asks about `any`, `unknown`, `as`, `!`, `enum`, `satisfies`
- Asks how to type a function, generic, or utility type
- Asks about `async/await`, `Promise`, or error handling patterns
- Asks about `import`, module structure, or path aliases

**Do not activate for:** JavaScript-only code, CSS, HTML, or non-TypeScript configuration files.

---

## Version & Compatibility

- TypeScript **4.9+** required for `satisfies`
- TypeScript **5.0+** required for `verbatimModuleSyntax`
- If the project uses older TS, replace `satisfies` with explicit type annotations and use `importsNotUsedAsValues`

---

## Rule Interpretation

- Rules are defaults for production code.
- If an exception is needed, require a brief justification in review notes.

---

## Rule Categories by Priority

| Priority | Category              | Impact   | Rule file |
| -------- | --------------------- | -------- | --------- |
| 1        | Compiler Configuration| CRITICAL | `ts-compiler-strict` |
| 2        | Type Declarations     | CRITICAL | `ts-type-declarations` |
| 3        | Type Narrowing & Guards | CRITICAL | `ts-narrowing-guards` |
| 4        | Async & Error Handling| CRITICAL | `ts-async-errors` |
| 5        | Generics              | MAJOR    | `ts-generics` |
| 6        | Utility Types         | MAJOR    | `ts-utility-types` |
| 7        | Module & Import Structure | MAJOR | `ts-modules-imports` |
| 8        | Patterns & Anti-Patterns  | MAJOR | `ts-patterns-anti-patterns` |
| 9        | Project References    | MAJOR    | `ts-project-references` |
| 10       | Module Resolution & ESM/CJS | MAJOR | `ts-module-resolution` |
| 11       | Runtime Validation    | CRITICAL | `ts-runtime-validation` |
| 12       | Environment Config    | CRITICAL | `ts-env-config` |
| 13       | Error Handling Model  | MAJOR    | `ts-error-handling` |
| 14       | Immutable Updates     | MAJOR    | `ts-immutable-updates` |
| 15       | Public API Surface    | MAJOR    | `ts-public-api-surface` |
| 16       | Types in Tests        | MAJOR    | `ts-testing-types` |
| 17       | Declaration Files     | MAJOR    | `ts-declaration-files` |
| 18       | Type System Performance | MAJOR  | `ts-performance-types` |

## Quick Reference

- `ts-compiler-strict` — `strict: true`, `noUncheckedIndexedAccess`, `exactOptionalPropertyTypes`, no `@ts-ignore`
- `ts-type-declarations` — Avoid `any` in application code. `interface` for shapes, `type` for unions. `as const` when needed. `export type`.
- `ts-narrowing-guards` — Discriminated unions, `is` predicates, `never` exhaustiveness, Zod at boundaries
- `ts-async-errors` — `Result<T, E>` for expected errors. `catch(unknown)`. No floating Promises. `Promise.all`
- `ts-generics` — Constrain with `extends`. Semantic names (`TKey`, `TValue`). Rely on inference. `infer`
- `ts-utility-types` — `Partial`/`Omit` for inputs. `Pick` over redeclaration. `ReturnType`/`Awaited`. `Record`
- `ts-modules-imports` — Path aliases. `import type`. Barrels only at boundaries. 5-group import order
- `ts-patterns-anti-patterns` — Avoid `any`/`enum`/`object` in application code, avoid `as` outside validated boundaries. Use `satisfies`, `Record`, `unknown`
- `ts-project-references` — Project references for monorepos, composite builds, `tsc -b`
- `ts-module-resolution` — Align `module`/`moduleResolution`/`target` with runtime
- `ts-runtime-validation` — Validate all untrusted input at boundaries
- `ts-env-config` — Centralized, typed, validated env config
- `ts-error-handling` — Typed error model and `Result` usage
- `ts-immutable-updates` — Avoid mutation, use Readonly + structural sharing
- `ts-public-api-surface` — Explicit public exports, avoid deep imports
- `ts-testing-types` — Type-safe fixtures/tests, avoid `as any`
- `ts-declaration-files` — Scoped ambient declarations, prefer module augmentation
- `ts-performance-types` — Avoid heavy recursive types and huge unions

## File Map

```
SKILL.md             ← you are here (entry point + quick ref)
AGENTS.md            ← full compiled rules for agents
rules/
  _sections.md       ← index of all 8 sections with impact levels
  _template.md       ← template for adding new rule sections
  ts-compiler-strict.md
  ts-type-declarations.md
  ts-narrowing-guards.md
  ts-generics.md
  ts-utility-types.md
  ts-async-errors.md
  ts-modules-imports.md
  ts-patterns-anti-patterns.md
  ts-project-references.md
  ts-module-resolution.md
  ts-runtime-validation.md
  ts-env-config.md
  ts-error-handling.md
  ts-immutable-updates.md
  ts-public-api-surface.md
  ts-testing-types.md
  ts-declaration-files.md
  ts-performance-types.md
metadata.json        ← document metadata (version, sections, tags)
```

---

## Agent Workflow

### When reviewing TypeScript code

1. Read `AGENTS.md` for full rules (or `rules/ts-<name>.md` for a specific section)
2. Scan for critical violations first: `any`, unhandled Promises, missing narrowing, `strict: false`
3. Report violations grouped by rule file and severity
4. For each violation: name the rule, explain why, provide the correct TypeScript

### When writing TypeScript code

1. Start with `tsconfig.json` — verify `strict`, `noUncheckedIndexedAccess`, `exactOptionalPropertyTypes`
2. Define types: `interface` for shapes, `type` for unions, `as const` for literals
3. Use discriminated unions with a `kind` field for object-variant unions
4. Derive input types with `Partial<Omit<T, ...>>` (PATCH) / `Required<Omit<T, ...>>` (PUT)
5. Handle async with `Result<T, E>` for expected failures, `catch(unknown)` for crashes
6. Validate boundary inputs with schemas; avoid raw casts
7. Centralize and validate environment configuration
8. Configure path aliases; use `import type` for all type imports

### Output format (review)

```
## TypeScript Violations

### [ts-<rule-name>] Section Name — CRITICAL / MAJOR
- Code: [offending snippet]
- Violation: [explanation]
- Fix:
  [corrected TypeScript]

## Summary
X critical, Y major violations — [overall assessment]
```

---

## Global Compliance Checklist

**Critical — ship-blocking**
- [ ] `strict: true` in all `tsconfig.json` files
- [ ] `noUncheckedIndexedAccess: true`
- [ ] Zero `any` in source — use `unknown` + narrow
- [ ] All `catch` variables are `unknown` — narrow before use
- [ ] Every Promise is `await`-ed or `void`-ed with a comment
- [ ] All unions have `default: never` exhaustiveness guard

**Major — pre-release**
- [ ] All generics constrained with `extends`
- [ ] `Partial<Omit<T,...>>` for update inputs — no manual redeclaration
- [ ] `import type` for all type-only imports
- [ ] Path aliases in `tsconfig.json` — no `../../../`
- [ ] Zero `enum` — string literal unions + `as const`
- [ ] Zero `as` casts outside Zod/parse/test boundaries
- [ ] Zero `object` type — use `Record<K, V>` or interface
