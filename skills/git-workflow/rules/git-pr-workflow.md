---
title: PR Workflow
impact: HIGH
impactDescription: Standard PR workflow ensures clean Git history, proper integration, and code quality. For Git Flow, branch from develop and rebase before PR.
tags: git, pull-request, workflow, rebase
---

## PR Workflow

Use this flow for every PR to keep history clean and reviews fast.

## Base Branch Policy

- Standard work branches from `develop`
- Hotfix branches from `main`
- Keep branch names aligned with `git-branch-naming.md`

## End-to-End Flow

1. Sync base branch and create feature branch.
2. Commit in small logical units using Conventional Commits.
3. Rebase on latest base branch before opening PR.
4. Push branch and open PR using template.
5. Keep PR updated (rebase + force-with-lease when needed).
6. Merge only after approvals and green CI.

## Command Sequence

```bash
# 1) Sync base branch
git checkout develop
git pull origin develop

# 2) Create working branch
git checkout -b feature/AUTH-123-user-login

# 3) Commit logically
git add .
git commit -m "feat(auth): add user login endpoint"

# 4) Rebase before PR
git fetch origin
git rebase origin/develop

# 5) Push branch
git push -u origin feature/AUTH-123-user-login
```

## PR Readiness Gate

Before creating or updating PR, all items MUST pass:

- Branch is rebased on latest base branch
- Commit messages follow `git-commit-conventional.md`
- PR title/body follow `git-pr-template.md`
- CI passes
- Scope is reviewable (no unrelated changes)

## Update Flow After Review

When addressing comments:

1. Apply requested changes in focused commits.
2. Rebase onto latest base branch.
3. Push with `--force-with-lease` if history changed.
4. Resolve review threads with clear notes.

Never use `--force` for shared branches.

**See also:** `git-branch-naming.md`, `git-commit-conventional.md`, `git-pr-template.md`
