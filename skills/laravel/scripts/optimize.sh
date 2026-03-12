#!/usr/bin/env bash
# scripts/optimize.sh
# Run all Laravel production optimization commands
# Usage: bash skills/laravel-performance/scripts/optimize.sh

set -e

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  🚀 Laravel Production Optimizer"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

echo "▶ [1/6] Clearing all caches..."
php artisan optimize:clear
echo "  ✅ Cleared"

echo ""
echo "▶ [2/6] Caching configuration..."
php artisan config:cache
echo "  ✅ config cached"

echo ""
echo "▶ [3/6] Caching routes..."
php artisan route:cache
echo "  ✅ routes cached"

echo ""
echo "▶ [4/6] Caching views..."
php artisan view:cache
echo "  ✅ views cached"

echo ""
echo "▶ [5/6] Caching events..."
php artisan event:cache
echo "  ✅ events cached"

echo ""
echo "▶ [6/6] Running pending migrations..."
php artisan migrate --force
echo "  ✅ migrations applied"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  ✅ Production optimization complete!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
