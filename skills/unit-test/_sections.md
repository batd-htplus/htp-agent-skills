# Unit Test Design Techniques — Section Map

---

## Section 0: Unit Test Fundamentals

**Description:** Structural rules for readability, isolation, determinism, and assertion quality.

**Impact:** High

**Rules:**
- `use-arrange-act-assert` — Enforce Arrange–Act–Assert structure
- `isolate-units-with-test-doubles` — No real I/O; isolate dependencies with doubles
- `ensure-deterministic-tests` — Control time, randomness, and ordering
- `prefer-specific-assertions` — Assert exact behavior; avoid vague truthiness

---

## Section 1: Core Test Design

**Description:** Core techniques for coverage design and test depth decisions.

**Impact:** High

**Rules:**
- `apply-boundary-value-analysis` — Test all 7 boundary points for every range-based input
- `apply-equivalence-partitioning` — Define partitions, test exactly one representative per partition
- `ensure-positive-coverage` — Fully verify all valid behaviors before negative tests
- `design-negative-test-cases` — Negative tests are mandatory, not optional

---

## Section 2: Validation & Input Handling

**Description:** Rules for invalid input handling and systematic edge coverage.

**Impact:** High

**Rules:**
- `enforce-input-validation` — Test null, undefined, wrong type, empty, oversized, malformed, injection
- `cover-edge-cases` — Apply the edge case taxonomy to identify non-obvious but real failure conditions

---

## Section 3: Optimization & Strategy

**Description:** Rules for effort prioritization, failure isolation, and suite maintainability.

**Impact:** Medium–High

**Rules:**
- `minimize-redundant-test-cases` — One test per partition; remove tests that verify the same behavior
- `prioritize-risk-based-testing` — Score Likelihood × Impact; assign test depth by risk tier
- `separate-test-concerns` — One behavior per test; split when the name requires "and"

## Rule Execution Order

Apply rules in this sequence:

```
0. use-arrange-act-assert
   → Keep tests readable and structured

1. isolate-units-with-test-doubles
   → Ensure the test is actually a unit test

2. ensure-deterministic-tests
   → Prevent flakiness (time/randomness/order)

3. prioritize-risk-based-testing
   → Determine test depth before writing anything

4. apply-equivalence-partitioning
   → Define all partitions (valid + invalid)

5. apply-boundary-value-analysis
   → Expand range partitions with 7-point boundary sets

6. ensure-positive-coverage
   → Write and pass all positive tests first

7. design-negative-test-cases
   → Cover all 6 negative categories

8. enforce-input-validation
   → Verify all invalid input types per parameter

9. cover-edge-cases
   → Run the taxonomy; write one test per applicable category

10. separate-test-concerns
   → Review all tests; split any that contain "and" or test multiple concerns

11. minimize-redundant-test-cases
   → Final pass; remove tests that map to the same partition as an existing test
```
