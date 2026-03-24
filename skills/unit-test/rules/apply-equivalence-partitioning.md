# Rule: Apply Equivalence Partitioning

## Intent
Group inputs by identical behavior and test one representative per group.

---

## Rule Definition

> Identify all equivalence partitions (valid and invalid) BEFORE writing any test.
> Write exactly ONE test per partition.

Two values belong to the same partition if and only if they trigger **identical system behavior**.
If behavior differs → they are different partitions → they need separate tests.

---

## Partition Classification

| Type | Definition | Must Test? |
|---|---|---|
| **Valid partition** | Inputs the system accepts and processes | Yes |
| **Invalid partition** | Inputs the system rejects or errors on | Yes |

Invalid partitions are not optional. They are required coverage.

---

## How to Define Partitions

1. List all documented behaviors for the input
2. Group values by identical expected outcome
3. Label each partition: `P1`, `P2`, `P3` ... for traceability
4. Mark each as `valid` or `invalid`
5. Select one **typical** representative per partition (not a boundary — boundaries belong to BVA)
6. Map each partition to one test

---

## Test Naming Convention

```
P[n]: [description of partition] (representative: [chosen value])
```

---

## Required Evidence

- Partition map (valid + invalid) before test code
- One representative value per partition
- 1:1 mapping (partition label -> test name)

---

## Checklist

- [ ] Partition map is documented before the first test is written
- [ ] Both valid AND invalid partitions are defined
- [ ] Each partition has a label for traceability
- [ ] Exactly one representative value per partition
- [ ] No two tests in the suite cover the same partition
- [ ] Test names reference the partition label and description
- [ ] Adding new behavior = adding new partition = adding new test (1:1 rule)
- [ ] Non-obvious partitions are included: null, empty, type mismatch

---

## Violations

- Documenting only valid partitions — invalid partitions are required
- Testing 3 values from the same partition (redundancy)
- Using a boundary value as a partition representative (boundary → BVA rule)
- Writing tests before defining the partition map
- No partition label in the test name — makes traceability impossible
