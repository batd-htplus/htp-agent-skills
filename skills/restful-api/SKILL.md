---
name: restful-api-best-practices
description: >
  Strict RESTful API design, review, and refactoring guidelines.
  Use when the user asks to design a new API, review existing endpoints,
  refactor non-RESTful routes, audit HTTP method usage, status codes,
  error structures, versioning, pagination, or resource modeling.
  Triggers on keywords: API design, REST, endpoints, routes, HTTP methods,
  status codes, CRUD, resource, controller, versioning, pagination.
license: MIT
metadata:
  version: 1.0.0
  maintainer: restful-api-best-practices
  tags: [api, rest, http, backend, design, review]
---

# RESTful API Best Practices — Skill Entry Point

## What This Skill Does

This skill enforces strict RESTful API design principles. It helps agents:

- **Design** new APIs from scratch following REST constraints
- **Review** existing API definitions and identify violations
- **Refactor** non-REST endpoints into compliant alternatives
- **Audit** HTTP method usage, status codes, error payloads, and naming
- **Validate** resource modeling, versioning, pagination, and predictability

## When To Use This Skill

Activate when the user:

- Asks to "design an API" for any domain
- Shares a list of routes/endpoints to review
- Uses words like REST, HTTP method, status code, resource, versioning, pagination
- Asks why an API feels inconsistent or hard to use
- Asks for help modeling actions (cancel, approve, publish) in a REST API

Do NOT activate for: GraphQL, gRPC/Protobuf, WebSocket protocol design, or internal function naming only.

---

## Rule Categories by Priority

| Priority | Category        | Impact   | Prefix          |
| -------- | --------------- | -------- | --------------- |
| 1        | Resource URLs   | CRITICAL | `api-resource-` |
| 2        | HTTP Methods    | CRITICAL | `api-http-`     |
| 3        | Stateless       | HIGH     | `api-stateless` |
| 4        | Status Codes    | CRITICAL | `api-status-`   |
| 5        | Error Structure | HIGH     | `api-error-`     |
| 6        | Collections     | HIGH     | `api-collections-` |
| 7        | Actions         | HIGH     | `api-actions-`  |
| 8        | Naming          | MEDIUM   | `api-naming-`   |
| 9        | Versioning      | HIGH     | `api-versioning` |
| 10       | Predictability  | MEDIUM   | `api-boring-`   |

## File Map

```
SKILL.md             ← you are here (entry point + quick ref)
AGENTS.md            ← full compiled rules for agents (4.9KB, 140 lines)
rules/
  _sections.md       ← index of all 10 sections with impact levels
  _template.md       ← template for creating new rules
  api-resource-*.md   ← Resource URLs (1 rule)
  api-http-*.md       ← HTTP Methods (1 rule)
  api-stateless.md   ← Stateless (1 rule)
  api-status-*.md    ← Status Codes (1 rule)
  api-error-*.md     ← Error Structure (1 rule)
  api-collections-*.md ← Collections (1 rule)
  api-actions-*.md   ← Actions (1 rule)
  api-naming-*.md    ← Naming (1 rule)
  api-versioning.md  ← Versioning (1 rule)
  api-boring-*.md    ← Predictability (1 rule)
metadata.json         ← document metadata (version, maintainer, tags)
audit.sh              ← audit script for route validation (optional)
```

---

## Quick Reference

- `api-resource-oriented-urls` — URLs are nouns, plural; no verbs
- `api-http-methods` — GET read-only; POST/PUT/PATCH/DELETE for mutations
- `api-stateless` — No server session; auth per request
- `api-status-codes` — Never 200 for errors; use 201/204/4xx/5xx
- `api-error-structure` — `error.code` + `error.message` + optional `details`
- `api-collections-pagination` — `?page`, `?limit`, `?sort`, `?order`, `meta`
- `api-actions-subresource` — `POST /v1/{resource}/{id}/{action}`
- `api-naming-conventions` — kebab-case URLs, snake_case JSON, plural, `{id}`
- `api-versioning` — `/v1/`, `/v2/` for breaking changes
- `api-boring-predictable` — Predictable, guessable endpoints

