---
title: Async & Error Handling
impact: CRITICAL
impactDescription: Unhandled Promises and wrong catch typing cause silent production failures
tags: typescript, async, Promise, Result, catch unknown, Promise.all
---

# Async & Error Handling

**Impact:** CRITICAL

## Rules

1. **Always `await` Promises — never fire-and-forget** — unhandled rejections are silent production bugs; use `void` only when intentional and documented.
2. **Type `catch` clause variables as `unknown`, not `Error`** — the thrown value may be anything; narrow before accessing properties.
3. **Use a typed `Result<T, E>` pattern for expected failures** — distinguish expected domain errors (validation, not found) from unexpected crashes.
4. **Avoid `async` without `await` inside the function body** — it adds unnecessary microtask overhead and signals confusion. Allow when required by an interface, with a comment.

## ✅ Correct

```typescript
// ✅ Result type — expected failures are part of the return type
type Result<T, E = Error> = { ok: true; value: T } | { ok: false; error: E }

const ok  = <T>(value: T) => ({ ok: true,  value })
const err = <E>(error: E) => ({ ok: false, error })

async function findUser(id: string): Promise<Result<User, 'NOT_FOUND' | 'DB_ERROR'>> {
  try {
    const user = await db.users.findUnique({ where: { id } })
    if (!user) return err('NOT_FOUND')
    return ok(user)
  } catch {
    return err('DB_ERROR')
  }
}

// ✅ Caller — exhaustive via discriminant
const result = await findUser('u1')
if (result.ok) {
  console.log(result.value.email)
} else {
  switch (result.error) {
    case 'NOT_FOUND': return res.status(404).json({ ... })
    case 'DB_ERROR':  return res.status(500).json({ ... })
  }
}
```

```typescript
// ✅ catch(error: unknown) — narrow before accessing
try {
  const response = await fetch(url)
  return await response.text()
} catch (error: unknown) {
  if (error instanceof Error) {
    throw new Error(`Failed: ${error.message}`, { cause: error })
  }
  throw new Error('Unknown error')
}
```

```typescript
// ✅ Promise.all for parallel — typed tuple
const [users, orders] = await Promise.all([
  db.users.findMany(),
  db.orders.findMany(),
])

// ✅ void operator — explicit intentional fire-and-forget
void cleanupOldSessions()  // intentional, documented
```

## ❌ Incorrect

```typescript
// ❌ Unhandled promise — silent failure
db.users.create({ data: user })  // ❌ no await, no .catch()

// ❌ catch(error: Error) — not all thrown values are Error instances
catch (error: Error) { console.log(error.message) }  // may crash

// ❌ Unnecessary async — no await inside
async function getLabel(id: string): Promise<string> {
  return labels[id] ?? 'unknown'   // ❌ remove async
}

// ❌ Empty catch — failure invisible
catch { }

// ❌ Sequential awaits when parallel is safe — use Promise.all([...])
```

## Checklist

- [ ] Every `Promise` is either `await`-ed or explicitly `void`-ed with a comment
- [ ] All `catch` clauses use `unknown` and narrow before property access
- [ ] Expected failures return `Result<T, E>` — not `throw`
- [ ] Independent async operations use `Promise.all` or `Promise.allSettled`
- [ ] Avoid `async` functions without at least one `await` in the body (exceptions documented)
- [ ] Re-throws use `{ cause: error }` for error chain

## See Also

- [ts-narrowing-guards](ts-narrowing-guards.md) (Result narrowing)
- [ts-patterns-anti-patterns](ts-patterns-anti-patterns.md)
