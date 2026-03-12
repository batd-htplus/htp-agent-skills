# Sections

This file defines all sections, their ordering, impact levels, and descriptions.
The section ID (in parentheses) is the filename prefix used to group rules.

---

## 1. Database & Eloquent (db-, eloquent-)

**Impact:** CRITICAL  
**Description:** Database migration rules, Eloquent model best practices, query optimization and N+1 prevention. All schema changes must go through migrations. Eager load relationships when they are accessed. Use fillable, not guarded.

## 2. Security (security-)

**Impact:** CRITICAL  
**Description:** Security rules: authentication, Policy-based authorization, SQL injection prevention, mass assignment protection, secrets management. Never concatenate SQL strings. Always use Policies for authorization. Never commit .env files.

## 3. API Standards (api-)

**Impact:** CRITICAL  
**Description:** RESTful API design rules: unified JSON response format, HTTP status codes, versioning, Form Request validation, API Resources, and rate limiting. All routes must be versioned. Prefer FormRequests and API Resources with documented exceptions.

## 4. Testing (test-)

**Impact:** HIGH  
**Description:** Testing standards: coverage targets, test naming conventions, Feature and Unit test patterns, factory usage. Use RefreshDatabase or documented alternatives. Follow naming convention: `it_should_[action]_when_[condition]`.

## 5. Performance (perf-)

**Impact:** HIGH  
**Description:** Performance rules: caching strategy with Redis, Queue jobs for heavy tasks, query optimization, and production optimization. Heavy tasks must go to queue. Use Redis caching with tags. Prefer pagination and selecting only needed columns for large datasets.

## 6. Coding Standards (code-)

**Impact:** HIGH  
**Description:** PHP & Laravel coding conventions based on PSR-12, strict types, naming conventions, Repository Pattern and Service Layer architecture. Every file must have `declare(strict_types=1)`. Default: database access through Repository. Business logic in Services.
