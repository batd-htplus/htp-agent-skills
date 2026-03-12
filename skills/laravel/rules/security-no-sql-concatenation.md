---
title: Never Concatenate SQL Strings
impact: CRITICAL
impactDescription: SQL injection is a critical security vulnerability. Always use parameter binding through Eloquent or Query Builder.
tags: security, sql-injection, database, queries
---

## Never Concatenate SQL Strings

Never concatenate user input into SQL strings. Always use Eloquent, Query Builder, or parameter binding.

**Why it matters:** SQL injection is one of the most critical security vulnerabilities. Concatenating strings allows attackers to execute arbitrary SQL.

**❌ Incorrect:**

```php
// SQL Injection vulnerability
$users = DB::select("SELECT * FROM users WHERE email = '$email'");

// Still vulnerable
$query = "SELECT * FROM users WHERE role = '" . $role . "'";
```

**✅ Correct:**

```php
// Eloquent (uses PDO parameter binding)
$user = User::where('email', $email)->first();

// Query Builder with binding
$user = DB::table('users')->where('email', '=', $email)->first();

// Raw query with binding array
$users = DB::select('SELECT * FROM users WHERE email = ?', [$email]);

// Named bindings
$users = DB::select(
    'SELECT * FROM users WHERE email = :email AND role = :role',
    ['email' => $email, 'role' => $role]
);
```

**See also:** `security-policies.md`, `eloquent-prevent-n-plus-one.md`
