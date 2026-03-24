# Rule: Separate Test Concerns — One Behavior Per Test

## Intent
Each test verifies exactly one behavior. If a test can fail for two different reasons, it must be split into two tests.

---

## Rule Definition

> One test = one trigger + one behavior + one assertion group.
>
> If the test name requires "and" to be accurate, split the test.

---

## Concern Types

Treat each of these as a separate concern:

- Return/output contract
- Persisted state change
- External interaction (event, queue, email, webhook)
- Error contract (type/code/status)
- Authorization outcome
- Observability contract (log/metric) when business-critical

---

## Naming Rule

Test names must describe a single, specific behavior:

| Pattern | Acceptable? |
|---|---|
| `creates order with correct total` | ✅ |
| `sends confirmation email to user` | ✅ |
| `creates order and sends email` | ❌ → split into 2 |
| `handles errors correctly` | ❌ → too vague, which error? |
| `returns correct result` | ❌ → what result? |

---

## Failure Isolation Rule

When a test fails, the test name alone must identify:
- **Which behavior** broke
- **Which concern** is affected

If reading the test name doesn't tell you exactly where to look — the test is mixing concerns.

---

## How to Apply

1. Write test intent as one sentence; if it contains "and", split immediately.
2. Keep one primary trigger per test.
3. Keep assertions within one concern (return value OR side effect OR error type).
4. Move cross-concern checks into separate tests.
5. Rename tests so failure location is obvious from title only.
6. For stateful flows, split precondition/setup verification from outcome verification where needed.

---

## Required Evidence

- Test name list with one behavior each
- Concern map per test (return/side-effect/error)
- Split log for tests refactored due to mixed concerns
- Reason for any approved multi-assert test (same atomic outcome only)

---

## Checklist

- [ ] Every test name describes one specific behavior
- [ ] No test name contains "and"
- [ ] Side effects are in separate tests from return value tests
- [ ] Each distinct error type has its own test
- [ ] Multiple assertions in one test target the same atomic outcome only
- [ ] Tests are grouped so concern boundaries remain explicit and reviewable
- [ ] When a test fails, its name alone identifies the broken behavior
- [ ] Authorization and error concerns are not mixed in one test

---

## Violations

- Test name contains "and" — immediate split required
- Return value and side effects asserted in the same test
- Multiple error conditions asserted in one test
- One test for an entire feature ("it processes the order")
- No grouping — all tests at the same level with no concern boundaries
- Verifying auth failure and business output in the same test
