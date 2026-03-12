---
name: git-workflow-best-practices
description: >
  Git Flow branching strategy, Conventional Commits format, Pull Request templates,
  and code review guidelines for collaborative development.
  Use when starting new features, writing commit messages, creating Pull Requests,
  reviewing code, or merging branches.
  Covers: branch naming conventions, conventional commits, PR workflow, code review
  guidelines, Git Flow lifecycle, and best practices for team collaboration.
  Triggers on: git, commit, branch, pull request, PR, merge, rebase, code review,
  conventional commits, git flow, branching strategy, hotfix, feature, bugfix.
license: MIT
metadata:
  version: 1.0.0
  tags: [git, workflow, commits, pull-requests, code-review, branching]
---

# Git Workflow Best Practices — Skill Entry Point

## What This Skill Does

Git Flow branching strategy, Conventional Commits format, Pull Request templates, and code review guidelines for collaborative development.

- **Review** commit messages and PRs for compliance with standards
- **Guide** branch creation and naming conventions
- **Enforce** Conventional Commits format
- **Standardize** PR workflow and review process
- **Audit** Git Flow lifecycle and merge practices

## When To Use

Activate when the user:
- Starts a new feature, bug fix, or chore
- Writes a commit message
- Creates a Pull Request
- Reviews someone else's code
- Merges branches
- Asks about Git workflow, branching strategy, or commit conventions
- Needs help with Git Flow, rebasing, or code review

**Do not activate for:** Git internals, advanced Git commands, or trunk-based/GitHub Flow workflows.

---

## Rule Interpretation

- These rules assume a Git Flow workflow. If the team uses trunk-based or GitHub Flow, do not apply Git Flow-specific rules.
- Exceptions should be documented in review notes.

---

## Rule Categories by Priority

| Priority | Category | Impact | Prefix |
|----------|----------|--------|--------|
| 1 | Branch Naming & Commits | CRITICAL | `git-branch-`, `git-commit-` |
| 2 | Pull Request Workflow | HIGH | `git-pr-` |
| 3 | Code Review Guidelines | MEDIUM | `git-review-` |

## Quick Reference

### 1. Branch Naming & Commits (CRITICAL)
- `git-branch-naming` — Format: `<type>/<ticket-id>-<short-description>`
- `git-commit-conventional` — Use Conventional Commits format
- `git-no-force-push` — Never force push to protected branches

### 2. Pull Request Workflow (HIGH)
- `git-pr-workflow` — Follow standard PR workflow (branch, commit, rebase, push)
- `git-pr-template` — Use PR template with description, checklist, testing steps
- `git-pr-size-rules` — PR size ≤400 lines, minimum 1 approval, all CI checks pass

### 3. Code Review Guidelines (MEDIUM)
- `git-review-prefixes` — Use comment prefixes (blocker, issue, suggestion, question, nit, praise)
- `git-flow-lifecycle` — Follow Git Flow branch lifecycle (main, develop, feature, release, hotfix)

## File Map

```
SKILL.md             ← you are here (entry point + quick ref)
AGENTS.md            ← full compiled rules for agents (to be generated)
rules/
  _sections.md       ← index of all 3 sections with impact levels
  _template.md       ← template for creating new rules
  git-branch-naming.md
  git-commit-conventional.md
  git-no-force-push.md
  git-pr-workflow.md
  git-pr-template.md
  git-pr-size-rules.md
  git-review-prefixes.md
  git-flow-lifecycle.md
references/          ← Supporting documentation
  conventional-commits-cheatsheet.md
scripts/             ← Helper scripts
  new-branch.sh
  commit-check.sh
metadata.json        ← document metadata (version, tags, sections)
```

---

## Agent Workflow

### When reviewing Git workflow

1. Read `AGENTS.md` for full rules (or `rules/git-*.md` for a specific rule)
2. Check branch naming, commit messages, and PR compliance
3. Report violations grouped by category and severity
4. For each violation: name the rule, explain why, provide the correct format

### When working with Git

1. **Create branch** — Use proper naming: `<type>/<ticket-id>-<description>`
2. **Write commits** — Follow Conventional Commits format
3. **Create PR** — Use template, keep size ≤400 lines
4. **Review code** — Use comment prefixes, resolve all blockers
5. **Merge** — Follow Git Flow lifecycle, never force push to protected branches

### Output format (review)

```
## Git Workflow Issues

### [git-rule-name] Category Name — CRITICAL / HIGH / MEDIUM
- Issue: [description]
- Example: [offending example]
- Fix:
  [corrected format/approach]

## Summary
X critical, Y high, Z medium issues — [overall assessment]
```

---

## How to Use

Read individual rule files for detailed explanations and examples:

```
rules/git-branch-naming.md
rules/git-commit-conventional.md
rules/git-pr-workflow.md
```

Each rule file contains:
- Brief explanation of why it matters
- Incorrect examples with explanation
- Correct examples with explanation
- Additional context and references

## Full Compiled Document

For the complete guide with all rules expanded: **`AGENTS.md`**
