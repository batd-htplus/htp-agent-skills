# TypeScript Guidelines

Strict TypeScript best practices for production-grade codebases, optimized for agents and LLMs.

For installation in Cursor, Claude Code, etc., see the repo README: [Supported Platforms](../../README.md#supported-platforms-42-agents).

## Structure

- `rules/` — Individual rule files (one per topic)
  - `_sections.md` — Section metadata (titles, impacts, descriptions)
  - `_template.md` — Template for creating new rules
  - `ts-*.md` — Rule files with descriptive names
- `metadata.json` — Document metadata (version, sections, tags)
- **`AGENTS.md`** — Compiled output for agents
- **`SKILL.md`** — Skill entry point and quick reference

## Rule Files (by priority)

| Priority | File | Impact |
| -------- | ---- | ------ |
| 1 | `ts-compiler-strict.md` | CRITICAL |
| 2 | `ts-type-declarations.md` | CRITICAL |
| 3 | `ts-narrowing-guards.md` | CRITICAL |
| 4 | `ts-async-errors.md` | CRITICAL |
| 5 | `ts-generics.md` | MAJOR |
| 6 | `ts-utility-types.md` | MAJOR |
| 7 | `ts-modules-imports.md` | MAJOR |
| 8 | `ts-patterns-anti-patterns.md` | MAJOR |
| 9 | `ts-project-references.md` | MAJOR |
| 10 | `ts-module-resolution.md` | MAJOR |
| 11 | `ts-runtime-validation.md` | CRITICAL |
| 12 | `ts-env-config.md` | CRITICAL |
| 13 | `ts-error-handling.md` | MAJOR |
| 14 | `ts-immutable-updates.md` | MAJOR |
| 15 | `ts-public-api-surface.md` | MAJOR |
| 16 | `ts-testing-types.md` | MAJOR |
| 17 | `ts-declaration-files.md` | MAJOR |
| 18 | `ts-performance-types.md` | MAJOR |

## Creating a New Rule

1. Copy `rules/_template.md` to `rules/ts-area-description.md`
2. Use prefix `ts-` and a descriptive name (e.g. `ts-error-boundaries.md`)
3. Fill in frontmatter (`title`, `impact`, `tags`) and content (Rules, ✅ Correct, ❌ Incorrect, Checklist, See Also)
4. Add the section to `rules/_sections.md`
5. Update `SKILL.md` Quick Reference and `AGENTS.md` Section Index
6. Update `metadata.json` `sections` array

## Rule File Structure

Each rule file should have:

- YAML frontmatter: `title`, `impact`, `impactDescription`, `tags`
- **Rules** — numbered list of imperatives
- **✅ Correct** — code examples with brief comments
- **❌ Incorrect** — anti-patterns with explanation
- **Checklist** — actionable items for review
- **See Also** — links to related rule files (by filename, e.g. `ts-narrowing-guards.md`)

## Impact Levels

- **CRITICAL** — Runtime errors, type holes, or silent unsafety. Fix before ship.
- **MAJOR** — Maintainability or hard-to-catch bugs. Fix before release.
- **MINOR** — Style or consistency. Fix in next iteration.
