---
name: vercel-react-native-skills
description: >
  React Native and Expo best practices for building performant mobile apps.
  Use when building React Native components, optimizing list performance,
  implementing animations, or working with native modules.
  Covers: list performance (FlashList, memoization), animations (Reanimated),
  navigation (native navigators), UI patterns (expo-image, Pressable),
  state management (Zustand, React Compiler), rendering, monorepo structure,
  and platform-specific optimizations.
  Triggers on: React Native, Expo, mobile, performance, FlashList, FlatList,
  Reanimated, animation, gesture, navigation, expo-image, Pressable,
  TouchableOpacity, native modules, iOS, Android, monorepo, Zustand.
license: MIT
metadata:
  author: vercel
  version: '1.0.0'
  tags: [react-native, expo, mobile, performance, animation, navigation]
---

# React Native Skills — Skill Entry Point

## What This Skill Does

Comprehensive best practices for React Native and Expo applications. Contains rules across multiple categories covering performance, animations, UI patterns, and platform-specific optimizations.

- **Review** React Native code for performance issues and anti-patterns
- **Refactor** components to optimize list performance and animations
- **Design** new components following React Native best practices
- **Optimize** list rendering, animations, navigation, and image handling
- **Audit** state management, rendering patterns, and monorepo structure

## When To Use

Activate when the user:
- Builds React Native or Expo apps
- Optimizes list and scroll performance
- Implements animations with Reanimated
- Works with images, media, or native modules
- Configures fonts, navigation, or monorepo structure
- Asks about FlashList, FlatList, Reanimated, expo-image, or Pressable
- Needs help with iOS/Android platform-specific optimizations

**Do not activate for:** Web-only React code, pure JavaScript, or backend code without React Native context.

## Rule Categories by Priority

| Priority | Category         | Impact   | Prefix               |
| -------- | ---------------- | -------- | -------------------- |
| 1        | List Performance | CRITICAL | `list-performance-`  |
| 2        | Animation        | HIGH     | `animation-`         |
| 3        | Navigation       | HIGH     | `navigation-`        |
| 4        | UI Patterns      | HIGH     | `ui-`                |
| 5        | State Management | MEDIUM   | `react-state-`       |
| 6        | Rendering        | MEDIUM   | `rendering-`         |
| 7        | Monorepo         | MEDIUM   | `monorepo-`          |
| 8        | Configuration    | LOW      | `fonts-`, `imports-` |

## Quick Reference

### 1. List Performance (CRITICAL)

- `list-performance-virtualize` - Use FlashList for large lists
- `list-performance-item-memo` - Memoize list item components
- `list-performance-callbacks` - Stabilize callback references
- `list-performance-inline-objects` - Avoid inline style objects
- `list-performance-function-references` - Extract functions outside render
- `list-performance-images` - Optimize images in lists
- `list-performance-item-expensive` - Move expensive work outside items
- `list-performance-item-types` - Use item types for heterogeneous lists

### 2. Animation (HIGH)

- `animation-gpu-properties` - Animate only transform and opacity
- `animation-derived-value` - Use useDerivedValue for computed animations
- `animation-gesture-detector-press` - Use Gesture.Tap instead of Pressable

### 3. Navigation (HIGH)

- `navigation-native-navigators` - Use native stack and native tabs over JS navigators

### 4. UI Patterns (HIGH)

- `ui-expo-image` - Use expo-image for all images
- `ui-image-gallery` - Use Galeria for image lightboxes
- `ui-pressable` - Use Pressable over TouchableOpacity
- `ui-safe-area-scroll` - Handle safe areas in ScrollViews
- `ui-scrollview-content-inset` - Use contentInset for headers
- `ui-menus` - Use native context menus
- `ui-native-modals` - Use native modals when possible
- `ui-measure-views` - Use onLayout, not measure()
- `ui-styling` - Use StyleSheet.create or Nativewind

### 5. State Management (MEDIUM)

- `react-state-minimize` - Minimize state subscriptions
- `react-state-dispatcher` - Use dispatcher pattern for callbacks
- `react-state-fallback` - Show fallback on first render
- `react-compiler-destructure-functions` - Destructure for React Compiler
- `react-compiler-reanimated-shared-values` - Handle shared values with compiler

### 6. Rendering (MEDIUM)

- `rendering-text-in-text-component` - Wrap text in Text components
- `rendering-no-falsy-and` - Avoid falsy && for conditional rendering

### 7. Monorepo (MEDIUM)

- `monorepo-native-deps-in-app` - Keep native dependencies in app package
- `monorepo-single-dependency-versions` - Use single versions across packages

### 8. Configuration (LOW)

- `fonts-config-plugin` - Use config plugins for custom fonts
- `imports-design-system-folder` - Organize design system imports
- `js-hoist-intl` - Hoist Intl object creation

## File Map

```
SKILL.md             ← you are here (entry point + quick ref)
AGENTS.md            ← full compiled rules for agents (72KB, 2898 lines)
rules/
  _sections.md       ← index of all 8 sections with impact levels
  _template.md       ← template for creating new rules
  list-performance-*.md  ← List Performance (9 rules)
  animation-*.md          ← Animation (3 rules)
  navigation-*.md        ← Navigation (1 rule)
  ui-*.md                ← UI Patterns (9 rules)
  react-state-*.md       ← State Management (5 rules)
  rendering-*.md         ← Rendering (2 rules)
  monorepo-*.md          ← Monorepo (2 rules)
  fonts-*.md, imports-*.md, js-*.md  ← Configuration (3 rules)
metadata.json         ← document metadata (version, organization, abstract)
```

---

## Agent Workflow

### When reviewing React Native code

1. Read `AGENTS.md` for full rules (or `rules/<prefix>-*.md` for a specific category)
2. Scan for critical violations first: list performance issues, non-GPU animations, JS navigators
3. Report violations grouped by category and severity
4. For each violation: name the rule, explain why, provide the correct code

### When writing React Native code

1. Start with lists — use FlashList for large lists, memoize items, stabilize callbacks
2. Optimize animations — use Reanimated, animate only transform/opacity, use useDerivedValue
3. Choose navigation — prefer native stack/tabs over JS navigators
4. Handle images — use expo-image, implement lazy loading and caching
5. Manage state — minimize subscriptions, use Zustand patterns, handle React Compiler

### Output format (review)

```
## React Native Issues

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
rules/list-performance-virtualize.md
rules/animation-gpu-properties.md
rules/ui-expo-image.md
```

Each rule file contains:
- Brief explanation of why it matters
- Incorrect code example with explanation
- Correct code example with explanation
- Additional context and references

## Full Compiled Document

For the complete guide with all rules expanded: **`AGENTS.md`**
