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

Enforces production-grade TypeScript across 8 rule sections (34 rules total).

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

## Quick Reference

- `ts-compiler-strict` — `strict: true`, `noUncheckedIndexedAccess`, `exactOptionalPropertyTypes`, no `@ts-ignore`
- `ts-type-declarations` — No `any`. `interface` for shapes, `type` for unions. `as const`. `export type`.
- `ts-narrowing-guards` — Discriminated unions, `is` predicates, `never` exhaustiveness, Zod at boundaries
- `ts-async-errors` — `Result<T, E>` for expected errors. `catch(unknown)`. No floating Promises. `Promise.all`
- `ts-generics` — Constrain with `extends`. Semantic names (`TKey`, `TValue`). Rely on inference. `infer`
- `ts-utility-types` — `Partial`/`Omit` for inputs. `Pick` over redeclaration. `ReturnType`/`Awaited`. `Record`
- `ts-modules-imports` — Path aliases. `import type`. Barrels only at boundaries. 5-group import order
- `ts-patterns-anti-patterns` — No `any`, `as`, `enum`, `object`. Use `satisfies`, `Record`, `unknown`

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
metadata.json        ← document metadata (version, sections, tags)
audit.ts             ← TypeScript AST-based audit CLI (optional)
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
3. Use discriminated unions with a `kind` field for any type that has variants
4. Derive input types with `Partial<Omit<T, ...>>` (PATCH) / `Required<Omit<T, ...>>` (PUT)
5. Handle async with `Result<T, E>` for expected failures, `catch(unknown)` for crashes
6. Configure path aliases; use `import type` for all type imports

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
