# Rule: Design Negative Test Cases as First-Class Citizens

## Intent
Negative tests — verifying what the system MUST NOT do — are mandatory coverage, not optional additions.

---

## Rule Definition

> Negative tests MUST exist for every failure mode that is realistic for the unit.
> Every negative test MUST assert a specific failure behavior (error type/code/status) — not just that “it failed”.

---

## Negative Test Categories

Every feature must be analyzed for these negative scenario types:

| Category | Covers |
|---|---|
| **Invalid input** | Wrong type, null, empty, malformed — see `enforce-input-validation` rule |
| **Business rule violation** | Duplicate entry, exceeded quota, insufficient balance, invalid state |
| **Unauthorized access** | Wrong role, missing token, expired session, ownership mismatch |
| **Resource not found** | Nonexistent ID, deleted record, stale reference |
| **Constraint violation** | Referential integrity, uniqueness, required dependency missing |
| **Side-effect integrity** | Failed operation must NOT produce partial state changes |

---

## How to Apply

1. Build a failure-mode list for the unit before writing tests.
2. Map each failure mode to one category above.
3. Write one focused negative test per failure mode.
4. For mutating operations, assert state before/after failure is unchanged.
5. Assert exact error type/code/status in every negative test.

---

## Required Evidence

Provide these artifacts in PR or test notes:

- Failure-mode map (mode -> category -> test name)
- Error contract asserted (type/code/status)
- No-partial-side-effect proof for mutating failures

---

## Checklist

- [ ] Negative scenarios are planned alongside positive scenarios — not added later
- [ ] All 6 negative categories are reviewed for each feature
- [ ] Every negative test asserts the exact error type or status code
- [ ] Every mutating operation has a failure test that proves no partial side effects
- [ ] Negative coverage is sufficient for the feature's risk tier and failure surface
- [ ] Authorization failure scenarios are explicitly included
- [ ] Business rule violations have their own test — not grouped with input validation

---

## Violations

- Treating negative tests as "we'll add them later"
- Asserting only that an error occurred (no type/code/status)
- One generic "error" test covering multiple failure scenarios
- Not verifying that a failed operation left no partial state change
- Testing invalid input only — business rule violations are a separate category
