# Rule: Enforce Input Validation Testing

## Intent
Every entry point that accepts external data must have tests that verify validation behavior — independently of happy-path tests.

---

## Rule Definition

> For every externally controlled input parameter, tests MUST cover all applicable invalid categories: null · undefined · wrong type · empty · oversized · malformed format · injection characters.
>
> Validation that is not tested does not exist from a quality perspective.

---

## Mandatory Invalid Input Categories

Apply this checklist to **every externally controlled parameter** of every public function or API endpoint. Mark non-applicable categories explicitly:

| Category | Examples |
|---|---|
| **Null / undefined** | `null`, `undefined` |
| **Wrong type** | string where number expected, array where object expected |
| **Empty value** | `""`, `[]`, `{}`, `0` (contextual) |
| **Oversized** | string > max length, number > max value, array > max items |
| **Malformed format** | invalid email, malformed UUID, wrong date format |
| **Special / injection characters** | `<script>`, `'; DROP TABLE`, `../../etc/passwd` |

---

## How to Apply

1. List externally controlled parameters for the unit/API.
2. For each parameter, mark applicable invalid categories.
3. Create one test per applicable category.
4. Assert exact validation error type/code/status for each case.
5. Keep happy-path tests after validation groups.

---

## Required Evidence

- Parameter-to-category matrix with N/A reasons
- Test list mapped to matrix rows
- Error contract assertions for each validation case

---

## Checklist

- [ ] Validation tests are grouped by parameter so coverage is reviewable
- [ ] Every non-optional parameter has a `null` test
- [ ] Every non-optional parameter has an `undefined` test
- [ ] Every applicable string parameter has an empty string test
- [ ] Every applicable collection parameter has an empty collection test
- [ ] Every typed parameter has a wrong-type test
- [ ] Every formatted string (email, UUID, date) has a malformed-format test
- [ ] Every string parameter that reaches storage or external systems has an injection test
- [ ] Every validation test asserts exact error type/code/status (not just generic `toThrow()`)
- [ ] Happy path tests are the last group in the describe block

---

## Violations

- Only testing happy path — validation layer is untested by definition
- Using `.toThrow()` without specifying error type
- Testing the UI form validation but not the function itself
- Assuming the ORM or framework validates input — always verify
- Testing `null` and `undefined` in one test — they may behave differently
