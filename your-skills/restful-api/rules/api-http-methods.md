---
title: HTTP Methods Express Intent
impact: CRITICAL
impactDescription: Wrong method breaks safety (GET mutating) or semantics
tags: rest, http, get, post, put, patch, delete
---

## HTTP Methods Express Intent

**Impact: CRITICAL**

HTTP methods MUST match the intent of the operation.

| Method | Intent | Idempotent | Safe |
|--------|--------|-----------|------|
| GET | Read resource(s) | Yes | Yes |
| POST | Create resource or trigger state transition | No | No |
| PUT | Replace entire resource | Yes | No |
| PATCH | Partial update | No | No |
| DELETE | Remove resource | Yes | No |

**Incorrect:**

```
GET  /v1/users/delete/{id}    ❌ GET must never mutate
POST /v1/users/get-all       ❌ GET should be used for reads
GET  /v1/users?action=delete ❌ mutation via query param
```

**Correct:**

```
GET    /v1/users/{id}          — read user
POST   /v1/users               — create user
PUT    /v1/users/{id}          — replace entire user record
PATCH  /v1/users/{id}          — update specific fields
DELETE /v1/users/{id}          — delete user
```

**GET** — Use for all read operations. Must NEVER modify server state. No body.

**POST** — (1) Create a new resource → 201 Created, `Location` header. (2) Trigger state transition → 200 OK.

**PUT** — Replace the entire resource; client sends full representation. Omitted fields are cleared.

**PATCH** — Update specific fields only. Preferred over PUT for most updates.

**DELETE** — Remove resource. Return 204 No Content (no body).

**Common violations:** `GET .../delete/{id}` → use `DELETE /v1/users/{id}`. `POST .../list` → use `GET /v1/users`. Partial update via PUT → use PATCH.
