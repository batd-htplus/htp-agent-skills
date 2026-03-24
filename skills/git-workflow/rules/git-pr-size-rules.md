---
title: Merge Request Size & Review Rules (GitLab)
impact: HIGH
impactDescription: GitLab MR size limits, approvals, and pipeline gates reduce review risk and improve merge quality.
tags: git, gitlab, merge-request, code-review, quality
---

## Merge Request Size & Review Rules (GitLab)

Apply these rules to every GitLab Merge Request (MR).

## Size Targets (GitLab diff)

- Target MR size: <= 400 changed lines (`+` and `-` in GitLab diff)
- Preferred MR size: <= 200 changed lines
- If > 400 lines, split into stacked MRs unless change is indivisible
- If > 800 lines, approval from tech lead is required with written risk note

## Review and Merge Gates

- Minimum 1 non-author approval
- Author does not self-merge (except emergency hotfix per team policy)
- All required GitLab pipelines/jobs pass
- All blocking discussions are resolved
- MR title/body follow `git-pr-template.md`

## When MR Is Large

If MR exceeds target size, include in description:

- Why split is not possible (or link to stacked MRs)
- Risk areas and rollback strategy
- Focused review guide (files/modules reviewers should check first)

## Exceptions

- Generated files, lockfiles, and snapshots may exceed limits when justified
- Repo-wide codemods/refactors are allowed with staged rollout plan
- Emergency hotfixes may be fast-tracked but still require post-merge review

**See also:** `git-pr-template.md`, `git-pr-workflow.md`, `git-review-prefixes.md`
