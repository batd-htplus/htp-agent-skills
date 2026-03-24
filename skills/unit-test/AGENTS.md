# Unit Test Design Techniques — Agent Skill Reference

> **Version:** 1.0.2  
> **Purpose:** Enforce clear, consistent, and system-ready unit tests.  
> **Scope:** Language/framework-agnostic rules for writing and reviewing unit tests.

---

## Definition: Unit Test (for this skill)

A unit test:
- Exercises one unit (function/class/module)
- Isolates dependencies via test doubles (no real network/filesystem/DB/clock)
- Is deterministic (no flakiness from time/randomness/order)
- Uses specific assertions (not only “truthy/falsy”)

If these constraints do not hold, treat the test as integration/contract/E2E and adjust expectations.

---

## Rule Application Order

```
0. use-arrange-act-assert             → Structure the test (AAA)
1. isolate-units-with-test-doubles    → Keep it a unit test (no real I/O)
2. ensure-deterministic-tests         → Control time/random/order
3. prefer-specific-assertions         → Assert exact behavior
4. prioritize-risk-based-testing      → Decide depth by risk
5. apply-equivalence-partitioning     → Map input partitions (valid + invalid)
6. apply-boundary-value-analysis      → Expand range edges (7-point set)
7. ensure-positive-coverage           → Verify all valid behaviors first
8. design-negative-test-cases         → Verify failure modes + no partial side effects
9. enforce-input-validation           → Cover invalid types/forms per parameter
10. cover-edge-cases                  → Apply taxonomy for non-obvious cases
11. separate-test-concerns            → One behavior per test
12. minimize-redundant-test-cases     → Remove duplicate behavior coverage
```

---

## Execution Protocol

When applying this skill, always:

1. Confirm test level is unit (otherwise relabel scope).
2. Apply rules in listed order; do not skip earlier fundamentals.
3. Require evidence per rule (maps/tables/test-name traceability).
4. Report findings with severity and concrete fix action.
5. Block "pass" if mandatory evidence is missing.

---

## Review Output Format

```
## Unit Test Findings

### [rule-id] Rule title — HIGH/MEDIUM
- Finding: ...
- Fix: ...

## Summary
X high, Y medium findings
```

---

*Unit Test Design Techniques Skill Package · v1.0.2*
