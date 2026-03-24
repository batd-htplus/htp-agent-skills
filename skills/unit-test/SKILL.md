---
name: test-design-techniques
description: Enforce unit-test design quality using rule-driven techniques (AAA, isolation, determinism, EP, BVA, risk-based depth, negative cases, input validation, edge cases, concern separation, redundancy control). Use when writing/reviewing unit tests or improving weak/flaky test suites.
---

# Unit Test Design Techniques

## When To Use

- User asks to write unit tests
- User asks to review test quality or coverage
- Existing tests are flaky, redundant, or unclear
- Team needs consistent test-design standards

## Apply In This Order

1. `rules/use-arrange-act-assert.md`
2. `rules/isolate-units-with-test-doubles.md`
3. `rules/ensure-deterministic-tests.md`
4. `rules/prefer-specific-assertions.md`
5. `rules/prioritize-risk-based-testing.md`
6. `rules/apply-equivalence-partitioning.md`
7. `rules/apply-boundary-value-analysis.md`
8. `rules/ensure-positive-coverage.md`
9. `rules/design-negative-test-cases.md`
10. `rules/enforce-input-validation.md`
11. `rules/cover-edge-cases.md`
12. `rules/separate-test-concerns.md`
13. `rules/minimize-redundant-test-cases.md`

## Required Output

When reviewing, return:

```markdown
## Unit Test Findings

### [rule-id] Rule title — HIGH/MEDIUM
- Finding: ...
- Evidence: ...
- Fix: ...

## Summary
X high, Y medium findings
```

## References

- Agent workflow: `AGENTS.md`
- Scope and quick start: `README.md`
- Section map: `_sections.md`
