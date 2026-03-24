# Rule: Prioritize Test Design Using Risk-Based Analysis

## Intent
Allocate test effort proportional to risk.

---

## Rule Definition

> Before writing any tests, score every module using Likelihood × Impact.
> Assign test depth based on risk tier.
> Write tests in risk-tier order: Critical → High → Medium → Low.

---

## Risk Scoring Model

**Risk Score = Likelihood (1–3) × Impact (1–3)**

### Likelihood (1–3)
| Score | Condition |
|---|---|
| 3 | Refactored/recently changed complex logic |
| 2 | Third-party dependency or unfamiliar ownership |
| 1 | Stable, rarely changed, simple logic |

### Impact (1–3)
| Score | Condition |
|---|---|
| 3 | Security, payments, data loss, compliance |
| 2 | Broad user impact or silent failure |
| 1 | Display/formatting/non-critical behavior |

---

## Risk Tier → Test Depth Mapping

| Tier | Score | Required Test Depth |
|---|---|---|
| **Critical** | 9 | BVA + EP + all negative categories + edge cases + state transitions |
| **High** | 6–8 | EP + negative cases + key edge cases |
| **Medium** | 3–5 | EP + basic negative (null, wrong type) |
| **Low** | 1–2 | Happy path + null guard only |

---

## How to Apply

1. Score Likelihood and Impact per module.
2. Compute total score and assign risk tier.
3. Select test depth from the tier mapping.
4. Write tests in descending tier order.
5. Re-score when trigger conditions occur.

---

## Required Evidence

- Risk table (Likelihood, Impact, Score, Tier)
- Tier-to-depth mapping used by module
- Reassessment log after trigger events

---

## Mandatory Reassessment Triggers

Risk scores MUST be reassessed when:
- A module is refactored or rewritten
- A production incident occurs in the module
- A third-party dependency is upgraded
- A new developer takes ownership of the module

---

## Checklist

- [ ] Risk assessment table is completed before any tests are written
- [ ] Every module has a documented likelihood and impact score
- [ ] Test writing order follows: Critical first, Low last
- [ ] Critical-tier modules include EP, BVA, negative, edge, and state-transition coverage
- [ ] Low-tier modules have no more depth than: happy path + null guard
- [ ] Risk scores are updated after every refactor
- [ ] External/third-party dependencies are NOT scored as low risk

---

## Violations

- Applying equal test depth to all modules regardless of risk
- Scoring risk by gut feeling without using the scoring model
- Not updating risk scores after refactors
- Treating third-party integrations as low-risk
- Using test count as a proxy for coverage quality
- Spending the majority of test effort on UI/display code (low impact)
