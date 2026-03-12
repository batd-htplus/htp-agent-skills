---
name: laravel-best-practices
description: >
  Comprehensive Laravel best practices and coding standards for production-grade applications.
  Use when writing, reviewing, or refactoring Laravel code, including database migrations,
  Eloquent models, API endpoints, testing, security, performance optimization, and coding standards.
  Covers: database migrations and N+1 prevention, Eloquent best practices, RESTful API design,
  testing patterns, security (authentication, authorization, SQL injection prevention),
  performance (caching, queues, query optimization), and coding standards (PSR-12, strict types,
  Repository Pattern, Service Layer).
  Triggers on: Laravel, PHP, migrations, Eloquent, models, API, endpoints, controllers,
  testing, security, authentication, authorization, performance, caching, queues, PSR-12,
  repository, service, FormRequest, API Resource, policies, Sanctum, Redis, jobs.
license: MIT
metadata:
  version: 1.0.0
  language: PHP/Laravel
  tags: [laravel, php, api, database, testing, security, performance, coding-standards]
---

# Laravel Best Practices — Skill Entry Point

## What This Skill Does

Comprehensive Laravel best practices and coding standards for production-grade applications. Contains rules across 6 categories covering database, testing, security, performance, API standards, and coding conventions.

- **Review** Laravel code for best practices violations and security issues
- **Refactor** code to follow Laravel conventions and patterns
- **Design** new features following Repository Pattern and Service Layer architecture
- **Optimize** database queries, caching, and background job processing
- **Audit** API endpoints, security practices, and coding standards

## When To Use

Activate when the user:
- Writes, reviews, or refactors Laravel code (migrations, models, controllers, services)
- Designs or implements API endpoints
- Writes tests (Feature or Unit tests)
- Implements authentication, authorization, or security features
- Optimizes performance (caching, queues, queries)
- Sets up coding standards or folder structure
- Works with Eloquent ORM, migrations, FormRequests, API Resources
- Needs help with Laravel patterns (Repository, Service Layer, Policies)

**Do not activate for:** Non-Laravel PHP frameworks, pure JavaScript/frontend code, or backend code without Laravel context.

---

## Rule Categories by Priority

| Priority | Category | Impact | Prefix |
|----------|----------|--------|--------|
| 1 | Database & Eloquent | CRITICAL | `db-`, `eloquent-` |
| 2 | Security | CRITICAL | `security-` |
| 3 | API Standards | CRITICAL | `api-` |
| 4 | Testing | HIGH | `test-` |
| 5 | Performance | HIGH | `perf-` |
| 6 | Coding Standards | HIGH | `code-` |

## Quick Reference

### 1. Database & Eloquent (CRITICAL)
- `db-migrations-only` — Never modify database directly, always use migrations
- `db-migrations-reversible` — Always implement `down()` in migrations
- `eloquent-prevent-n-plus-one` — Always eager load relationships
- `eloquent-fillable-only` — Never use `$guarded = []`
- `eloquent-soft-deletes` — Use SoftDeletes for main entities
- `eloquent-indexes` — Add indexes for foreign keys and WHERE/ORDER BY columns
- `eloquent-transactions` — Wrap multi-step writes in transactions
- `eloquent-chunk-large-datasets` — Use chunk() or lazy() for large result sets

### 2. Security (CRITICAL)
- `security-no-sql-concatenation` — Never concatenate SQL strings
- `security-policies` — Use Policies for authorization, never in controllers
- `security-no-env-commit` — Never commit `.env` files
- `security-no-error-details-production` — Never expose error details in production
- `security-sanctum-auth` — Use Laravel Sanctum for API tokens (24h max expiry)
- `security-validate-input` — Always validate input with FormRequest
- `security-encrypt-sensitive` — Encrypt sensitive data
- `security-no-sensitive-logging` — Never log passwords, tokens, or PII

### 3. API Standards (CRITICAL)
- `api-unified-response` — Use unified JSON response format
- `api-versioning` — All routes prefixed with `/api/v1/`
- `api-status-codes` — Use semantically correct HTTP status codes
- `api-resources` — Always use API Resources, never raw models
- `api-form-requests` — Always use FormRequest for validation
- `api-restful-routes` — Follow RESTful route conventions
- `api-rate-limiting` — Apply rate limiting to endpoints

