# Rule: Prefer Specific Assertions over Vague Assertions

## Intent
Vague assertions hide bugs and create false confidence.

---

## Rule Definition

> Tests MUST assert the **exact** behavior that matters.
> Avoid assertions that only check existence, truthiness, or partial shape unless the contract is intentionally flexible.

---

## How to Apply

1. Identify behavior contract (value/state/error/side effect).
2. Assert exact expected fields/values for that contract.
3. For errors, assert type/code/status and relevant details.
4. Replace vague assertions (`truthy`, `not null`) with contract-level checks.
5. Use snapshots only when they improve clarity and are stable.

---

## Required Evidence

- Contract-to-assertion mapping for each test
- Explicit error contract assertions where applicable
- Justification for any snapshot usage

---

## Correct

```
assertEqual(result, { id: "u_123", status: "active" })
```

```
assertEqual(error.code, "VALIDATION_ERROR")
assertEqual(error.details, [{ field: "email", issue: "must be a valid email" }])
```

---

## Incorrect

```
assertTrue(result)                     ❌ does not validate behavior
assertNotNull(result)                  ❌ too weak
assertMatches(result, { id: "<any>" }) ❌ missing critical fields
```

---

## Checklist

- [ ] Assertions prove the behavior, not just "something happened"
- [ ] Error assertions check type/code/message as applicable
- [ ] Snapshots are used only when they improve clarity (not as a default)
