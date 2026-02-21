---
title: Stateless APIs
impact: HIGH
impactDescription: Session state breaks scalability and caching
tags: rest, stateless, auth, token
---

## Stateless

**Impact: HIGH**

APIs MUST be stateless. No server-side session dependency. Auth sent per request.

**Correct:**

```
Authorization: Bearer <jwt-token>     ✅ sent per request
X-API-Key: <key>                      ✅ sent per request
```

**Incorrect:**

- Server stores session ID and looks up user state from it ❌
- Endpoint behavior changes based on which request came before it ❌
- Client must call `/login` first to "activate" subsequent endpoints ❌

**Note:** Tokens (JWT) may encode state — that is fine. The server must NOT maintain session state.
