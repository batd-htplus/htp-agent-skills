#!/usr/bin/env bash
# scripts/commit-check.sh
# Validates commit message follows Conventional Commits
# Usage: bash commit-check.sh "your commit message"
# Or install as git hook: cp commit-check.sh .git/hooks/commit-msg

COMMIT_MSG="$1"

# If used as git hook, read from file
if [ -z "$COMMIT_MSG" ] && [ -f "$1" ]; then
  COMMIT_MSG=$(cat "$1")
fi

if [ -z "$COMMIT_MSG" ]; then
  echo "Usage: $0 'commit message'"
  exit 1
fi

PATTERN='^(feat|fix|docs|style|refactor|perf|test|chore|ci|revert)(\([a-z0-9_-]+\))?(!)?: .{1,72}$'

if echo "$COMMIT_MSG" | grep -qE "$PATTERN"; then
  echo "✅ Commit message is valid"
  exit 0
else
  echo ""
  echo "❌ Invalid commit message format!"
  echo ""
  echo "Expected: <type>(<scope>): <subject>"
  echo "Example:  feat(auth): add user login endpoint"
  echo ""
  echo "Valid types: feat, fix, docs, style, refactor, perf, test, chore, ci, revert"
  echo "Subject: max 72 chars, present tense, no period at end"
  echo ""
  exit 1
fi
