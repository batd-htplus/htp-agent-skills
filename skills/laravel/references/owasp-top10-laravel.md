# OWASP Top 10 — Laravel Mitigations

| # | Vulnerability | Laravel Mitigation |
|---|---|---|
| A01 | Broken Access Control | Use Policies + `$this->authorize()`. Never manual `if` checks in controllers. |
| A02 | Cryptographic Failures | Use `encrypt()`/`decrypt()`. Never store passwords plain. Use `bcrypt`/`argon2`. |
| A03 | Injection | Always use Eloquent or Query Builder. Never concatenate SQL strings. |
| A04 | Insecure Design | Repository + Service pattern. FormRequest validation. Never trust user input. |
| A05 | Security Misconfiguration | `APP_DEBUG=false` in prod. Never expose `.env`. Set CORS correctly. |
| A06 | Vulnerable Components | Run `composer audit` weekly. Use Dependabot. |
| A07 | Auth Failures | Sanctum tokens with expiry. Rate limit auth routes. Lock accounts on failure. |
| A08 | Data Integrity Failures | Validate all input. Use signed URLs for downloads. Verify webhooks. |
| A09 | Logging Failures | Log all auth events. Never log passwords/tokens. Use structured JSON logs. |
| A10 | SSRF | Validate URLs before HTTP requests. Whitelist allowed domains. |

## Quick Security Audit

```bash
# Check for known vulnerabilities in dependencies
composer audit

# Check for outdated packages
composer outdated

# Run security scan
bash skills/laravel-security/scripts/security-scan.sh
```
