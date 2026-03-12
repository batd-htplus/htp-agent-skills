#!/usr/bin/env bash
# scripts/run-tests.sh
# Run tests with coverage report
# Usage: bash scripts/run-tests.sh [--unit|--feature|--filter=ClassName]

set -e

ARGS="${*}"
MIN_COVERAGE=80

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  🧪 Laravel Test Runner"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Check if pest is available
if [ -f "./vendor/bin/pest" ]; then
  RUNNER="./vendor/bin/pest"
else
  RUNNER="./vendor/bin/phpunit"
fi

echo "▶ Runner: $RUNNER"
echo "▶ Min coverage: $MIN_COVERAGE%"
echo ""

$RUNNER \
  --coverage \
  --coverage-html=coverage-report \
  --min=$MIN_COVERAGE \
  $ARGS

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  ✅ Tests passed!"
echo "  📊 Coverage report: coverage-report/index.html"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
