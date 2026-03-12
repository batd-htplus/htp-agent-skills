---
title: HTTP Status Codes
impact: CRITICAL
impactDescription: Always return the semantically correct HTTP status code. Never use 200 for errors.
tags: api, http, status-codes, rest
---

## HTTP Status Codes

Always return the semantically correct HTTP status code. Never use 200 for errors.

**Why it matters:** Correct status codes allow clients to handle responses appropriately and follow REST conventions.

| Scenario | Code |
|----------|------|
| GET success | `200 OK` |
| POST create success | `201 Created` |
| DELETE / update with no body | `204 No Content` |
| Bad request / invalid input | `400 Bad Request` |
| Not authenticated | `401 Unauthorized` |
| No permission | `403 Forbidden` |
| Resource not found | `404 Not Found` |
| Validation error | `422 Unprocessable Entity` |
| Rate limit exceeded | `429 Too Many Requests` |
| Server error | `500 Internal Server Error` |

**❌ Incorrect:**

```php
// Wrong status code for error
return response()->json(['error' => 'Not found'], 200);
```

**✅ Correct:**

```php
// Correct status codes
return response()->json(['success' => true, 'data' => $user], 200);
return response()->json(['success' => true, 'data' => $user], 201); // Created
return response()->json(['success' => false, 'message' => 'Not found'], 404);
return response()->json(['success' => false, 'errors' => $errors], 422); // Validation
```

**See also:** `api-unified-response.md`, `api-restful-routes.md`
