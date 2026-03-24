---
title: Pull Request Template
impact: HIGH
impactDescription: PR template ensures all necessary information is provided, proper checklist is followed, and reviewers have context. Every PR MUST be filled out completely.
tags: git, pull-request, template, checklist
---

## Pull Request Template

Every PR MUST be complete, actionable, and review-ready.
Use this template in `.github/pull_request_template.md`.

## Writing Rules

- Keep title and summary specific
- Separate included scope from excluded scope
- Provide reproducible test steps
- Link ticket/spec references
- Do not leave placeholder text in final PR

## Template

```markdown
## Title
[TYPE](ID-12345): short imperative summary

Allowed TYPE: `BUG` `FEAT` `HOTFIX` `REFACTOR` `CHORE` `DOCS`
If no tracking ticket exists, use `ID-N/A` and explain why in Description.

## Description
What changed and why. Keep to 3-8 bullets or short paragraphs.

## Scope
Included:
- ...

Not included:
- ...

## Ticket
- Ticket: ID-12345
- Reference: <ticket_url>

## Labels
- Type: `type/bug` | `type/feature` | `type/hotfix` | `type/refactor` | `type/chore` | `type/docs`
- Area: `area/<module>`
- Risk: `risk/low` | `risk/medium` | `risk/high`
- Optional: `breaking-change`, `needs-migration`, `needs-docs`

## References
- Related PRs: #...
- Related docs/specs: ...

## Type of Change
- [ ] BUG
- [ ] FEAT
- [ ] HOTFIX
- [ ] REFACTOR
- [ ] CHORE
- [ ] DOCS
- [ ] BREAKING CHANGE

## Checklist
- [ ] Self-reviewed
- [ ] Tests added/updated (or justified why not)
- [ ] CI is green
- [ ] No secrets committed
- [ ] Backward compatibility assessed (or marked as BREAKING CHANGE)
- [ ] Docs updated (if applicable)
- [ ] Migration includes rollback (if applicable)

## How to Test
Step-by-step instructions to validate the change.
1. ...
2. ...

## Evidence
- Screenshots / logs / API responses (if applicable)
```

## Rejection Criteria

PR is not ready for review if any of these applies:

- Missing ticket reference without explanation
- Empty or generic description ("update code", "fix bug")
- No test instructions for behavioral changes
- Checklist not completed
- PR title does not follow `[TYPE](ID-<number>): ...`

**See also:** `git-pr-size-rules.md`, `git-review-prefixes.md`
