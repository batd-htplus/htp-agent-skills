# Conventional Commits Cheatsheet

## Format
```
<type>(<scope>): <subject>
```

## Types Quick Reference

| Type | Emoji | Description |
|---|---|---|
| `feat` | ✨ | New feature |
| `fix` | 🐛 | Bug fix |
| `docs` | 📝 | Documentation |
| `style` | 💄 | Formatting only |
| `refactor` | ♻️ | Refactoring |
| `perf` | ⚡ | Performance |
| `test` | ✅ | Tests |
| `chore` | 🔧 | Maintenance |
| `ci` | 👷 | CI/CD |
| `revert` | ⏪ | Revert |

## Scope Examples (use your domain)

`auth`, `user`, `order`, `payment`, `api`, `db`, `cache`, `queue`, `config`, `deps`

## Real Examples

```
feat(auth): add Google OAuth login
fix(order): prevent duplicate order creation on double click
perf(query): add composite index on orders(user_id, status)
test(payment): add unit tests for PaymentService
chore(deps): upgrade sanctum to 3.3
ci(github): add PHP 8.2 to test matrix
docs(readme): add local development setup guide
refactor(user): extract address logic to AddressService

# Breaking change
feat(api)!: remove deprecated v1 endpoints

BREAKING CHANGE: /api/v1/auth/me is removed. Use /api/v2/profile instead.
```

## Install as Git Hook

```bash
cp skills/git-workflow/scripts/commit-check.sh .git/hooks/commit-msg
chmod +x .git/hooks/commit-msg
```
