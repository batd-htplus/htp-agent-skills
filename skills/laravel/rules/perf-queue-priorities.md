---
title: Queue Priorities Configuration
impact: MEDIUM
impactDescription: Configure named queues with priorities to ensure critical jobs are processed first.
tags: performance, queues, priorities, configuration
---

## Queue Priorities Configuration

Configure named queues with priorities to ensure critical jobs are processed first.

**Why it matters:** Queue priorities ensure important tasks (payments, critical notifications) are processed before less urgent tasks (emails, reports).

**Define named queues in `config/queue.php`:**

```php
// config/queue.php — define named queues with priorities
```

**Start worker with priority order:**

```bash
php artisan queue:work --queue=critical,high,default,low,emails
```

**Dispatch to appropriate queue:**

```php
SendOrderConfirmationJob::dispatch($order)->onQueue('emails');
ProcessPaymentJob::dispatch($payment)->onQueue('critical');
GenerateReportJob::dispatch($params)->onQueue('low');
```

**See also:** `perf-job-pattern.md`, `perf-queue-heavy-tasks.md`
