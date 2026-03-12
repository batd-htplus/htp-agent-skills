---
title: Job Implementation Pattern
impact: HIGH
impactDescription: Follow the standard Job pattern with proper retry logic, timeout, and error handling.
tags: performance, jobs, queues, error-handling
---

## Job Implementation Pattern

Follow the standard Job pattern with proper retry logic, timeout, and error handling.

**Why it matters:** Proper job configuration ensures reliability, prevents infinite retries, and handles failures gracefully.

**✅ Correct Pattern:**

```php
<?php

declare(strict_types=1);

namespace App\Jobs;

use App\Models\Order;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Facades\Log;
use Throwable;

class SendOrderConfirmationJob implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    public int $tries   = 3;         // Retry up to 3 times
    public int $backoff = 60;        // Wait 60s between retries
    public int $timeout = 120;       // Max execution time

    public function __construct(private readonly Order $order) {}

    public function handle(MailService $mailService): void
    {
        $mailService->sendOrderConfirmation($this->order);
    }

    public function failed(Throwable $exception): void
    {
        Log::error('Order confirmation email failed', [
            'order_id' => $this->order->id,
            'error'    => $exception->getMessage(),
        ]);

        // Optionally: notify admin or create alert
    }
}
```

**See also:** `perf-queue-heavy-tasks.md`, `perf-queue-priorities.md`
