# PSR-12 Quick Reference

## File Structure

```php
<?php                          // 1. Opening tag
                               // 2. Blank line
declare(strict_types=1);       // 3. Declare
                               // 4. Blank line
namespace App\Services;        // 5. Namespace
                               // 6. Blank line
use App\Models\User;           // 7. Use statements (sorted alphabetically)
use Illuminate\Support\Collection;
                               // 8. Blank line
class UserService              // 9. Class definition
{
```

## Spacing Rules

- 1 space after keywords: `if (`, `foreach (`, `while (`
- No space before `(` in function calls: `doSomething($arg)`
- 1 blank line between methods
- 2 blank lines between class definitions

## Brace Placement

```php
// Classes & methods — brace on NEW line
class Foo
{
    public function bar(): void
    {
    }
}

// Control structures — brace on SAME line
if ($condition) {
    // ...
} elseif ($other) {
    // ...
} else {
    // ...
}
```

## Import Ordering (enforced by Pint)

1. PHP core classes
2. Laravel/Framework classes
3. Third-party packages
4. App classes (alphabetical within group)

```php
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Models\User;
use App\Services\UserService;
```
