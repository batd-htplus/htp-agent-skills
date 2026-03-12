---
title: Meaningful Status Codes
impact: CRITICAL
impactDescription: 200 for errors breaks client handling and semantics
tags: rest, status, 200, 201, 404, 4xx, 5xx
---

## Meaningful Status Codes

**Impact: CRITICAL**

Status codes MUST be semantically correct. Never return 200 for errors.

**Correct usage:**

| Code | Meaning | Use When |
|------|---------|----------|
| 200 | OK | Successful GET, PATCH, PUT, or POST action |
| 201 | Created | POST successfully created a new resource |
| 204 | No Content | Successful DELETE (no body) |
| 400 | Bad Request | Malformed JSON, invalid input |
| 401 | Unauthorized | Missing or invalid auth |
| 403 | Forbidden | Valid auth but not allowed |
| 404 | Not Found | Resource does not exist |
| 409 | Conflict | Duplicate resource, state conflict |
| 422 | Unprocessable Entity | Validation errors on valid JSON |
| 429 | Too Many Requests | Rate limit exceeded |
| 500 | Internal Server Error | Unexpected server error |

**Incorrect:**

```json
HTTP/1.1 200 OK
{ "error": "User not found" }     ❌ must be 404

HTTP/1.1 200 OK
{ "status": "error", "msg": "..." } ❌ must be 4xx or 5xx

HTTP/1.1 500 OK
{ "success": true }               ❌ contradictory
```

**See also:** `api-auth-rate-limits.md`
