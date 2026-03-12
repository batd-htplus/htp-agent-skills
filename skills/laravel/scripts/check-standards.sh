#!/usr/bin/env bash
# scripts/check-standards.sh
# Run all code quality checks for Laravel coding standards
# Usage: bash scripts/check-standards.sh [--fix]

set -e

FIX=false
if [[ "$1" == "--fix" ]]; then
  FIX=true
fi

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Laravel Code Standards Check"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# 1. Laravel Pint (PSR-12)
echo ""
echo "▶ [1/4] Running Laravel Pint (PSR-12)..."
if $FIX; then
  ./vendor/bin/pint && echo "✅ Pint: Fixed"
else
  ./vendor/bin/pint --test && echo "✅ Pint: OK"
fi

# 2. PHPStan Static Analysis
echo ""
echo "▶ [2/4] Running PHPStan (level 8)..."
./vendor/bin/phpstan analyse --level=8 --no-progress && echo "✅ PHPStan: OK"

# 3. Check for debug code
echo ""
echo "▶ [3/4] Checking for debug code..."
DEBUG_PATTERN='dd\(|dump\(|var_dump\(|print_r\(|ray\(|die\(|exit\('
if grep -rn --include="*.php" -E "$DEBUG_PATTERN" app/ ; then
  echo "❌ Debug code found! Remove before committing."
  exit 1
else
  echo "✅ No debug code found"
fi

# 4. Check for missing strict_types
echo ""
echo "▶ [4/4] Checking declare(strict_types=1)..."
MISSING=0
while IFS= read -r -d '' file; do
  if ! grep -q "declare(strict_types=1)" "$file"; then
    echo "  ❌ Missing strict_types: $file"
    MISSING=$((MISSING + 1))
  fi
done < <(find app/ -name "*.php" -print0)

if [ $MISSING -gt 0 ]; then
  echo "❌ $MISSING file(s) missing declare(strict_types=1)"
  exit 1
else
  echo "✅ All files have strict_types"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  ✅ All checks passed!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
