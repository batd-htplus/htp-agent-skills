# Rule: Ensure Complete Positive Coverage

## Intent
Fully verify documented valid behaviors before negative/edge testing.

---

## Rule Definition

> Every valid input variant, valid state, and documented output field MUST have a passing positive test.
>
> A positive test that only checks existence (e.g., “not null”) is not complete coverage.

---

## Completeness Criteria

| Assertion Type | Requirement |
|---|---|
| **Return value** | Every field that matters is asserted with an exact expected value |
| **State change** | DB records, cache entries, counters, flags — all verified |
| **Side effects** | Events emitted, emails sent, queues enqueued — all verified |
| **Output structure** | Shape of the returned object matches the contract |

---

## Coverage Completeness Rules

**Rule 1 — One test per valid partition**
Every valid equivalence partition identified in EP analysis must have a positive test.

**Rule 2 — Assert output contract**
Assert all contract-relevant fields, not just existence or one key.

**Rule 3 — Verify all side effects**
If the function writes to a DB AND emits an event, both must be verified — in separate tests (see `separate-test-concerns` rule).

**Rule 4 — Order of writing**
Positive tests → Negative tests → Edge case tests
Do not write negative tests until positive tests are complete and passing.

**Rule 5 — State-path completeness**
If logic is stateful, each reachable valid state transition must have a positive test.

**Rule 6 — Contract variant completeness**
If output contract varies by mode/role/flag, each valid variant must have a positive test.

---

## How to Apply

1. Enumerate valid partitions and valid states.
2. Write one positive test per valid partition.
3. Add positive tests for each valid state transition and contract variant.
4. Assert full output contract and relevant side effects/state changes.
5. Ensure all positive tests pass.
6. Only then proceed to negative and edge-case tests.

---

## Required Evidence

- Valid-partition list and test mapping
- Valid state-transition map and test mapping (if stateful)
- Contract variant map (mode/role/flag) and test mapping
- Output contract assertion coverage
- Positive suite pass status before negative tests

---

## Checklist

- [ ] All documented valid use cases have a corresponding positive test
- [ ] Every output field is asserted with an exact expected value
- [ ] Multiple valid input variants (from EP) each have their own positive test
- [ ] State changes are verified in positive tests (not assumed)
- [ ] Side effects are verified (separate tests per concern)
- [ ] Valid state transitions are covered for stateful logic
- [ ] Valid contract variants are covered (role/mode/flag differences)
- [ ] All positive tests pass BEFORE negative tests are written
- [ ] Test names describe the specific valid scenario — not just "happy path"

---

## Violations

- Using only existence/truthiness checks as the sole assertion
- One generic "it works" test covering multiple valid variants
- Not asserting the complete output structure
- Missing positive tests for a valid state transition path
- Missing positive tests for role/mode-specific valid output
- Writing negative tests before all positive scenarios pass
- "The framework handles it" — if it's a required output, assert it
