---
title: Test Naming Convention
impact: HIGH
impactDescription: Method names must describe behavior, not implementation. Use it_should_[action]_when_[condition] format.
tags: testing, naming, conventions, readability
---

## Test Naming Convention

Method names must describe behavior, not implementation. Use descriptive names that explain what the test verifies.

**Format:**

```
it_should_[action]_when_[condition]
it_should_[fail_action]_when_[condition]
```

**❌ Incorrect:**

```php
// Vague or implementation-focused
public function test_store(): void
public function test_user_creation(): void
public function testEndpoint(): void
```

**✅ Correct:**

```php
// Descriptive behavior-focused names
public function it_should_create_user_when_valid_data_is_provided(): void
public function it_should_fail_validation_when_email_is_duplicate(): void
public function it_should_return_401_when_not_authenticated(): void
public function it_should_return_403_when_user_lacks_permission(): void
```

**See also:** `test-feature-pattern.md`, `test-unit-pattern.md`
