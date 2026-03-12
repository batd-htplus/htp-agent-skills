---
title: Error Handling Model
impact: MAJOR
impactDescription: Consistent error types prevent leaky failures and improve observability
tags: typescript, errors, result, exceptions, cause, codes
---

# Error Handling Model

**Impact:** MAJOR

## Rules

1. **Define a typed error model** — use `code`, `message`, and optional `cause`.
2. **Use `Result<T, E>` for expected errors** — reserve `throw` for truly exceptional cases.
3. **Preserve root causes** — use `cause` when wrapping errors.

## ✅ Correct

```typescript
type AppErrorCode = 'NOT_FOUND' | 'VALIDATION' | 'CONFLICT'

class AppError extends Error {
  constructor(
    public readonly code: AppErrorCode,
    message: string,
    options?: { cause?: unknown }
  ) {
    super(message, options)
  }
}
```

```typescript
type Result<T, E> = { ok: true; value: T } | { ok: false; error: E }
```

## ❌ Incorrect

```typescript
throw new Error('NOT_FOUND')  // loses error semantics
```

## Checklist

- [ ] Expected failures use `Result<T, E>`
- [ ] Exceptions carry `cause` when wrapping
- [ ] Error codes are typed, not magic strings

## See Also

- [ts-async-errors](ts-async-errors.md)
- [ts-runtime-validation](ts-runtime-validation.md)
