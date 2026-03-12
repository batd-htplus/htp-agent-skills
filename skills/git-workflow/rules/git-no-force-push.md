---
title: Never Force Push to Protected Branches
impact: CRITICAL
impactDescription: Force pushing to protected branches destroys shared history and can cause data loss. Only allowed on personal feature branches with --force-with-lease.
tags: git, force-push, protected-branches, safety
---

## Never Force Push to Protected Branches

Never force push to protected branches (`main`, `develop`). Only allowed on personal feature branches with `--force-with-lease`.

**Why it matters:** Force pushing to protected branches destroys shared history, can cause data loss, and disrupts other team members' work.

**❌ Incorrect:**

```bash
# NEVER — destroys shared history
git push --force origin main
git push --force origin develop
```

**✅ Correct:**

```bash
# Only allowed on your personal feature branch
git push --force-with-lease origin feature/AUTH-123-user-login
```

**Protected branches:**
- `main` — production branch, always protected
- `develop` — integration branch, always protected

**Note:** `--force-with-lease` is safer than `--force` as it checks if remote has been updated before pushing.

**See also:** `git-branch-naming.md`, `git-flow-lifecycle.md`
