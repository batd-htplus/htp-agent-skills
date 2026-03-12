---
title: Git Flow Branch Lifecycle
impact: MEDIUM
impactDescription: Git Flow defines branch lifecycle and merge strategy. Follow main, develop, feature, release, and hotfix branch rules.
tags: git, git-flow, branching, lifecycle
---

## Git Flow — Branch Lifecycle

Follow Git Flow branch lifecycle for proper branch management and release process.

**Why it matters:** Git Flow provides a clear branching model, ensures proper release process, and maintains stable production code.

**Branch lifecycle:**

```
main ←──────────────────────── hotfix/* ──┐
  │                                        │ (merge + tag)
  └─→ develop ←── feature/*               │
           │   ←── bugfix/*               │
           │   ←── refactor/*             │
           │                              │
           └─→ release/* ─────────────────┘
                         (tag + merge to main + develop)
```

**Branch rules:**

- **`main`** — production only. Protected. Merge via PR only
- **`develop`** — integration branch. Protected. Merge via PR only
- **`feature/*`** — branch from `develop`, merge back to `develop`
- **`release/*`** — branch from `develop`, merge to `main` AND `develop`
- **`hotfix/*`** — branch from `main`, merge to `main` AND `develop`

**Workflow:**

1. **Feature development:** Branch from `develop` → work → merge back to `develop`
2. **Release preparation:** Branch `release/*` from `develop` → test → merge to `main` and `develop` → tag
3. **Hotfix:** Branch `hotfix/*` from `main` → fix → merge to `main` and `develop` → tag

**See also:** `git-branch-naming.md`, `git-pr-workflow.md`
