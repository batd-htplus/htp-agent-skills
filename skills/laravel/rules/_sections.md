# Sections

This file defines all sections, their ordering, impact levels, and descriptions.
The section ID (in parentheses) is the filename prefix used to group rules.

---

## 1. Database & Eloquent (db-, eloquent-)

**Impact:** CRITICAL  
**Description:** Database migration rules, Eloquent model best practices, query optimization and N+1 prevention. All schema changes must go through migrations. Always eager load relationships to prevent N+1 queries. Use fillable, not guarded.

## 2. Security (security-)

**Impact:** CRITICAL  
**Description:** Security rules: authentication, Policy-based authorization, SQL injection prevention, mass assignment protection, secrets management. Never concatenate SQL strings. Always use Policies for authorization. Never commit .env files.

## 3. API Standards (api-)

**Impact:** CRITICAL  
**Description:** RESTful API design rules: unified JSON response format, HTTP status codes, versioning, Form Request validation, API Resources, and rate limiting. All routes must be versioned. Always use FormRequests and API Resources.

## 4. Testing (test-)

**Impact:** HIGH  
**Description:** Testing standards: coverage thresholds, test naming conventions, Feature and Unit test patterns, factory usage. Feature tests ≥70%, Unit tests ≥80%. Use RefreshDatabase trait. Follow naming convention: `it_should_[action]_when_[condition]`.

## 5. Performance (perf-)

**Impact:** HIGH  
**Description:** Performance rules: caching strategy with Redis, Queue jobs for heavy tasks, query optimization, and production optimization. Heavy tasks must go to queue. Use Redis caching with tags. Always paginate results.

## 6. Coding Standards (code-)

**Impact:** HIGH  
**Description:** PHP & Laravel coding conventions based on PSR-12, strict types, naming conventions, Repository Pattern and Service Layer architecture. Every file must have `declare(strict_types=1)`. All database access through Repository. Business logic in Services.
