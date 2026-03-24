# Rule: Use Arrange–Act–Assert (AAA) Structure

## Intent
Make each unit test readable, reviewable, and failure-localizable by enforcing a consistent structure.

---

## Rule Definition

> Every unit test MUST be structured as **Arrange → Act → Assert**.
>
> If you cannot clearly point to which lines are Arrange/Act/Assert, the test is not well-structured.

---

## Requirements

- **Arrange**: build inputs, stubs/mocks, and initial state.
- **Act**: execute exactly one unit under test (the trigger).
- **Assert**: verify one behavior (see `separate-test-concerns`).

---

## How to Apply

1. Draft the test name as one behavior.
2. Write explicit Arrange block (inputs + doubles + pre-state).
3. Keep one primary call in Act block.
4. Keep assertions in Assert block only.
5. Split test if more than one trigger/behavior appears.

---

## Required Evidence

- Visible AAA separation (comments or blank-line blocks)
- Single primary trigger in Act block
- Assertion lines mapped to one behavior

---

## Checklist

- [ ] Arrange/Act/Assert are visually separated (blank lines or comments)
- [ ] Act has exactly one primary trigger call
- [ ] Assertions are specific and deterministic
