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
**Description:** Always await Promises (or void with comment). catch(error: unknown) + narrow. Result<T,E> for expected failures. No async without await. Promise.all for parallel.

## 7. Module & Import Structure (ts-modules-imports)

**Impact:** MAJOR  
**Description:** Path aliases over ../../, barrel files only at public boundaries, import type for types, consistent 5-group import order. No star imports.

## 8. Patterns & Anti-Patterns (ts-patterns-anti-patterns)

**Impact:** MAJOR  
**Description:** No any, as, enum, object type. Use unknown + narrow, string literal unions, satisfies for literal+constraint, Record<K,V>. @ts-expect-error with comment only.
