---
title: Never Commit .env Files
impact: CRITICAL
impactDescription: .env files contain sensitive credentials. Never commit them to version control.
tags: security, secrets, environment, git
---

## Never Commit .env Files

Never commit `.env` files to version control. Enforce with `.gitignore` and pre-commit hooks.

**Why it matters:** `.env` files contain sensitive credentials (database passwords, API keys, encryption keys). Committing them exposes secrets.

**❌ Incorrect:**

```gitignore
# Missing .env in .gitignore
```

**✅ Correct:**

```gitignore
# .gitignore — these are required
.env
.env.*
!.env.example
!.env.testing
```

**Important:** `.env.example` MUST contain all keys with placeholder values (no real secrets).

**Example .env.example:**

```env
APP_NAME=Laravel
APP_ENV=local
APP_KEY=
DB_PASSWORD=your_password_here
```

**See also:** `security-no-sensitive-logging.md`, `security-encrypt-sensitive.md`
