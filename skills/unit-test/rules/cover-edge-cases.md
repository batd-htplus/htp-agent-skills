# Rule: Cover Edge Cases Systematically

## Intent
Edge cases must be identified through a taxonomy checklist — not intuition. Every applicable category in the taxonomy requires at least one test.

---

## Rule Definition

> Before writing edge case tests, run the Edge Case Taxonomy against every parameter and return value.
> Write at least one test per applicable category — not one generic "edge case" test.

---

## Edge Case Taxonomy

Work through this taxonomy for every function parameter and return value.

### Collections (arrays, sets, maps)
| Edge Case | Condition |
|---|---|
| Empty collection | `[]`, `{}`, `new Set()` |
| Single element | exactly 1 item |
| Max size collection | system limit or performance limit |
| Collection with duplicates | when uniqueness matters |

### Strings
| Edge Case | Condition |
|---|---|
| Empty string | `""` |
| Whitespace only | `"   "` |
| Unicode / emoji | `"héllo"`, `"👋"` |
| Very long string | near or at max length |

### Numbers
| Edge Case | Condition |
|---|---|
| Zero | `0` |
| Infinity | `Infinity`, `-Infinity` |
| NaN | `NaN` |
| Signed boundary | `-1`, negative values where non-negative expected |
| Floating point | `0.1 + 0.2` precision issues |
| Large magnitude | max/min safe integer or domain max |

### Dates
| Edge Case | Condition |
|---|---|
| Leap year | Feb 29 |
| Year boundary | Dec 31 → Jan 1 |
| Timezone / DST transition | clock change day/hour |
| Invalid calendar date | `2026-02-30`, impossible local datetime |
| Inclusive boundary | equals `start` or equals `end` |

### Async / Concurrency
| Edge Case | Condition |
|---|---|
| Timeout | exceeds expected duration |
| Concurrent calls | same function called twice simultaneously |
| Retry after failure | state after first failed attempt |
| Cancellation/abort | aborted request/task mid-flight |
| Out-of-order completion | slower request returns after newer one |

### State
| Edge Case | Condition |
|---|---|
| First call | no prior state exists |
| Repeated calls | accumulated or cached state |
| State after error | system state after a failed operation |
| Idempotent re-run | same command applied multiple times |
| Stale version/conflict | update with outdated version/token |

### Protocol / Integration-shaped Inputs
| Edge Case | Condition |
|---|---|
| Unknown fields | extra keys in payload/query |
| Missing optional vs missing required | defaults vs validation failure |
| Case sensitivity | `Status` vs `status`, enum case mismatch |
| Normalization mismatch | trimmed vs untrimmed, NFC/NFD unicode forms |

---

## Application Rule

1. Mark which categories **apply** to each parameter/output/state transition.
2. For each applicable category, write at least one focused test.
3. For high-risk paths, add at least two edge tests per critical category.
4. Categories that **do not apply** must be explicitly skipped with a reason.
5. Link each test name back to taxonomy category.

---

## Required Evidence

- Taxonomy coverage table (category -> apply/skip -> reason)
- One test name per applicable category
- Explicit skip rationale for non-applicable categories
- Mapping from taxonomy category -> concrete data sample

---

## Checklist

- [ ] Edge case taxonomy has been reviewed per parameter
- [ ] Empty collection test exists for applicable array/object inputs
- [ ] Single-element test exists for applicable collection inputs
- [ ] `0` is tested as a distinct case for applicable numeric inputs
- [ ] `NaN`/`Infinity` are tested where arithmetic semantics allow them
- [ ] Signed/negative numeric cases are covered where domain-constrained
- [ ] Date boundary tests exist for any date comparison or calculation
- [ ] Invalid/impossible date values are covered where date parsing exists
- [ ] Unicode/special character tests exist for applicable string processing
- [ ] Async edge cases are tested for applicable async functions
- [ ] Cancellation and out-of-order completion are covered for async workflows
- [ ] Each edge case is its own test — not bundled into one "edge cases" test

---

## Violations

- Identifying edge cases by intuition without using the taxonomy
- Bundling multiple edge cases into one test ("handles all special inputs")
- Skipping the empty collection test — this is the most frequently missed edge case
- Ignoring floating-point precision for any financial or mathematical function
- Not testing state after error — subsequent calls may behave incorrectly
- Skipping idempotency or version-conflict checks on mutating operations
