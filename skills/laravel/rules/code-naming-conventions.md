---
title: Naming Conventions
impact: HIGH
impactDescription: Follow Laravel naming conventions for classes, methods, variables, routes, and database tables.
tags: coding-standards, naming, conventions, laravel
---

## Naming Conventions

Follow Laravel naming conventions for consistency across the codebase.

**Why it matters:** Consistent naming makes code predictable and easier to navigate.

| Type | Convention | Example |
|------|------------|---------|
| Class | PascalCase | `UserController`, `OrderService` |
| Method / Function | camelCase | `getUserById()`, `createOrder()` |
| Variable | camelCase | `$userId`, `$orderList` |
| Constant | UPPER_SNAKE_CASE | `MAX_RETRY`, `API_VERSION` |
| Database table | snake_case plural | `users`, `order_items` |
| Column | snake_case | `first_name`, `created_at` |
| Route name | kebab-case | `user-profile`, `order-items` |
| Migration | timestamp_snake_case | `2024_01_01_create_users_table` |
| Config key | snake_case | `app.timezone`, `mail.from_address` |

**See also:** `code-folder-structure.md`, `code-psr-12.md`
