---
title: Module Resolution & ESM/CJS Alignment
impact: MAJOR
impactDescription: Misaligned module settings cause runtime import failures
tags: typescript, module, moduleResolution, esm, cjs, node16, bundler
---

# Module Resolution & ESM/CJS Alignment

**Impact:** MAJOR

## Rules

1. **Match `module`/`moduleResolution` to runtime** — `node16`/`nodenext` for Node ESM, `bundler` for bundlers.
2. **Keep `target` aligned with runtime** — do not emit syntax your runtime cannot execute.
3. **Do not mix CJS and ESM blindly** — choose one per package and document interop.

## ✅ Correct

```json
// Node ESM package
{
  "compilerOptions": {
    "module": "NodeNext",
    "moduleResolution": "NodeNext",
    "target": "ES2022"
  }
}
```

```json
// Bundler-managed app
{
  "compilerOptions": {
    "module": "ESNext",
    "moduleResolution": "bundler",
    "target": "ES2022"
  }
}
```

## ❌ Incorrect

```json
// Mismatch: bundler in Node runtime, or NodeNext in pure CJS package
{ "module": "CommonJS", "moduleResolution": "bundler" }
```

## Checklist

- [ ] `module` and `moduleResolution` match runtime/bundler
- [ ] `target` matches supported runtime features
- [ ] ESM/CJS mode is consistent per package

## See Also

- [ts-modules-imports](ts-modules-imports.md)
- [ts-compiler-strict](ts-compiler-strict.md)
