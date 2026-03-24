# Rule: Ensure Tests Are Deterministic

## Intent
Deterministic tests prevent flaky CI and make failures actionable.

---

## Rule Definition

> A unit test MUST be deterministic: same inputs → same result, every run.
> If a test can fail without a code change, it is invalid.

---

## Common Sources of Flakiness (must be controlled)

- Current time (`Date.now()`, time zones, DST)
- Randomness (`Math.random()`, UUIDs without stubbing)
- Concurrency and ordering (race conditions, shared mutable globals)
- Real async timers and sleeps (`setTimeout`, `sleep(100)`)
- Parallel test interaction (shared DB/schema, shared filesystem paths)

---

## How to Apply

1. Identify nondeterministic inputs (time, random, async ordering).
2. Replace with controllable sources (fake clock, seeded random, test scheduler).
3. Remove `sleep`-based waits; synchronize on explicit events/state.
4. Isolate shared mutable state between tests.
5. Re-run tests multiple times locally; failures must be stable.

---

## Required Evidence

- Determinism controls used (clock/random/scheduler)
- No `sleep`-based assertions
- Repeat-run stability (multiple runs, same result)

---

## Checklist

- [ ] Time/randomness are stubbed or injected
- [ ] No sleeps; use fake timers or explicit synchronization
- [ ] No shared global state across tests
