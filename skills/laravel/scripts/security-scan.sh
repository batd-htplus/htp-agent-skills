#!/usr/bin/env bash
# scripts/security-scan.sh
# Basic security checks for Laravel projects
# Usage: bash skills/laravel-security/scripts/security-scan.sh

set -e

PASS=0
FAIL=0

check() {
  local label="$1"
  local result="$2"
  if [ "$result" == "ok" ]; then
    echo "  ✅ $label"
    PASS=$((PASS + 1))
  else
    echo "  ❌ $label — $result"
    FAIL=$((FAIL + 1))
  fi
}

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  🔒 Laravel Security Scan"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# 1. Check .env is gitignored
echo ""
echo "▶ [1] Environment files..."
if grep -q "^\.env$" .gitignore 2>/dev/null; then
  check ".env is in .gitignore" "ok"
else
  check ".env is in .gitignore" ".env is NOT gitignored — add it!"
fi

if [ -f ".env" ] && git ls-files --error-unmatch .env > /dev/null 2>&1; then
  check ".env not tracked by git" ".env IS tracked by git — run: git rm --cached .env"
else
  check ".env not tracked by git" "ok"
fi

# 2. Check APP_DEBUG
echo ""
echo "▶ [2] APP_DEBUG setting..."
if grep -q "APP_DEBUG=false" .env 2>/dev/null || [ ! -f ".env" ]; then
  check "APP_DEBUG is false (or no .env)" "ok"
else
  if grep -q "APP_DEBUG=true" .env; then
    check "APP_DEBUG" "APP_DEBUG=true in .env (OK for local, not production)"
  fi
fi

# 3. Check for raw SQL concatenation
echo ""
echo "▶ [3] SQL injection patterns..."
if grep -rn --include="*.php" "DB::select(\"" app/ 2>/dev/null | grep -v "?" | grep -qv "placeholder"; then
  check "No raw SQL concatenation" "Potential SQL injection found — review DB::select() calls"
else
  check "No raw SQL concatenation" "ok"
fi

# 4. Check for $guarded = []
echo ""
echo "▶ [4] Mass assignment protection..."
if grep -rn --include="*.php" 'guarded\s*=\s*\[\]' app/Models/ 2>/dev/null | grep -q .; then
  check "No \$guarded = []" "Found \$guarded = [] in models — use \$fillable instead"
else
  check "No \$guarded = []" "ok"
fi

# 5. Check for composer audit
echo ""
echo "▶ [5] Dependency vulnerabilities..."
if command -v composer > /dev/null 2>&1; then
  if composer audit --no-dev 2>&1 | grep -q "No security vulnerability advisories found"; then
    check "No known vulnerabilities" "ok"
  else
    check "Dependency vulnerabilities" "Run: composer audit"
  fi
else
  echo "  ⚠️  composer not found — skipping audit"
fi

# 6. Check for sensitive data in logs pattern
echo ""
echo "▶ [6] Sensitive data in logs..."
if grep -rn --include="*.php" -E "Log::(info|debug|warning|error)\(.*password" app/ 2>/dev/null | grep -q .; then
  check "No password logging" "Possible password in logs — review Log:: calls"
else
  check "No password logging" "ok"
fi

# Summary
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Results: $PASS passed, $FAIL failed"
if [ $FAIL -gt 0 ]; then
  echo "  ❌ Security issues found!"
  exit 1
else
  echo "  ✅ All security checks passed!"
fi
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
