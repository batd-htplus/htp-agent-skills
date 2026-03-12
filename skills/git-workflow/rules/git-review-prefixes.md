---
title: Code Review Comment Prefixes
impact: MEDIUM
impactDescription: Review comment prefixes indicate importance and help authors prioritize fixes. Use blocker, issue, suggestion, question, nit, or praise prefixes.
tags: git, code-review, collaboration, communication
---

## Code Review Comment Prefixes

Reviewers MUST prefix comments to indicate importance and help authors prioritize fixes.

**Why it matters:** Comment prefixes make review feedback clear, help authors prioritize fixes, and improve collaboration efficiency.

**Prefixes:**

| Prefix | Meaning |
|--------|---------|
| `blocker:` | Must fix — cannot merge |
| `issue:` | Must fix before merge |
| `suggestion:` | Good idea but optional |
| `question:` | Needs clarification |
| `nit:` | Minor style preference (non-blocking) |
| `praise:` | Positive feedback |

**✅ Examples:**

```
blocker: This causes a SQL injection vulnerability, must fix before merge.
issue: Missing null check here could cause NullPointerException.
suggestion: Consider using a Policy here instead of manual auth check.
question: Why do we need this additional database query?
nit: Variable name could be more descriptive (`$usr` → `$user`).
praise: Great use of the Repository pattern here!
```

**See also:** `git-pr-size-rules.md`, `git-pr-template.md`
