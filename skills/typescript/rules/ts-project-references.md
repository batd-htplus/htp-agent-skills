---
title: Project References
impact: MAJOR
impactDescription: Project references keep large codebases fast and enforce build boundaries
tags: typescript, project-references, monorepo, composite, build
---

# Project References

**Impact:** MAJOR

## Rules

1. **Use project references for multi-package repos** — enables incremental builds and enforces dependency boundaries.
2. **Enable `composite` and `declaration` in referenced projects** — required for `tsc -b`.
3. **Keep a thin root `tsconfig.json` that references leaf projects** — avoid a single giant compile.

## ✅ Correct

```json
// packages/api/tsconfig.json
{
  "compilerOptions": {
    "composite": true,
    "declaration": true,
    "declarationMap": true
  },
  "references": [{ "path": "../shared" }]
}
```

```json
// tsconfig.json (repo root)
{
  "files": [],
  "references": [
    { "path": "packages/shared" },
    { "path": "packages/api" }
  ]
}
```

```bash
tsc -b
```

## ❌ Incorrect

```json
// Single tsconfig for all packages — slow and leaky
{ "include": ["packages/**/*"] }
```

## Checklist

- [ ] Monorepos use project references
- [ ] Referenced projects have `composite: true`
- [ ] Root config uses `references` instead of a huge `include`

## See Also

- [ts-compiler-strict](ts-compiler-strict.md)
- [ts-modules-imports](ts-modules-imports.md)