---

## Agent Workflow

### When reviewing REST APIs

1. Read `AGENTS.md` for full rules (or `rules/api-*.md` for a specific rule)
2. Scan for critical violations first: wrong HTTP methods, verbs in URLs, 200 for errors
3. Report violations grouped by rule and severity
4. For each violation: name the rule, explain why, provide the corrected endpoint

### When designing REST APIs

1. Identify resources (nouns only)
2. Map operations to HTTP methods (see `rules/api-http-methods.md`)
3. Build URL structure: plural, max 2 levels nesting
4. Model actions as `POST /{resource}/{id}/{action}` (see `rules/api-actions-subresource.md`)
5. Apply versioning: `/v1/`, `/v2/`
6. Define error structure (see `rules/api-error-structure.md`)
7. Define collection params: `?page`, `?limit`, `?sort`, `?filter[field]`

### Output format (review)

```
## REST API Violations

### [api-rule-name] Rule Name — CRITICAL / HIGH / MEDIUM
- Endpoint: [offending endpoint]
- Violation: [explanation]
- Fix:
  [corrected endpoint]

## Summary
X critical, Y high, Z medium violations — [overall assessment]
```

---

## How to Use

Read individual rule files for detailed explanations and examples:

```
rules/api-resource-oriented-urls.md
rules/api-http-methods.md
rules/api-status-codes.md
```

Each rule file contains incorrect vs correct examples and references.

## Full Compiled Document

For the complete guide in one place: **`AGENTS.md`**

---

## Inputs Needed

**Before designing:** Domain (entities), operations, API version, auth model.

**Before reviewing:** Full list of endpoints (method + URL); optional request/response samples.

---

## Step-by-Step Procedure

### Designing a New API

1. Identify resources (nouns only).
2. Map operations to HTTP methods (see `rules/api-http-methods.md`).
3. Build URL structure: plural, max 2 levels nesting.
4. Model actions as `POST /{resource}/{id}/{action}` (see `rules/api-actions-subresource.md`).
5. Apply versioning: `/v1/`, `/v2/`.
6. Define error structure (see `rules/api-error-structure.md`).
7. Define collection params: `?page`, `?limit`, `?sort`, `?filter[field]`.

### Reviewing an Existing API

1. Run through all 10 rules in `rules/` (or use `AGENTS.md`).
2. For each violation: state rule, explain why, give corrected endpoint.
3. Summarize by severity: Critical (wrong method, verb in URL, 200 for errors), Major (no versioning, no pagination, inconsistent naming), Minor (nesting, missing PATCH).

---

## Output Format

**Design:** Resource structure → Endpoints (METHOD /v1/...) → Design notes.

**Review:** Violations (rule, offending endpoint, why, corrected) → Summary counts.

---

## Validation Checklist

- [ ] URLs contain only nouns (no verbs)
- [ ] Resources plural
- [ ] HTTP methods match intent (no GET for mutations)
- [ ] No 200 for errors
- [ ] Error responses include `error_code` and `message`
- [ ] Collections support `?page`, `?limit`, `?sort`
- [ ] Actions as `POST /{resource}/{id}/{action}`
- [ ] Routes prefixed with `/v{n}/`
- [ ] Naming consistent (kebab-case, snake_case in JSON)
- [ ] Stateless auth

---

## Audit Script

Run `./audit.sh <routes-file>` (one route per line, e.g. `GET /v1/users`). Covers Rules 1, 2, 8, 9 via pattern matching; others need manual review.

---

## Common Failure Modes

| Mistake | Fix |
|--------|-----|
| `GET /createUser` | `POST /v1/users` |
| `POST /cancelOrder` | `POST /v1/orders/{id}/cancel` |
| `200 { "error": "not found" }` | `404` with error body |
| No `/v1/` prefix | Add versioning |
| `/user` (singular) | `/users` |
| `GET /users?action=delete` | `DELETE /v1/users/{id}` |
