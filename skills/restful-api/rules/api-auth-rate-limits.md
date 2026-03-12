---
title: Auth & Rate Limit Headers
impact: HIGH
impactDescription: Clear auth and throttling signals prevent client confusion
tags: rest, auth, rate-limit, headers, http
---

## Auth & Rate Limit Headers

**Impact: HIGH**

Auth and rate limit behavior SHOULD be explicit via standard headers.

**Auth:**

- 401 responses should include `WWW-Authenticate: Bearer`
- 403 for authenticated but unauthorized

**Rate limits:**

- 429 responses include `Retry-After`
- Optional: `X-RateLimit-Limit`, `X-RateLimit-Remaining`, `X-RateLimit-Reset`

**Incorrect:**

- 401 without `WWW-Authenticate` ❌
- 429 without `Retry-After` ❌
