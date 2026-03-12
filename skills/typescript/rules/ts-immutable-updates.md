---
title: Immutable Updates
impact: MAJOR
impactDescription: Mutating shared state causes hard-to-track bugs
tags: typescript, immutability, readonly, state, updates
---

# Immutable Updates

**Impact:** MAJOR

## Rules

1. **Avoid mutating inputs and shared state** — return new objects/arrays instead.
2. **Prefer `Readonly` types for inputs** — makes mutation explicit.
3. **Use structural sharing** — spread objects/arrays and replace only changed fields.

## ✅ Correct

```typescript
type User = { id: string; name: string; tags: string[] }

function rename(user: Readonly<User>, name: string): User {
  return { ...user, name }
}

function addTag(user: Readonly<User>, tag: string): User {
  return { ...user, tags: [...user.tags, tag] }
}
```

## ❌ Incorrect

```typescript
function rename(user: User, name: string): User {
  user.name = name
  return user
}
```

## Checklist

- [ ] Inputs are treated as immutable
- [ ] Updates use spread/structural sharing
- [ ] `Readonly` is used where appropriate

## See Also

- [ts-utility-types](ts-utility-types.md)
