# Rule: Isolate the Unit with Test Doubles

## Intent
Unit tests must validate the unit’s behavior, not the behavior of its dependencies or infrastructure.

---

## Rule Definition

> Unit tests MUST isolate external dependencies using test doubles (stubs/mocks/fakes).
> A unit test MUST NOT depend on network, filesystem, real database, real clock, or global process state.

External dependencies include HTTP clients, queues, email/SMS providers, databases/caches/brokers, file I/O, system clock/timers, and randomness sources.

---

## Requirements

- Dependency behavior MUST be controlled (stubbed) to make the test deterministic.
- Assertions MUST focus on the unit:
  - returned value, state change, or emitted interaction
  - not the internals of the dependency implementation

---

## How to Apply

1. List external dependencies touched by the unit.
2. Replace each dependency with a stub/mock/fake.
3. Configure deterministic outputs for each double.
4. Execute unit with injected doubles only.
5. Assert unit behavior and interaction contract.

---

## Required Evidence

- Dependency inventory (real vs doubled)
- No real network/fs/db/clock in test setup
- Interaction assertions against doubles

---

## Checklist

- [ ] No real I/O (network/fs/db) is used
- [ ] All dependency outputs are stubbed/controlled
- [ ] Assertions verify unit behavior, not infrastructure
