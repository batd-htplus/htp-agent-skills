# RESTful API Skills

**Version 1.0.0**  
restful-api-best-practices  
February 2026

> **Note:**  
> This document is mainly for agents and LLMs to follow when designing,  
> reviewing, or refactoring RESTful APIs. Humans may also find it useful,  
> but guidance here is optimized for automation and consistency by AI-assisted workflows.

---

## Abstract

Strict RESTful API design and review guidelines for AI agents and LLMs. Contains 14 rules covering resource-oriented URLs, HTTP methods, statelessness, status codes, error structure, collections/pagination, actions as sub-resources, naming conventions, versioning, predictability, response envelopes, idempotency, auth headers, and pagination links. Each rule includes correct vs incorrect examples to guide design and refactoring.

---

## Table of Contents

1. [Resource-Oriented URLs](#1-resource-oriented-urls) — **CRITICAL**
2. [HTTP Methods Express Intent](#2-http-methods-express-intent) — **CRITICAL**
3. [Stateless](#3-stateless) — **HIGH**
4. [Meaningful Status Codes](#4-meaningful-status-codes) — **CRITICAL**
5. [Machine-Readable Errors](#5-machine-readable-errors) — **HIGH**
6. [Collections: Filtering, Sorting, Pagination](#6-collections-filtering-sorting-pagination) — **HIGH**
7. [Actions as State Transitions](#7-actions-as-state-transitions) — **HIGH**
8. [Naming Conventions](#8-naming-conventions) — **MEDIUM**
9. [Explicit Versioning](#9-explicit-versioning) — **HIGH**
10. [Boring by Design](#10-boring-by-design) — **MEDIUM**
11. [Consistent Response Envelope](#11-consistent-response-envelope) — **HIGH**
12. [Idempotency & Retries](#12-idempotency--retries) — **HIGH**
13. [Auth & Rate Limit Headers](#13-auth--rate-limit-headers) — **HIGH**
14. [Pagination Links](#14-pagination-links) — **MEDIUM**

---

## 1. Resource-Oriented URLs

**Impact: CRITICAL**

APIs MUST be resource-oriented. URLs represent nouns, NOT verbs. Resources are plural.

**Correct:** `GET /v1/users`, `GET /v1/users/{id}`, `POST /v1/orders`, `GET /v1/products/{id}/reviews`

**Incorrect:** `GET /v1/getUsers`, `POST /v1/createOrder`, `GET /v1/user/{id}`, `POST /v1/deleteProduct`

Rule of thumb: If the URL answers "this is about a ___" it's a resource; if "this does a ___" it's a verb — fix it.

---

## 2. HTTP Methods Express Intent

**Impact: CRITICAL**

| Method | Intent | Idempotent | Safe |
|--------|--------|-----------|------|
| GET | Read | Yes | Yes |
| POST | Create or trigger action | No | No |
| PUT | Replace entire resource | Yes | No |
| PATCH | Partial update | No | No |
| DELETE | Remove resource | Yes | No |

**Correct:** `GET /v1/users/{id}`, `POST /v1/users`, `PUT`/`PATCH`/`DELETE /v1/users/{id}`

**Incorrect:** `GET /v1/users/delete/{id}`, `POST /v1/users/get-all`, `GET /v1/users?action=delete`

Use 201 Created + `Location` for POST create; 204 No Content for DELETE.

---

## 3. Stateless

**Impact: HIGH**

No server-side session. Auth sent per request (e.g. `Authorization: Bearer <token>`, `X-API-Key`). Server must NOT maintain session state; tokens may encode state.

---

## 4. Meaningful Status Codes

**Impact: CRITICAL**

Never return 200 for errors. Use: 200 (OK), 201 (Created), 204 (No Content), 400 (Bad Request), 401 (Unauthorized), 403 (Forbidden), 404 (Not Found), 409 (Conflict), 422 (Unprocessable Entity), 429 (Too Many Requests), 500 (Internal Server Error). Auth and rate-limit headers are defined in `Auth & Rate Limit Headers`.

---

## 5. Machine-Readable Errors

**Impact: HIGH**

All errors MUST use: `{ "error": { "code": "SCREAMING_SNAKE_CASE", "message": "...", "details": [] } }`. Clients use `code` for logic. No ad-hoc shapes like `{ "msg": "..." }` or `{ "status": "fail" }`.

---

## 6. Collections: Filtering, Sorting, Pagination

**Impact: HIGH**

Collection endpoints MUST support `?page`, `?limit`, `?sort`, `?order`, `?filter[field]=value`. Response MUST include `data` and `meta` (page, limit, total, total_pages). No returning all records with no pagination.

---

## 7. Actions as State Transitions

**Impact: HIGH**

Non-CRUD actions: `POST /v1/{resource}/{id}/{action}` (e.g. `POST /v1/orders/{id}/cancel`). Use PATCH for simple field updates; use POST sub-resource when there are side effects. Invalid transition → 409 Conflict with error code.

---

## 8. Naming Conventions

**Impact: MEDIUM**

URLs: lowercase, kebab-case, plural, generic `{id}`, max 2 levels nesting. JSON: snake_case. Query params: `page`, `limit`, `sort`, `order`, `filter[field]`. Dates: ISO 8601 UTC.

---

## 9. Explicit Versioning

**Impact: HIGH**

Use URI versioning: `/v1/`, `/v2/`. Bump version for breaking changes (remove/rename field, change type/method, new required field). No bump for optional new fields or new endpoints.

---

## 10. Boring by Design

**Impact: MEDIUM**

APIs should be predictable: same naming, same response shape, same error format. A developer should correctly guess `GET/POST/PATCH/DELETE /v1/invoices` and `POST /v1/invoices/{id}/send` without docs.

---

## 11. Consistent Response Envelope

**Impact: HIGH**

Success responses SHOULD use a consistent envelope: `data` with optional `meta` and `links`.

---

## 12. Idempotency & Retries

**Impact: HIGH**

For non-idempotent POST creates, support safe retries via `Idempotency-Key` and return the same response for duplicate keys.

---

## 13. Auth & Rate Limit Headers

**Impact: HIGH**

401 responses include `WWW-Authenticate: Bearer`. 429 responses include `Retry-After`. Optional rate limit headers are recommended.

---

## 14. Pagination Links

**Impact: MEDIUM**

Collections SHOULD include navigation links alongside `meta` for pagination.

---

## References

1. [RESTful API](https://restfulapi.net)
2. [HTTP Methods](https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods)
3. [HTTP Status](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status)

For detailed examples and anti-patterns, read the individual rule files in `rules/`.