### 4. Testing (HIGH)
- `test-coverage-requirements` — Feature tests ≥70%, Unit tests ≥80%, Critical flows 100%
- `test-refresh-database` — Use RefreshDatabase trait
- `test-naming-convention` — Use `it_should_[action]_when_[condition]` format
- `test-feature-pattern` — Follow Feature test pattern with assertions
- `test-unit-pattern` — Follow Unit test pattern for services
- `test-factories` — Every model must have factory with states
- `test-mock-external` — Mock external services, never call real APIs

### 5. Performance (HIGH)
- `perf-queue-heavy-tasks` — Heavy tasks (emails, file processing) must go to queue
- `perf-job-pattern` — Follow Job implementation pattern with retry/timeout
- `perf-redis-caching` — Use Redis caching with tags for targeted invalidation
- `perf-config-cache` — Cache config, routes, views in production
- `perf-pagination` — Never return all records, always paginate
- `perf-select-columns` — Select only required columns, never SELECT *
- `perf-queue-priorities` — Configure queue priorities (critical, high, default, low)

### 6. Coding Standards (HIGH)
- `code-strict-types` — Every file must have `declare(strict_types=1)`
- `code-type-declarations` — All methods must have type hints
- `code-constructor-promotion` — Use readonly constructor promotion (PHP 8.1)
- `code-psr-12` — Follow PSR-12 file format (UTF-8, LF, 4 spaces, 120 chars)
- `code-naming-conventions` — Follow Laravel naming conventions
- `code-folder-structure` — Follow standard folder structure with API versioning
- `code-repository-pattern` — All database access through Repository
- `code-service-layer` — Business logic in Services, controllers thin
- `code-enums` — Use PHP 8.1 Enums instead of constants

## File Map

```
SKILL.md             ← you are here (entry point + quick ref)
AGENTS.md            ← full compiled rules for agents (to be generated)
rules/
  _sections.md       ← index of all 6 sections with impact levels
  _template.md       ← template for creating new rules
  db-*.md            ← Database & Eloquent rules
  security-*.md      ← Security rules
  api-*.md           ← API Standards rules
  test-*.md          ← Testing rules
  perf-*.md          ← Performance rules
  code-*.md          ← Coding Standards rules
references/          ← Supporting documentation
  migration-naming.md
  assertion-cheatsheet.md
  owasp-top10-laravel.md
  response-examples.md
  psr-12-summary.md
scripts/             ← Helper scripts
  check-standards.sh
  security-scan.sh
  optimize.sh
  run-tests.sh
metadata.json        ← document metadata (version, tags)
```

---

## Agent Workflow

### When reviewing Laravel code

1. Read `AGENTS.md` for full rules (or `rules/<prefix>-*.md` for a specific category)
2. Scan for critical violations first: N+1 queries, SQL injection, missing validation, security issues
3. Report violations grouped by category and severity
4. For each violation: name the rule, explain why, provide the correct code

### When writing Laravel code

1. **Database**: Create migrations (never modify DB directly), prevent N+1 with eager loading
2. **Security**: Use Policies for authorization, validate all input, never expose error details in production
3. **API**: Use unified JSON format, version routes, use FormRequests and API Resources
4. **Testing**: Write Feature/Unit tests with proper naming, use factories, mock external services
5. **Performance**: Queue heavy tasks, use Redis caching, paginate results, select only needed columns
6. **Standards**: Use strict types, type hints, Repository Pattern, Service Layer, PSR-12

### Output format (review)

```
## Laravel Issues

### [category-rule-name] Category Name — CRITICAL / HIGH / MEDIUM
- Code: [offending snippet]
- Issue: [explanation]
- Fix:
  [corrected Laravel code]

## Summary
X critical, Y high, Z medium issues — [overall assessment]
```

---

## How to Use

Read individual rule files for detailed explanations and code examples:

```
rules/db-migrations-only.md
rules/eloquent-prevent-n-plus-one.md
rules/security-policies.md
rules/api-unified-response.md
```

Each rule file contains:
- Brief explanation of why it matters
- Incorrect code example with explanation
- Correct code example with explanation
- Additional context and references

## Full Compiled Document

For the complete guide with all rules expanded: **`AGENTS.md`**
