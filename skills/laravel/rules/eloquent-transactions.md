---
title: Transactions for Multi-Step Writes
impact: MEDIUM
impactDescription: Wrap any operation that writes to multiple tables in a transaction to ensure data consistency.
tags: database, transactions, consistency
---

## Transactions for Multi-Step Writes

Wrap any operation that writes to multiple tables in a transaction to ensure data consistency.

**Why it matters:** Transactions ensure all-or-nothing execution. If any step fails, all changes are rolled back, preventing partial updates.

**❌ Incorrect:**

```php
public function createOrder(array $data): Order
{
    $order = $this->orderRepository->create($data);

    foreach ($data['items'] as $item) {
        $order->items()->create($item);
    }

    $this->inventoryService->decrementStock($data['items']);
    event(new OrderCreated($order));

    return $order;
    // If any step fails, partial data remains!
}
```

**✅ Correct:**

```php
use Illuminate\Support\Facades\DB;

public function createOrder(array $data): Order
{
    return DB::transaction(function () use ($data): Order {
        $order = $this->orderRepository->create($data);

        foreach ($data['items'] as $item) {
            $order->items()->create($item);
        }

        $this->inventoryService->decrementStock($data['items']);
        event(new OrderCreated($order));

        return $order;
    });
}
```

**See also:** `eloquent-prevent-n-plus-one.md`, `perf-queue-heavy-tasks.md`
