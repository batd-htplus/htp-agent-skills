---
name: vercel-react-best-practices
description: >
  React and Next.js performance optimization guidelines from Vercel Engineering.
  Use when writing, reviewing, or refactoring React/Next.js code to ensure optimal performance patterns.
  Covers: eliminating async waterfalls, bundle size optimization, server-side performance,
  client-side data fetching, re-render optimization, rendering performance, JavaScript performance,
  and advanced patterns.
  Triggers on: React, Next.js, components, pages, data fetching, bundle, performance,
  optimization, waterfall, suspense, memo, useMemo, useEffect, server components, RSC,
  hydration, SSR, SSG, ISR, bundle size, code splitting, dynamic imports.
license: MIT
metadata:
  author: vercel
  version: "1.0.0"
  tags: [react, nextjs, performance, optimization, bundle, server-components]
---

# Vercel React Best Practices — Skill Entry Point

## What This Skill Does

Comprehensive performance optimization guide for React and Next.js applications, maintained by Vercel Engineering. Contains 57 rules across 8 categories, prioritized by impact.

- **Review** code for performance issues and anti-patterns
- **Refactor** existing React/Next.js code to eliminate waterfalls and optimize bundles
- **Design** new components and pages with optimal performance patterns
- **Optimize** bundle size, server-side rendering, and client-side data fetching
- **Audit** re-render patterns, rendering performance, and JavaScript micro-optimizations

## When To Use

Activate when the user:
- Writes, reviews, or refactors React components or Next.js pages
- Implements data fetching (client or server-side)
- Asks about performance optimization, bundle size, or load times
- Mentions async waterfalls, suspense, memoization, or server components
- Works with React hooks, effects, or rendering patterns
- Needs help with Next.js features (SSR, SSG, ISR, RSC)

**Do not activate for:** Non-React frameworks, pure CSS/HTML, or backend-only code without React context.

## Rule Categories by Priority

| Priority | Category | Impact | Prefix |
|----------|----------|--------|--------|
| 1 | Eliminating Waterfalls | CRITICAL | `async-` |
| 2 | Bundle Size Optimization | CRITICAL | `bundle-` |
| 3 | Server-Side Performance | HIGH | `server-` |
| 4 | Client-Side Data Fetching | MEDIUM-HIGH | `client-` |
| 5 | Re-render Optimization | MEDIUM | `rerender-` |
| 6 | Rendering Performance | MEDIUM | `rendering-` |
| 7 | JavaScript Performance | LOW-MEDIUM | `js-` |
| 8 | Advanced Patterns | LOW | `advanced-` |

## Quick Reference

### 1. Eliminating Waterfalls (CRITICAL)

- `async-defer-await` - Move await into branches where actually used
- `async-parallel` - Use Promise.all() for independent operations
- `async-dependencies` - Use better-all for partial dependencies
- `async-api-routes` - Start promises early, await late in API routes
- `async-suspense-boundaries` - Use Suspense to stream content

### 2. Bundle Size Optimization (CRITICAL)

- `bundle-barrel-imports` - Import directly, avoid barrel files
- `bundle-dynamic-imports` - Use next/dynamic for heavy components
- `bundle-defer-third-party` - Load analytics/logging after hydration
- `bundle-conditional` - Load modules only when feature is activated
- `bundle-preload` - Preload on hover/focus for perceived speed

### 3. Server-Side Performance (HIGH)

- `server-auth-actions` - Authenticate server actions like API routes
- `server-cache-react` - Use React.cache() for per-request deduplication
- `server-cache-lru` - Use LRU cache for cross-request caching
- `server-dedup-props` - Avoid duplicate serialization in RSC props
- `server-serialization` - Minimize data passed to client components
- `server-parallel-fetching` - Restructure components to parallelize fetches
- `server-after-nonblocking` - Use after() for non-blocking operations

### 4. Client-Side Data Fetching (MEDIUM-HIGH)

- `client-swr-dedup` - Use SWR for automatic request deduplication
- `client-event-listeners` - Deduplicate global event listeners
- `client-passive-event-listeners` - Use passive listeners for scroll
- `client-localstorage-schema` - Version and minimize localStorage data

### 5. Re-render Optimization (MEDIUM)

