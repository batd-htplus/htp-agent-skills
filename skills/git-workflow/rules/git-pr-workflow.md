---
title: PR Workflow
impact: HIGH
impactDescription: Standard PR workflow ensures clean Git history, proper integration, and code quality. For Git Flow, branch from develop and rebase before PR.
tags: git, pull-request, workflow, rebase
---

## PR Workflow

Follow the standard PR workflow to ensure clean Git history and proper integration.

**Why it matters:** Standard workflow ensures clean Git history, prevents merge conflicts, and maintains code quality.

**✅ Standard workflow:**

```bash
# 1. Create branch from develop (Git Flow)
git checkout develop
git pull origin develop
git checkout -b feature/AUTH-123-user-login

# 2. Commit with conventional commits
git add .
git commit -m "feat(auth): add user login endpoint"

# 3. Rebase before creating PR (keep history clean)
git fetch origin
git rebase origin/develop

# 4. Push and open PR
git push origin feature/AUTH-123-user-login
# → Open PR on GitHub/GitLab
```

**Important steps:**
1. For Git Flow, branch from `develop` (or `main` for hotfixes)
2. Use Conventional Commits format
3. Rebase before creating PR to keep history clean
4. Push and create PR with proper template

**See also:** `git-branch-naming.md`, `git-commit-conventional.md`, `git-pr-template.md`
