# RESTful API Guidelines

A structured repository for RESTful API best practices optimized for agents and LLMs.

Cách cài skill vào Cursor, Claude Code, v.v.: xem [README gốc repo — Supported Platforms](../../README.md#supported-platforms-42-agents).

## Structure

- `rules/` — Individual rule files (one per rule)
  - `_sections.md` — Section metadata (titles, impacts, descriptions)
  - `_template.md` — Template for creating new rules
  - `api-*.md` — Individual rule files
- `metadata.json` — Document metadata (version, id, tags, sections)
- **`AGENTS.md`** — Compiled output for agents
- **`SKILL.md`** — Skill entry point and quick reference

## Rule Categories

| Priority | Category        | Prefix              |
| -------- | --------------- | ------------------- |
| 1        | Resource URLs   | `api-resource-`     |
| 2        | HTTP Methods    | `api-http-`         |
| 3        | Stateless       | `api-stateless`     |
| 4        | Status Codes    | `api-status-`       |
| 5        | Error Structure | `api-error-`        |
| 6        | Collections     | `api-collections-`  |
| 7        | Actions         | `api-actions-`      |
| 8        | Naming          | `api-naming-`       |
| 9        | Versioning      | `api-versioning`    |
| 10       | Predictability  | `api-boring-`       |
| 11       | Response Envelope | `api-response-envelope` |
| 12       | Idempotency & Retries | `api-idempotency-retry` |
| 13       | Auth & Rate Limits | `api-auth-rate-limits` |
| 14       | Pagination Links | `api-pagination-links` |

## Creating a New Rule

1. Copy `rules/_template.md` to `rules/api-area-description.md`
2. Choose the appropriate prefix (e.g. `api-` for all REST API rules)
3. Fill in the frontmatter and content (Incorrect / Correct examples)
4. Add the section to `rules/_sections.md` if it's a new category
5. Update `SKILL.md` Quick Reference and `AGENTS.md` Table of Contents

## Rule File Structure

Each rule file should have:

- YAML frontmatter: `title`, `impact`, `impactDescription`, `tags`
- Brief explanation and why it matters
- **Incorrect** examples with ❌
- **Correct** examples with ✅
- Optional reference link

## Audit Script

No audit script is included. Use `AGENTS.md` and rule files for review.
