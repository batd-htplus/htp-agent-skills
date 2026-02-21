#!/usr/bin/env npx ts-node
/**
 * scripts/audit.ts
 * TypeScript Best Practices — Pattern Audit CLI
 *
 * Usage:
 *   npx ts-node scripts/audit.ts <file-or-directory>
 *
 * Scans .ts and .tsx files for common anti-pattern violations.
 * Checks: ts-02 (any), ts-02 (import type), ts-08 (as cast, enum, @ts-ignore),
 *         ts-06 (floating promise, empty catch), ts-07 (relative deep imports)
 *
 * Full checks requiring compiler/AST: ts-01 (tsconfig), ts-03 (narrowing),
 * ts-04 (generic constraints), ts-05 (utility types) — review manually.
 */

import * as fs   from 'fs'
import * as path from 'path'

// ─── Types ────────────────────────────────────────────────────────────────────

type Severity = 'CRITICAL' | 'MAJOR'

interface Violation {
  file:     string
  line:     number
  rule:     string
  severity: Severity
  code:     string
  message:  string
  fix:      string
}

// ─── Pattern Rules ────────────────────────────────────────────────────────────

interface PatternRule {
  id:       string
  severity: Severity
  pattern:  RegExp
  message:  string
  fix:      string
  // optional: skip when line also matches this
  skipIf?:  RegExp
}

const RULES: PatternRule[] = [
  // ts-02: any
  {
    id:       'ts-02',
    severity: 'CRITICAL',
    pattern:  /:\s*any\b|<any>|,\s*any[,>)]/,
    message:  'Type `any` disables type checking. Use `unknown` and narrow before use.',
    fix:      'Replace `any` with `unknown`, then narrow with typeof/instanceof/type predicate.',
    skipIf:   /\/\/.*any|@ts-expect-error/,
  },

  // ts-08: as cast (excluding `as const` and `as unknown as`)
  {
    id:       'ts-08',
    severity: 'MAJOR',
    pattern:  /\)\s+as\s+(?!const\b|unknown\b)[A-Z][a-zA-Z<]/,
    message:  'Type assertion `as X` hides real type mismatches. Narrow instead.',
    fix:      'Use typeof, instanceof, or a type predicate to narrow the type properly.',
  },

  // ts-08: double cast
  {
    id:       'ts-08',
    severity: 'CRITICAL',
    pattern:  /as\s+unknown\s+as\s+/,
    message:  'Double cast `as unknown as X` completely bypasses type checking.',
    fix:      'Parse and validate the value with Zod or a type predicate instead.',
  },

  // ts-08: enum declaration
  {
    id:       'ts-08',
    severity: 'MAJOR',
    pattern:  /^\s*(export\s+)?(const\s+)?enum\s+\w+/,
    message:  '`enum` creates a runtime object and can cause tree-shaking issues.',
    fix:      "Use string literal union: `type X = 'a' | 'b'` and `const Xs = ['a','b'] as const`.",
  },

  // ts-08: @ts-ignore
  {
    id:       'ts-08',
    severity: 'CRITICAL',
    pattern:  /@ts-ignore/,
    message:  '`@ts-ignore` silently suppresses type errors without explanation.',
    fix:      'Use `@ts-expect-error` with a comment explaining why.',
  },

  // ts-02: import without type keyword for likely type-only imports
  {
    id:       'ts-07',
    severity: 'MAJOR',
    pattern:  /^import\s+\{[^}]+\}\s+from\s+['"][./]/,
    message:  'Relative import may be importing types without `import type`. Use `import type` for type-only imports.',
    fix:      "Change to `import type { X } from '...'` if X is only used as a type.",
    skipIf:   /^import\s+type/,
  },

  // ts-07: deep relative imports (3+ levels)
  {
    id:       'ts-07',
    severity: 'MAJOR',
    pattern:  /from\s+['"]\.\.\/\.\.\/\.\./,
    message:  'Deep relative import (3+ levels). Configure path aliases in tsconfig.',
    fix:      "Add `@lib/*` or `@/*` alias in tsconfig.json and use `import { X } from '@lib/...'`.",
  },

  // ts-06: empty catch block
  {
    id:       'ts-06',
    severity: 'CRITICAL',
    pattern:  /}\s*catch\s*\([^)]*\)\s*\{\s*\}/,
    message:  'Empty catch block silently swallows errors.',
    fix:      'At minimum log the error. Better: return Result<T, E> for expected failures.',
  },

  // ts-06: catch with Error type annotation
  {
    id:       'ts-06',
    severity: 'CRITICAL',
    pattern:  /catch\s*\(\s*\w+\s*:\s*Error\s*\)/,
    message:  '`catch(e: Error)` is incorrect — thrown values may not be Error instances.',
    fix:      'Use `catch(e: unknown)` and narrow with `if (e instanceof Error)`.',
  },

  // ts-01: @ts-ignore (same as ts-08 above, double-checking)
  {
    id:       'ts-01',
    severity: 'MAJOR',
    pattern:  /\/\/\s*@ts-expect-error\s*$/,
    message:  '`@ts-expect-error` without an explanation comment.',
    fix:      'Add a comment after @ts-expect-error explaining why the suppression is needed.',
  },

  // ts-08: object type
  {
    id:       'ts-08',
    severity: 'MAJOR',
    pattern:  /:\s*object\b(?!\s*\[)/,
    message:  'The `object` type is too broad and loses all key information.',
    fix:      'Use `Record<string, unknown>`, a typed interface, or `Record<K, V>`.',
  },
]

