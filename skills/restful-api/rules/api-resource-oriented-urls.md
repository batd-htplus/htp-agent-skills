---
title: Resource-Oriented URLs
impact: CRITICAL
impactDescription: Fundamental REST constraint; verb URLs break semantics
tags: rest, resources, url, nouns
---

## Resource-Oriented URLs

**Impact: CRITICAL**

APIs MUST be resource-oriented. URLs represent nouns, NOT verbs. Resources are plural.

**Incorrect (verb in URL or singular resource):**

```
GET /v1/getUsers          ❌ verb in URL
POST /v1/createOrder      ❌ verb in URL
GET /v1/user/{id}         ❌ singular resource
POST /v1/deleteProduct    ❌ verb in URL
```

**Correct:**

```
GET  /v1/users
GET  /v1/users/{id}
POST /v1/orders
GET  /v1/products/{id}/reviews
```

**Rule of thumb:** If you can read the URL and answer "this is about a ___", it's a resource. If you answer "this does a ___", it's a verb — fix it.
