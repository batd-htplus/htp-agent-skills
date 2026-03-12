# Sections

This file defines all sections, their ordering, impact levels, and descriptions.
The section ID (in parentheses) is the filename prefix used to group rules.

---

## 1. Resource-Oriented URLs (api-resource)

**Impact:** CRITICAL  
**Description:** URLs represent nouns, not verbs. Resources are plural. Fundamental REST constraint.

## 2. HTTP Methods (api-http)

**Impact:** CRITICAL  
**Description:** HTTP methods must match intent. GET is safe and idempotent; mutations use POST/PUT/PATCH/DELETE.

## 3. Stateless (api-stateless)

**Impact:** HIGH  
**Description:** No server-side session. Auth sent per request (e.g. Bearer token, API key).

## 4. Status Codes (api-status)

**Impact:** CRITICAL  
**Description:** Semantically correct status codes. Never return 200 for errors.

## 5. Error Structure (api-error)

**Impact:** HIGH  
**Description:** Machine-readable error envelope with code and message.

## 6. Collections (api-collections)

**Impact:** HIGH  
**Description:** Filtering, sorting, and pagination for collection endpoints.

## 7. Actions (api-actions)

**Impact:** HIGH  
**Description:** Non-CRUD actions as POST sub-resources (e.g. POST /orders/{id}/cancel).

## 8. Naming (api-naming)

**Impact:** MEDIUM  
**Description:** Consistent naming: kebab-case URLs, plural resources, generic {id}, snake_case in JSON.

## 9. Versioning (api-versioning)

**Impact:** HIGH  
**Description:** URI versioning (/v1/, /v2/) for breaking changes.

## 10. Predictability (api-boring)

**Impact:** MEDIUM  
**Description:** APIs should be boring by design—predictable and easy to guess.

## 11. Response Envelope (api-response-envelope)

**Impact:** HIGH  
**Description:** Consistent success response envelope (`data`, optional `meta`, optional `links`) for predictable clients.

## 12. Idempotency & Retries (api-idempotency-retry)

**Impact:** HIGH  
**Description:** Support safe retries for non-idempotent operations using `Idempotency-Key`.

## 13. Auth & Rate Limit Headers (api-auth-rate-limits)

**Impact:** HIGH  
**Description:** Explicit auth and throttling behavior via standard headers.

## 14. Pagination Links (api-pagination-links)

**Impact:** MEDIUM  
**Description:** Provide pagination navigation links for collection responses.
