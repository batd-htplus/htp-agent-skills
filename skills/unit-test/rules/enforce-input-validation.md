# Rule: Enforce Input Validation Testing

## Intent
Every entry point that accepts external data must have tests that verify validation behavior — independently of happy-path tests.

---

## Rule Definition

> For every externally controlled input parameter, tests MUST cover all applicable invalid categories: null · undefined · wrong type · empty · oversized · malformed format · injection characters.
>
> Validation that is not tested does not exist from a quality perspective.

---

## Core Invalid Input Categories

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

## Extended Invalid Cases (when applicable)

| Case | Typical trigger |
|---|---|
| **Boundary-near invalids** | `min-1`, `max+1`, over-limit payload |
| **Enum/domain mismatch** | value not in allowed set |
| **Cross-field invalid** | `startDate > endDate`, invalid currency pair |
| **Nested shape mismatch** | object vs scalar, wrong nested array/object form |
| **Boolean coercion traps** | `"false"`, `"0"`, `0/1` where strict boolean required |
| **Precision/scale invalid** | too many decimal places, invalid monetary scale |
| **Duplicate/repeated input** | duplicated query key, repeated identifier list |

---

## Validation Matrix (required)

Define before test writing:

```text
Parameter | Required | Type | Constraints | Applicable invalid categories | N/A reason
```

At least one row per externally controlled parameter.

---

## Assertion Contract (required)

Each validation test MUST assert:

- Error type/class
- Error code/status
- Target field/parameter
- Stable detail fragment (only if contract requires message details)

Never assert only generic `toThrow()` or only free-form message text.

---

## How to Apply

1. List externally controlled parameters for the unit/API.
2. For each parameter, mark applicable invalid categories.
3. Add extended cases for parameters with enum/range/format/cross-field constraints.
4. Create one focused test per applicable case.
5. Assert full validation contract (type/code/field).
6. Keep happy-path tests after validation groups.

---

## Required Evidence

- Parameter-to-category matrix with N/A reasons
- Test list mapped to matrix rows
- Error contract assertions for each validation case
- Cross-field/enum validation case list (if applicable)

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
- [ ] Every validation test asserts type/code/field (not only generic `toThrow()`)
- [ ] Enum/domain mismatch is tested where constrained values exist
- [ ] Cross-field invalid combinations are tested where fields are dependent
- [ ] Happy path tests are the last group in the describe block

---

## Violations

- Only testing happy path — validation layer is untested by definition
- Using `.toThrow()` without specifying error type
- Testing the UI form validation but not the function itself
- Assuming the ORM or framework validates input — always verify
- Testing `null` and `undefined` in one test — they may behave differently
- Skipping cross-field validation tests for related parameters
