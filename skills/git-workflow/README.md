# Git Workflow Best Practices

A comprehensive Git workflow skill optimized for AI agents and LLMs.

## Structure

- `rules/` — Individual rule files (one per rule)
  - `_sections.md` — Section metadata (titles, impacts, descriptions)
  - `_template.md` — Template for creating new rules
  - `git-branch-*.md`, `git-commit-*.md` — Branch Naming & Commits rules
  - `git-pr-*.md` — Pull Request Workflow rules
  - `git-review-*.md`, `git-flow-*.md` — Code Review Guidelines rules
- `references/` — Supporting documentation
- `scripts/` — Helper scripts for branch creation and commit validation
- `metadata.json` — Document metadata (version, sections, tags)
- **`SKILL.md`** — Skill entry point and quick reference
- **`AGENTS.md`** — Compiled output for agents (to be generated)

## Rule Categories

| Priority | Category | Impact | Prefix |
|----------|----------|--------|--------|
| 1 | Branch Naming & Commits | CRITICAL | `git-branch-`, `git-commit-` |
| 2 | Pull Request Workflow | HIGH | `git-pr-` |
| 3 | Code Review Guidelines | MEDIUM | `git-review-`, `git-flow-` |

## Creating a New Rule

1. Copy `rules/_template.md` to `rules/git-<category>-<description>.md`
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

**Why it matters:** Explain the impact, consequences, or benefits.

**❌ Incorrect:**

```bash
# Bad example
```

**✅ Correct:**

```bash
# Good example
```

**See also:** `related-rule.md`, `references/reference-file.md`
```

## Impact Levels

- **CRITICAL** — Ship-blocking issues (incorrect branch naming, force push to protected branches)
- **HIGH** — Significant issues (PR workflow violations, missing templates)
- **MEDIUM** — Style or consistency issues (review comment format, Git Flow details)

## Scripts

- `scripts/new-branch.sh` — Interactive script to create a properly named branch
- `scripts/commit-check.sh` — Validate commit message format before push

## References

- `references/conventional-commits-cheatsheet.md` — Quick reference card for Conventional Commits