- `rerender-defer-reads` - Don't subscribe to state only used in callbacks
- `rerender-memo` - Extract expensive work into memoized components
- `rerender-memo-with-default-value` - Hoist default non-primitive props
- `rerender-dependencies` - Use primitive dependencies in effects
- `rerender-derived-state` - Subscribe to derived booleans, not raw values
- `rerender-derived-state-no-effect` - Derive state during render, not effects
- `rerender-functional-setstate` - Use functional setState for stable callbacks
- `rerender-lazy-state-init` - Pass function to useState for expensive values
- `rerender-simple-expression-in-memo` - Avoid memo for simple primitives
- `rerender-move-effect-to-event` - Put interaction logic in event handlers
- `rerender-transitions` - Use startTransition for non-urgent updates
- `rerender-use-ref-transient-values` - Use refs for transient frequent values

### 6. Rendering Performance (MEDIUM)

- `rendering-animate-svg-wrapper` - Animate div wrapper, not SVG element
- `rendering-content-visibility` - Use content-visibility for long lists
- `rendering-hoist-jsx` - Extract static JSX outside components
- `rendering-svg-precision` - Reduce SVG coordinate precision
- `rendering-hydration-no-flicker` - Use inline script for client-only data
- `rendering-hydration-suppress-warning` - Suppress expected mismatches
- `rendering-activity` - Use Activity component for show/hide
- `rendering-conditional-render` - Use ternary, not && for conditionals
- `rendering-usetransition-loading` - Prefer useTransition for loading state

### 7. JavaScript Performance (LOW-MEDIUM)

- `js-batch-dom-css` - Group CSS changes via classes or cssText
- `js-index-maps` - Build Map for repeated lookups
- `js-cache-property-access` - Cache object properties in loops
- `js-cache-function-results` - Cache function results in module-level Map
- `js-cache-storage` - Cache localStorage/sessionStorage reads
- `js-combine-iterations` - Combine multiple filter/map into one loop
- `js-length-check-first` - Check array length before expensive comparison
- `js-early-exit` - Return early from functions
- `js-hoist-regexp` - Hoist RegExp creation outside loops
- `js-min-max-loop` - Use loop for min/max instead of sort
- `js-set-map-lookups` - Use Set/Map for O(1) lookups
- `js-tosorted-immutable` - Use toSorted() for immutability

### 8. Advanced Patterns (LOW)

- `advanced-event-handler-refs` - Store event handlers in refs
- `advanced-init-once` - Initialize app once per app load
- `advanced-use-latest` - useLatest for stable callback refs

## File Map

```
SKILL.md             ← you are here (entry point + quick ref)
AGENTS.md            ← full compiled rules for agents (80KB, 2935 lines)
rules/
  _sections.md       ← index of all 8 sections with impact levels
  _template.md       ← template for creating new rules
  async-*.md         ← Eliminating Waterfalls (5 rules)
  bundle-*.md         ← Bundle Size Optimization (5 rules)
  server-*.md         ← Server-Side Performance (7 rules)
  client-*.md         ← Client-Side Data Fetching (4 rules)
  rerender-*.md       ← Re-render Optimization (13 rules)
  rendering-*.md      ← Rendering Performance (9 rules)
  js-*.md             ← JavaScript Performance (11 rules)
  advanced-*.md       ← Advanced Patterns (3 rules)
metadata.json         ← document metadata (version, organization, abstract)
```

---

## Agent Workflow

### When reviewing React/Next.js code

1. Read `AGENTS.md` for full rules (or `rules/<prefix>-*.md` for a specific category)
2. Scan for critical violations first: async waterfalls, large bundles, missing memoization
3. Report violations grouped by category and severity
4. For each violation: name the rule, explain why, provide the correct code

### When writing React/Next.js code

1. Start with data fetching — eliminate waterfalls using `Promise.all()` or `better-all`
2. Optimize bundles — use direct imports, `next/dynamic`, defer third-party code
3. Configure server-side — use `React.cache()`, LRU cache, parallel fetching
4. Minimize re-renders — use `memo`, `useMemo`, `useCallback` appropriately
5. Optimize rendering — use `content-visibility`, hoist JSX, prefer ternary over `&&`

### Output format (review)

```
## React Performance Issues

### [category-rule-name] Category Name — CRITICAL / HIGH / MEDIUM
- Code: [offending snippet]
- Issue: [explanation]
- Fix:
  [corrected code]

## Summary
X critical, Y high, Z medium issues — [overall assessment]
```

---

## How to Use

Read individual rule files for detailed explanations and code examples:

```
rules/async-parallel.md
rules/bundle-barrel-imports.md
rules/server-cache-react.md
```

Each rule file contains:
- Brief explanation of why it matters
- Incorrect code example with explanation
- Correct code example with explanation
- Additional context and references

## Full Compiled Document

For the complete guide with all rules expanded: **`AGENTS.md`**
