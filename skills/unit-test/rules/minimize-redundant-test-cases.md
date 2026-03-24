# Rule: Minimize Redundant Test Cases

## Intent
Every test must add unique behavioral coverage. Tests that verify the same partition or branch as an existing test must be removed.

---

## Rule Definition

> Two tests are redundant if they exercise the same equivalence partition AND produce the same assertion type.
> One of them MUST be removed.

Test count is not a quality metric. Coverage of distinct behaviors is.

---

## Detection Rules

- Same partition + same assertion type -> redundant
- Different values in same behavior partition -> redundant
- Parameterized rows must represent distinct partitions
- If removing a test does not remove behavior coverage -> redundant

## Deduplication Process

1. List all existing tests for a function
2. Map each test to a partition label (from EP analysis)
3. Identify duplicate partition mappings
4. Keep the most representative test per partition
5. Delete the rest

---

## Required Evidence

- Test-to-partition map for the target unit
- Duplicate groups and retained representative tests
- Coverage check showing no behavior loss after deletion

---

## Allowed Multiplicity

These are situations where multiple tests per "behavior" are acceptable:

| Situation | Why Multiple Tests Are Allowed |
|---|---|
| BVA boundary points | Each boundary point is technically a different partition |
| Different error types | `TypeError` vs `ValidationError` are different behaviors |
| Different side effects | Return value test vs side effect test are different concerns |
| Different valid partitions | Each valid EP partition requires one test |

---

## Checklist

- [ ] Each test maps to exactly one partition or distinct branch
- [ ] No two tests share the same partition label
- [ ] Parameterized test rows reviewed — each row represents a different partition
- [ ] Each test answers: "What unique behavior becomes unverified if removed?"
- [ ] Partition map is documented so future authors don't re-add redundant tests
- [ ] Test count has been reviewed after writing — any increase must be justified by new partition

---

## Violations

- Writing multiple tests for the same valid partition "for safety"
- Using `test.each` with 20 rows all in the same partition
- Keeping redundant tests because "they're already written"
- No partition documentation — guarantees future redundancy
- Equating high test count with high coverage quality
