# Sections

This file defines all sections, their ordering, impact levels, and descriptions.
The section ID (in parentheses) is the filename prefix used to group rules.

---

## 1. Compiler Configuration (ts-compiler-strict)

**Impact:** CRITICAL  
**Description:** `tsconfig.json` settings that must be enabled for safe TypeScript: strict, noUncheckedIndexedAccess, exactOptionalPropertyTypes, verbatimModuleSyntax. Never skipLibCheck in libs; never @ts-ignore.

## 2. Type Declarations (ts-type-declarations)

**Impact:** CRITICAL  
**Description:** How to define, name, and export types: interface for shapes, type for unions, never any (use unknown), as const, export type, no Hungarian prefixes.

## 3. Type Narrowing & Guards (ts-narrowing-guards)

**Impact:** CRITICAL  
**Description:** Discriminated unions with kind/type, type predicates (is), never exhaustiveness, Zod for runtime+static narrowing. No as-casts to bypass narrowing.

## 4. Generics (ts-generics)

**Impact:** MAJOR  
**Description:** Constrain type parameters with extends, semantic names (TKey, TValue), rely on inference, use infer for sub-type extraction. No unconstrained T used as if it has properties.

## 5. Utility Types (ts-utility-types)

**Impact:** MAJOR  
**Description:** Partial/Required for update/replace schemas, Pick/Omit for scoped types, Readonly for immutable data, ReturnType/Parameters/Awaited for derived types, Record for typed maps.

## 6. Async & Error Handling (ts-async-errors)

**Impact:** CRITICAL  
**Description:** Always await Promises (or void with comment). catch(error: unknown) + narrow. Result<T,E> for expected failures. Avoid async without await. Promise.all for parallel.

## 7. Module & Import Structure (ts-modules-imports)

**Impact:** MAJOR  
**Description:** Path aliases over ../../, barrel files only at public boundaries, import type for types, consistent 5-group import order. No star imports.

## 8. Patterns & Anti-Patterns (ts-patterns-anti-patterns)

**Impact:** MAJOR  
**Description:** Avoid any/as/enum/object in application code. Use unknown + narrow, string literal unions, satisfies for literal+constraint, Record<K,V>. @ts-expect-error with comment only.

## 9. Project References (ts-project-references)

**Impact:** MAJOR  
**Description:** Use project references for multi-package repos. Enable composite/declaration for incremental builds and boundary enforcement.

## 10. Module Resolution & ESM/CJS (ts-module-resolution)

**Impact:** MAJOR  
**Description:** Align module/moduleResolution/target with runtime. Avoid mismatches between Node ESM, CJS, and bundlers.

## 11. Runtime Validation at Boundaries (ts-runtime-validation)

**Impact:** CRITICAL  
**Description:** Validate all untrusted input at boundaries (API, env, JSON). Use schema parsing, never cast raw data.

## 12. Environment Configuration (ts-env-config)

**Impact:** CRITICAL  
**Description:** Centralized, typed env parsing with validation and fail-fast behavior. No scattered process.env usage.

## 13. Error Handling Model (ts-error-handling)

**Impact:** MAJOR  
**Description:** Typed error model with codes and causes. Use Result for expected failures and preserve root causes.

## 14. Immutable Updates (ts-immutable-updates)

**Impact:** MAJOR  
**Description:** Avoid mutating shared state. Use Readonly inputs and structural sharing for updates.

## 15. Public API Surface (ts-public-api-surface)

**Impact:** MAJOR  
**Description:** Explicit public exports. Avoid deep imports by consumers. Use export type for type-only exports.

## 16. Types in Tests (ts-testing-types)

**Impact:** MAJOR  
**Description:** Keep tests type-safe. Avoid as any, use satisfies/builders for fixtures.

## 17. Declaration Files (ts-declaration-files)

**Impact:** MAJOR  
**Description:** Keep ambient declarations scoped and minimal. Prefer module augmentation over global pollution.

## 18. Type System Performance (ts-performance-types)

**Impact:** MAJOR  
**Description:** Avoid complex recursive types and huge unions. Prefer simple types for editor performance.
