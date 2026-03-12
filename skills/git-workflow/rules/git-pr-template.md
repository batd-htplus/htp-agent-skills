---
title: Pull Request Template
impact: HIGH
impactDescription: PR template ensures all necessary information is provided, proper checklist is followed, and reviewers have context. Every PR MUST be filled out completely.
tags: git, pull-request, template, checklist
---

## Pull Request Template

Every PR MUST be filled out completely. Use this template (save as `.github/pull_request_template.md`):

**Why it matters:** PR template ensures all necessary information is provided, proper checklist is followed, and reviewers have context to make informed decisions.

**✅ PR Template:**

```markdown
## 📋 Description
<!-- What does this PR do? -->

## 🎫 Ticket
Closes #TICKET_ID

## 🔄 Type of Change
- [ ] Bug fix (non-breaking)
- [ ] New feature (non-breaking)
- [ ] Breaking change
- [ ] Refactor / Performance
- [ ] Documentation update
- [ ] CI/CD change

## ✅ Checklist
- [ ] Code follows coding standards (PSR-12, strict_types)
- [ ] Self-reviewed my own code
- [ ] Tests written and passing
- [ ] No debug code (dd(), dump(), var_dump())
- [ ] No .env or secrets committed
- [ ] API documentation updated (if applicable)
- [ ] Migration has down() method
- [ ] PHPStan passes (level 8)
- [ ] Laravel Pint passes

## 🧪 How to Test
<!-- Step-by-step instructions to test this change -->
1. 
2. 

## 📸 Screenshots (if applicable)
```

**See also:** `git-pr-size-rules.md`, `git-review-prefixes.md`
