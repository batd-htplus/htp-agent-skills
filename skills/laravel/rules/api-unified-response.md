---
title: Unified JSON Response Format
impact: CRITICAL
impactDescription: Every API response MUST follow a unified JSON format for consistency and better client integration.
tags: api, response, json, format
---

## Unified JSON Response Format

**Every** API response MUST follow this exact structure for consistency and better client integration.

**Why it matters:** Consistent response format makes API consumption easier, predictable, and maintainable.

**✅ Success — list with pagination:**

```json
{
    "success": true,
    "message": "Users retrieved successfully.",
    "data": {
        "items": [...],
        "pagination": {
            "current_page": 1,
            "per_page": 15,
            "total": 100,
            "last_page": 7,
            "from": 1,
            "to": 15
        }
    }
}
```

**✅ Success — single resource:**

```json
{
    "success": true,
    "data": {
        "id": 1,
        "name": "Nguyen Van A",
        "email": "nva@example.com",
        "created_at": "2024-01-15T08:30:00Z"
    }
}
```

**✅ Error — validation:**

```json
{
    "success": false,
    "message": "Validation failed.",
    "errors": {
        "email": ["The email field is required."],
        "password": ["The password must be at least 8 characters."]
    }
}
```

**✅ Error — general:**

```json
{
    "success": false,
    "message": "User not found."
}
```

**❌ Wrong:** Never return raw Eloquent models, unstructured arrays, or Laravel's default error pages.

**See also:** `api-resources.md`, `api-status-codes.md`, `references/response-examples.md`
