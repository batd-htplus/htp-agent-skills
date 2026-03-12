---
title: Folder Structure
impact: HIGH
impactDescription: Follow standard Laravel folder structure with API versioning, organized Requests and Resources.
tags: coding-standards, structure, organization, laravel
---

## Folder Structure

Follow standard Laravel folder structure with API versioning, organized Requests and Resources.

**Why it matters:** Consistent folder structure makes code easier to navigate and maintain.

**✅ Standard structure:**

```
app/
├── Http/
│   ├── Controllers/
│   │   └── Api/
│   │       └── V1/          ← API versioning required
│   ├── Middleware/
│   ├── Requests/            ← One folder per resource
│   │   └── User/
│   │       ├── StoreUserRequest.php
│   │       └── UpdateUserRequest.php
│   └── Resources/           ← API Resources
├── Models/
├── Repositories/
│   ├── Contracts/           ← Interfaces
│   └── Eloquent/            ← Implementations
├── Services/                ← Business logic only
├── Enums/                   ← PHP 8.1 Enums
├── Events/
├── Listeners/
├── Jobs/
├── Policies/
├── Observers/
└── Traits/
```

**See also:** `code-repository-pattern.md`, `code-service-layer.md`
