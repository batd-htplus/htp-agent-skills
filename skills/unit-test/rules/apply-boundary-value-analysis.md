# Rule: Apply Boundary Value Analysis

## Intent
Test at the exact edges of every constrained range — not in the middle.

---

## Rule Definition

> For every input with a defined range [min, max], tests MUST cover:
> `min-1` · `min` · `min+1` · `nominal` · `max-1` · `max` · `max+1`

Applies to: numeric ranges, string lengths, array sizes, date ranges, index access, pagination, file sizes, rate limits.

---

## Boundaries Are Not Optional

- Testing only a nominal value is **incomplete coverage**, not a design decision.
- Each boundary point is a **separate test** — never merge them.
- `min-1` and `max+1` must assert **rejection**, not just falsiness.
- Both lower AND upper boundaries must be covered in every range.

---

## How to Identify Boundaries

1. Read the constraint: "must be between X and Y", "max N characters", "at least 1 item"
2. Map the 7-point set for that constraint
3. Label each point: **valid** (within range) or **invalid** (outside range)
4. Write the test name to include the boundary intent, not just the value

---

## Required Evidence

- Range definition per input (`min`, `max`, open-ended note if any)
- Boundary matrix with covered points
- Specific rejection assertions for invalid boundaries

---

## Naming Convention

```
[passes/rejects] [input] = [value] ([boundary description])
```

Examples:
- `rejects quantity = 0 (min-1, below lower boundary)`
- `accepts quantity = 1 (min, exact lower boundary)`
- `accepts quantity = 100 (max, exact upper boundary)`
- `rejects quantity = 101 (max+1, above upper boundary)`

---

## Checklist

- [ ] Every range-based input has its [min, max] documented
- [ ] Tests exist for all 7 boundary points (or justified subset if range is open-ended)
- [ ] Invalid boundary values assert specific rejection behavior
- [ ] Each boundary point is a distinct, individually named test
- [ ] String length, array size, and date ranges are treated as numeric ranges
- [ ] Upper boundary is tested — not just lower boundary

---

## Violations

- Testing only `nominal` value for a ranged input
- Merging `min`, `min+1` into one test
- Testing `min-10` instead of `min-1` (too far from boundary)
- Asserting `toBeFalsy()` on invalid boundary (not specific enough)
- Testing lower boundary only, skipping upper boundary
