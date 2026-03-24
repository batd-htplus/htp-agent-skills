---
title: Content Negotiation (Accept/Content-Type)
impact: HIGH
impactDescription: Prevents ambiguous payload formats and hard-to-debug client/server mismatches.
tags: rest, api, http, content-type, accept, negotiation
---

## Content Negotiation (Accept/Content-Type)

**Impact: HIGH (payload interoperability)**

APIs MUST be explicit about media types:

- Requests with bodies MUST send `Content-Type: application/json`
- Responses MUST send `Content-Type: application/json`
- If the client sends `Accept`, the server MUST honor it or return `406 Not Acceptable`
- If the client sends an unsupported `Content-Type`, return `415 Unsupported Media Type`

**Incorrect (silent fallback / unclear media types):**

```
POST /v1/users    ❌ accepts form data without explicit Content-Type contract
Accept: text/html

name=alice&email=a@example.com
```

```
200 OK    ❌ returns JSON without Content-Type
{ "data": { "id": "u_123" } }
```

**Correct (explicit contract + correct errors):**

```
POST /v1/users
Content-Type: application/json
Accept: application/json

{ "name": "alice", "email": "a@example.com" }    ✅ explicit JSON contract
```

```
415 Unsupported Media Type    ✅ reject unsupported Content-Type
{ "error": { "code": "UNSUPPORTED_MEDIA_TYPE", "message": "Only application/json is supported", "details": [] } }
```

```
406 Not Acceptable    ✅ reject unsupported Accept
{ "error": { "code": "NOT_ACCEPTABLE", "message": "Only application/json is available", "details": [] } }
```

Reference: [MDN — Content negotiation](https://developer.mozilla.org/en-US/docs/Web/HTTP/Content_negotiation)
