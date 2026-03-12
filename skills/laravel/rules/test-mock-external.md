---
title: Mock External Services
impact: MEDIUM
impactDescription: Never call real external APIs in tests. Mock HTTP calls, emails, queues, and notifications.
tags: testing, mocking, external-services, isolation
---

## Mock External Services

Never call real external APIs in tests. Mock HTTP calls, emails, queues, and notifications.

**Why it matters:** Mocking external services makes tests faster, more reliable, and prevents side effects.

**❌ Incorrect:**

```php
// Calls real Stripe API - slow, unreliable, may cost money
$response = Http::post('https://api.stripe.com/v1/charges', [...]);
```

**✅ Correct:**

```php
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Queue;
use Illuminate\Support\Facades\Notification;

// Mock HTTP calls
Http::fake([
    'api.stripe.com/*' => Http::response(['id' => 'ch_test_123'], 200),
]);

// Assert emails were sent
Mail::fake();
Mail::assertSent(WelcomeEmail::class, fn ($mail) => $mail->hasTo($user->email));

// Assert jobs were queued
Queue::fake();
Queue::assertPushed(SendNewsletterJob::class);

// Assert notifications
Notification::fake();
Notification::assertSentTo($user, OrderConfirmationNotification::class);
```

**See also:** `test-unit-pattern.md`, `perf-queue-heavy-tasks.md`