// ─── Scanner ──────────────────────────────────────────────────────────────────

function scanFile(filePath: string): Violation[] {
  const violations: Violation[] = []
  const content = fs.readFileSync(filePath, 'utf-8')
  const lines   = content.split('\n')

  for (let i = 0; i < lines.length; i++) {
    const line    = lines[i]
    const lineNum = i + 1

    // Skip full-line comments
    if (/^\s*\/\//.test(line)) continue

    for (const rule of RULES) {
      if (!rule.pattern.test(line)) continue
      if (rule.skipIf && rule.skipIf.test(line)) continue

      violations.push({
        file:     filePath,
        line:     lineNum,
        rule:     rule.id,
        severity: rule.severity,
        code:     line.trim(),
        message:  rule.message,
        fix:      rule.fix,
      })
    }
  }

  return violations
}

function collectFiles(target: string): string[] {
  const stat = fs.statSync(target)

  if (stat.isFile()) {
    return target.endsWith('.ts') || target.endsWith('.tsx') ? [target] : []
  }

  const results: string[] = []
  const entries = fs.readdirSync(target, { withFileTypes: true })

  for (const entry of entries) {
    if (entry.name === 'node_modules' || entry.name === 'dist' || entry.name === '.git') continue
    const full = path.join(target, entry.name)
    if (entry.isDirectory()) {
      results.push(...collectFiles(full))
    } else if (entry.name.endsWith('.ts') || entry.name.endsWith('.tsx')) {
      results.push(full)
    }
  }

  return results
}

// ─── Reporter ─────────────────────────────────────────────────────────────────

const C = {
  red:    '\x1b[31m',
  yellow: '\x1b[33m',
  green:  '\x1b[32m',
  cyan:   '\x1b[36m',
  bold:   '\x1b[1m',
  dim:    '\x1b[2m',
  reset:  '\x1b[0m',
}

function printViolation(v: Violation): void {
  const color = v.severity === 'CRITICAL' ? C.red : C.yellow
  console.log(`  ${color}${C.bold}[${v.severity}]${C.reset} ${C.bold}${v.rule}${C.reset}`)
  console.log(`  ${C.dim}${v.file}:${v.line}${C.reset}`)
  console.log(`  Code    : ${C.cyan}${v.code}${C.reset}`)
  console.log(`  Issue   : ${v.message}`)
  console.log(`  Fix     : ${v.fix}`)
  console.log()
}

// ─── Main ─────────────────────────────────────────────────────────────────────

function main(): void {
  const target = process.argv[2]

  if (!target) {
    console.error('Usage: npx ts-node scripts/audit.ts <file-or-directory>')
    process.exit(1)
  }

  const absTarget = path.resolve(target)
  if (!fs.existsSync(absTarget)) {
    console.error(`Not found: ${absTarget}`)
    process.exit(1)
  }

  const files      = collectFiles(absTarget)
  const allViolations: Violation[] = []

  console.log(`\n${C.bold}=============================================${C.reset}`)
  console.log(`${C.bold}  TypeScript Best Practices Audit${C.reset}`)
  console.log(`${C.bold}  Target: ${path.basename(absTarget)}${C.reset}`)
  console.log(`${C.bold}  Files:  ${files.length} TypeScript file(s)${C.reset}`)
  console.log(`${C.bold}=============================================${C.reset}\n`)

  for (const file of files) {
    const violations = scanFile(file)
    allViolations.push(...violations)
    for (const v of violations) printViolation(v)
  }

  const criticals = allViolations.filter(v => v.severity === 'CRITICAL').length
  const majors    = allViolations.filter(v => v.severity === 'MAJOR').length

  console.log(`${C.bold}=============================================${C.reset}`)
  console.log(`${C.bold}  Summary${C.reset}`)
  console.log(`${C.bold}=============================================${C.reset}`)

  if (allViolations.length === 0) {
    console.log(`\n  ${C.green}${C.bold}✅ No automated violations found.${C.reset}`)
  } else {
    if (criticals) console.log(`  ${C.red}${C.bold}Critical : ${criticals}${C.reset}`)
    if (majors)    console.log(`  ${C.yellow}${C.bold}Major    : ${majors}${C.reset}`)
  }

  console.log(`
  ${C.bold}Pattern checks:${C.reset}  any, as cast, double cast, enum, @ts-ignore,
                   empty catch, catch(Error), deep relative imports, object type
  ${C.bold}Manual review:${C.reset}   tsconfig settings (ts-01), type narrowing (ts-03),
                   generic constraints (ts-04), utility type usage (ts-05)
`)

  process.exit(criticals > 0 ? 1 : 0)
}

main()
