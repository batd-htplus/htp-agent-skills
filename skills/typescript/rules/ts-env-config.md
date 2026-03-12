---
title: Environment Configuration
impact: CRITICAL
impactDescription: Typed, validated env config prevents misconfig and runtime crashes
tags: typescript, env, configuration, validation, zod
---

# Environment Configuration

**Impact:** CRITICAL

## Rules

1. **Centralize env parsing** — parse once at startup and export a typed config.
2. **Validate required env vars** — fail fast with clear errors.
3. **Never scatter `process.env` access** — use a config module.

## ✅ Correct

```typescript
const EnvSchema = z.object({
  NODE_ENV: z.enum(['development', 'test', 'production']),
  PORT: z.coerce.number().int().min(1),
  DATABASE_URL: z.string().url(),
})

export const env = EnvSchema.parse(process.env)
```

```typescript
// elsewhere
app.listen(env.PORT)
```

## ❌ Incorrect

```typescript
const port = Number(process.env.PORT) || 3000  // silent misconfig
```

## Checklist

- [ ] Env vars are parsed once and exported
- [ ] Required vars are validated and fail fast
- [ ] No direct `process.env` access outside config module

## See Also

- [ts-runtime-validation](ts-runtime-validation.md)
- [ts-patterns-anti-patterns](ts-patterns-anti-patterns.md)
