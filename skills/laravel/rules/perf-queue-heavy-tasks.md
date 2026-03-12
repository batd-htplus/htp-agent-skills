---
title: Heavy Tasks Must Go to Queue
impact: CRITICAL
impactDescription: Heavy operations (emails, file processing, API syncs) MUST be dispatched to a queue, never run synchronously in a request.
tags: performance, queues, background-jobs, async
---

## Heavy Tasks Must Go to Queue

The following operations MUST be dispatched to a queue — never run synchronously in a request:

- Sending emails / SMS / push notifications
- Processing uploaded files / images
- Generating reports or exports
- Syncing data with third-party APIs
- Sending webhooks

**Why it matters:** Heavy tasks block HTTP responses, causing slow API responses and poor user experience.

**❌ Incorrect:**

```php
// Blocks the HTTP response
public function store(StoreOrderRequest $request): JsonResponse
{
    $order = $this->orderService->create($request->validated());
    Mail::to($order->user)->send(new OrderConfirmation($order)); // Slow!

    return response()->json(['success' => true, 'data' => new OrderResource($order)], 201);
}
```

**✅ Correct:**

```php
// Dispatch to queue
public function store(StoreOrderRequest $request): JsonResponse
{
    $order = $this->orderService->create($request->validated());
    SendOrderConfirmationJob::dispatch($order)->onQueue('emails');

    return response()->json(['success' => true, 'data' => new OrderResource($order)], 201);
}
```

**See also:** `perf-job-pattern.md`, `test-mock-external.md`
