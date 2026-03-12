# Sections

This file defines all sections, their ordering, impact levels, and descriptions.
The section ID (in parentheses) is the filename prefix used to group rules.

---

## 1. Branch Naming & Commits (git-branch-, git-commit-)

**Impact:** CRITICAL  
**Description:** Branch naming conventions and Conventional Commits format ensure consistent Git history, easier navigation, and automated changelog generation. Never force push to protected branches.

## 2. Pull Request Workflow (git-pr-)

**Impact:** HIGH  
**Description:** Standard PR workflow, templates, and size rules ensure code quality, proper review process, and maintainable codebase. PRs should be ≤400 lines, require approval, and pass all CI checks.

## 3. Code Review Guidelines (git-review-, git-flow-)

**Impact:** MEDIUM  
**Description:** Code review comment prefixes and Git Flow lifecycle ensure effective collaboration, clear communication, and proper branch management.
