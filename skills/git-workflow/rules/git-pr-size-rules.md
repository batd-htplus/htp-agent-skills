---
title: PR Size & Review Rules
impact: HIGH
impactDescription: PR size limits, approval requirements, and CI checks ensure code quality and maintainability. PRs should be ≤400 lines, require approval, and pass all checks.
tags: git, pull-request, code-review, quality
---

## PR Size & Review Rules

Follow PR size limits, approval requirements, and CI checks to ensure code quality.

**Why it matters:** Smaller PRs are easier to review, reduce risk, and maintain code quality. Approval requirements ensure code is reviewed by peers.

**Rules:**

- **PR size:** **≤ 400 lines** changed (strongly recommended)
- **Minimum 1 approval** before merge
- **Author must not self-merge** (except hotfixes with team notification)
- **All CI checks must pass** before merge
- **Resolve all comments** before merge

**Why ≤400 lines:**
- Easier to review thoroughly
- Faster to understand changes
- Reduces risk of introducing bugs
- Easier to test and verify

**Exceptions:**
- Large refactorings may exceed 400 lines but should be broken into smaller PRs when possible
- Hotfixes may require faster merge but still need approval

**See also:** `git-pr-template.md`, `git-review-prefixes.md`
