---
title: Actions as State Transitions (Sub-Resources)
impact: HIGH
impactDescription: Verb URLs or wrong method for actions break REST
tags: rest, actions, post, cancel, approve, state
---

## Actions as State Transitions

**Impact: HIGH**

Non-CRUD actions MUST be modeled as sub-resources using POST.

**Pattern:**

```
POST /v1/{resource}/{id}/{action}
```

**Correct:**

```
POST /v1/orders/{id}/cancel       — cancel an order
POST /v1/orders/{id}/approve      — approve an order
POST /v1/invoices/{id}/publish   — publish invoice
POST /v1/accounts/{id}/suspend   — suspend account
POST /v1/users/{id}/verify-email  — trigger email verification
```

**When to use POST vs PATCH:** Use `PATCH /v1/resource/{id}` for simple field updates (e.g. `{ "status": "cancelled" }`). Use `POST /v1/resource/{id}/cancel` when the transition has side effects (emails, payments, audit logs).

**Incorrect:**

```
GET  /v1/cancelOrder/{id}         ❌ verb URL + wrong method
POST /v1/orders/cancel?id={id}    ❌ action as query param
PUT  /v1/orders/{id}/cancel       ❌ wrong method for transition
POST /v1/updateOrderStatus/{id}   ❌ verb in URL
```

Invalid state transition → return 409 Conflict with error code (e.g. `ORDER_ALREADY_CANCELLED`).
