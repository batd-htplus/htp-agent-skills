---
title: Boring by Design (Predictability)
impact: MEDIUM
impactDescription: Surprises increase integration cost and bugs
tags: rest, predictability, consistency
---

## Boring by Design

**Impact: MEDIUM**

APIs SHOULD be predictable. No surprises. Easy to guess without documentation.

**The Boring Test:** A developer unfamiliar with your API should be able to guess:

- `GET /v1/invoices` → list invoices
- `GET /v1/invoices/{id}` → get one invoice
- `POST /v1/invoices` → create invoice
- `PATCH /v1/invoices/{id}` → update invoice
- `DELETE /v1/invoices/{id}` → delete invoice
- `POST /v1/invoices/{id}/send` → trigger send action

If any of these feel surprising, the API violates this rule.

**Signs of a non-boring API:** Different naming styles per endpoint; some IDs in path, others in query; action endpoints mixing PUT and POST; inconsistent response shapes (`data` vs raw array); error format differing between endpoints.
