#!/usr/bin/env bash
# scripts/new-branch.sh
# Interactive script to create a correctly named Git branch
# Usage: bash skills/git-workflow/scripts/new-branch.sh

set -e

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  🌿 New Branch Creator"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# 1. Select branch type
echo ""
echo "Select branch type:"
echo "  1) feature   — New functionality"
echo "  2) bugfix    — Non-urgent bug fix"
echo "  3) hotfix    — Urgent production fix"
echo "  4) chore     — Maintenance / deps"
echo "  5) refactor  — Code refactoring"
echo "  6) docs      — Documentation only"
echo "  7) release   — Release preparation"
echo ""
read -rp "Enter number (1-7): " TYPE_NUM

case $TYPE_NUM in
  1) TYPE="feature" ;;
  2) TYPE="bugfix" ;;
  3) TYPE="hotfix" ;;
  4) TYPE="chore" ;;
  5) TYPE="refactor" ;;
  6) TYPE="docs" ;;
  7) TYPE="release" ;;
  *) echo "Invalid choice."; exit 1 ;;
esac

# 2. Ticket ID
read -rp "Ticket ID (e.g. AUTH-123, leave blank if none): " TICKET

# 3. Description
read -rp "Short description (e.g. user-login, fix-total-price): " DESC

# Convert spaces to hyphens and lowercase
DESC=$(echo "$DESC" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')

# 4. Build branch name
if [ -n "$TICKET" ]; then
  BRANCH="${TYPE}/${TICKET}-${DESC}"
else
  BRANCH="${TYPE}/${DESC}"
fi

echo ""
echo "Branch name: $BRANCH"
read -rp "Create this branch? (y/n): " CONFIRM

if [[ "$CONFIRM" == "y" ]]; then
  BASE="develop"
  if [[ "$TYPE" == "hotfix" ]]; then
    BASE="main"
  fi

  echo ""
  echo "▶ Switching to $BASE and pulling latest..."
  git checkout "$BASE"
  git pull origin "$BASE"

  echo "▶ Creating branch: $BRANCH"
  git checkout -b "$BRANCH"

  echo ""
  echo "✅ Branch '$BRANCH' created from $BASE"
else
  echo "Cancelled."
fi
