---
name: vercel-composition-patterns
description: >
  React composition patterns that scale. Use when refactoring components with
  boolean prop proliferation, building flexible component libraries, or
  designing reusable APIs.
  Covers: compound components, state lifting, context providers, render props,
  explicit variants, and React 19 API changes.
  Triggers on: compound components, render props, context providers,
  component architecture, boolean props, prop drilling, composition,
  reusable components, component libraries, React 19, forwardRef, useContext.
license: MIT
metadata:
  author: vercel
  version: '1.0.0'
  tags: [react, composition, patterns, components, architecture]
---

# React Composition Patterns — Skill Entry Point

## What This Skill Does

Composition patterns for building flexible, maintainable React components. Avoid boolean prop proliferation by using compound components, lifting state, and composing internals. These patterns make codebases easier for both humans and AI agents to work with as they scale.

- **Review** components for boolean prop proliferation and architectural issues
- **Refactor** components with many boolean props into compound components
- **Design** flexible component APIs using composition patterns
- **Optimize** component architecture with state lifting and context providers
- **Audit** component structure for maintainability and scalability

## When To Use

Activate when the user:
- Refactors components with many boolean props (`isOpen`, `isDisabled`, `isLoading`, etc.)
- Builds reusable component libraries
- Designs flexible component APIs
- Reviews component architecture
- Works with compound components, render props, or context providers
- Asks about avoiding prop drilling or boolean prop proliferation
- Needs help with React 19 API changes (forwardRef, useContext)

**Do not activate for:** Non-React code, pure CSS/styling, or backend-only code.

## Rule Categories by Priority

| Priority | Category                | Impact | Prefix          |
| -------- | ----------------------- | ------ | --------------- |
| 1        | Component Architecture  | HIGH   | `architecture-` |
| 2        | State Management        | MEDIUM | `state-`        |
| 3        | Implementation Patterns | MEDIUM | `patterns-`     |
| 4        | React 19 APIs           | MEDIUM | `react19-`      |

## Quick Reference

### 1. Component Architecture (HIGH)

- `architecture-avoid-boolean-props` - Don't add boolean props to customize
  behavior; use composition
- `architecture-compound-components` - Structure complex components with shared
  context

### 2. State Management (MEDIUM)

- `state-decouple-implementation` - Provider is the only place that knows how
  state is managed
- `state-context-interface` - Define generic interface with state, actions, meta
  for dependency injection
- `state-lift-state` - Move state into provider components for sibling access

### 3. Implementation Patterns (MEDIUM)

- `patterns-explicit-variants` - Create explicit variant components instead of
  boolean modes
- `patterns-children-over-render-props` - Use children for composition instead
  of renderX props

### 4. React 19 APIs (MEDIUM)

> **⚠️ React 19+ only.** Skip this section if using React 18 or earlier.

- `react19-no-forwardref` - Don't use `forwardRef`; use `use()` instead of `useContext()`

## File Map

```
SKILL.md             ← you are here (entry point + quick ref)
AGENTS.md            ← full compiled rules for agents (22KB, 947 lines)
rules/
  _sections.md       ← index of all 4 sections with impact levels
  _template.md       ← template for creating new rules
  architecture-*.md  ← Component Architecture (2 rules)
  state-*.md         ← State Management (3 rules)
  patterns-*.md      ← Implementation Patterns (2 rules)
  react19-*.md       ← React 19 APIs (1 rule)
metadata.json         ← document metadata (version, organization, abstract)
```

---

## Agent Workflow

### When reviewing React components

1. Read `AGENTS.md` for full rules (or `rules/<prefix>-*.md` for a specific category)
2. Scan for boolean prop proliferation and architectural issues
3. Report violations grouped by category and severity
4. For each violation: name the rule, explain why, provide the correct pattern

### When writing React components

1. Avoid boolean props — use compound components or explicit variants instead
2. Lift state — move state into provider components for sibling access
3. Define context interfaces — use generic interfaces with state, actions, meta
4. Compose internals — subcomponents access context, not props
5. Prefer children — use children over renderX props for composition

### Output format (review)

```
## Composition Pattern Issues

### [category-rule-name] Category Name — HIGH / MEDIUM
- Code: [offending snippet]
- Issue: [explanation]
- Fix:
  [corrected code using composition pattern]

## Summary
X high, Y medium issues — [overall assessment]
```

---

## How to Use

Read individual rule files for detailed explanations and code examples:

```
rules/architecture-avoid-boolean-props.md
rules/state-context-interface.md
rules/patterns-explicit-variants.md
```

Each rule file contains:
- Brief explanation of why it matters
- Incorrect code example with explanation
- Correct code example with explanation
- Additional context and references

## Full Compiled Document

For the complete guide with all rules expanded: **`AGENTS.md`**
