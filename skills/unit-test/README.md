# Unit Test Design Techniques (ISTQB-aligned)

## Purpose

Rule set for designing and reviewing unit tests with consistent quality.

## Quick Start

1. Classify scope: confirm target is unit-level (isolated, deterministic).
2. Apply rules in order from `AGENTS.md`.
3. Produce evidence artifacts (partition map, risk table, validation matrix).
4. Run review using the standard findings format.

## Includes

- Unit test fundamentals: AAA, isolation, determinism, specific assertions
- Equivalence partitioning (EP)
- Boundary value analysis (BVA)
- Risk-based prioritization
- Negative testing
- Edge-case taxonomy
- Redundancy control and concern separation

## Scope

Applies to unit tests first; can be reused at other levels when appropriate.

Not in scope:
- Performance/load testing
- UI/visual regression testing
- End-to-end journey testing
- Framework/tool-specific guidance

## Unit Test Definition (for this package)

A unit test:
- Exercises one unit (function/class/module)
- Isolates dependencies with test doubles
- Avoids real network/filesystem/database/clock
- Is deterministic
- Uses specific, behavior-level assertions
