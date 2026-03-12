# Laravel Best Practices

A comprehensive Laravel best practices skill optimized for AI agents and LLMs.

## Structure

- `rules/` — Individual rule files (one per rule)
  - `_sections.md` — Section metadata (titles, impacts, descriptions)
  - `_template.md` — Template for creating new rules
  - `db-*.md`, `eloquent-*.md` — Database & Eloquent rules
  - `security-*.md` — Security rules
  - `api-*.md` — API Standards rules
  - `test-*.md` — Testing rules
  - `perf-*.md` — Performance rules
  - `code-*.md` — Coding Standards rules
- `references/` — Supporting documentation
- `scripts/` — Helper scripts for validation and optimization
- `metadata.json` — Document metadata (version, sections, tags)
- **`SKILL.md`** — Skill entry point and quick reference
- **`AGENTS.md`** — Compiled output for agents (to be generated)

## Rule Categories

| Priority | Category | Impact | Prefix |
|----------|----------|--------|--------|
| 1 | Database & Eloquent | CRITICAL | `db-`, `eloquent-` |
| 2 | Security | CRITICAL | `security-` |
| 3 | API Standards | CRITICAL | `api-` |
| 4 | Testing | HIGH | `test-` |
| 5 | Performance | HIGH | `perf-` |
| 6 | Coding Standards | HIGH | `code-` |

## Creating a New Rule

1. Copy `rules/_template.md` to `rules/<prefix>-<description>.md`
2. Choose the appropriate prefix based on category
3. Fill in the frontmatter and content
4. Ensure you have clear examples with explanations
5. Add the rule to `SKILL.md` Quick Reference section

## Rule File Structure

Each rule file should follow this structure:

```markdown
---
title: Rule Title Here
impact: CRITICAL / HIGH / MEDIUM
impactDescription: Brief description of impact
tags: tag1, tag2, tag3
---

## Rule Title Here

Brief explanation of the rule and why it matters.

**❌ Incorrect:**

```php
// Bad code example
```

**✅ Correct:**

```php
// Good code example
```

Optional explanatory text after examples.

**See also:** `related-rule.md`, `references/reference-file.md`
```

## Impact Levels

- **CRITICAL** — Ship-blocking issues (security vulnerabilities, data loss, major performance issues)
- **HIGH** — Significant issues (best practices violations, maintainability problems)
- **MEDIUM** — Style or consistency issues

## Scripts

- `scripts/check-standards.sh` — Runs Pint and PHPStan to validate coding standards
- `scripts/security-scan.sh` — Runs basic security checks
- `scripts/optimize.sh` — Run production optimization commands
- `scripts/run-tests.sh` — Run tests with coverage report

## References

- `references/migration-naming.md` — Migration naming conventions
- `references/assertion-cheatsheet.md` — Laravel test assertion quick reference
- `references/owasp-top10-laravel.md` — OWASP Top 10 mapped to Laravel mitigations
- `references/response-examples.md` — Full API response example library
- `references/psr-12-summary.md` — PSR-12 quick reference

## Migration from Sub-Skills

This skill was consolidated from 6 sub-skills:
- `laravel-database` → `db-*`, `eloquent-*` rules
- `laravel-security` → `security-*` rules
- `laravel-api-standards` → `api-*` rules
- `laravel-testing` → `test-*` rules
- `laravel-performance` → `perf-*` rules
- `laravel-coding-standards` → `code-*` rules

To extract remaining rules from old SKILL.md files:
1. Read each sub-skill's SKILL.md
2. Extract each rule section into a separate `rules/<prefix>-<name>.md` file
3. Follow the template structure above
4. Update `SKILL.md` Quick Reference section
