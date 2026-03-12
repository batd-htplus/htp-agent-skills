# Laravel Test Assertion Cheatsheet

## HTTP Status Assertions

```php
$response->assertOk();               // 200
$response->assertCreated();          // 201
$response->assertNoContent();        // 204
$response->assertBadRequest();       // 400
$response->assertUnauthorized();     // 401
$response->assertForbidden();        // 403
$response->assertNotFound();         // 404
$response->assertUnprocessable();    // 422
$response->assertTooManyRequests();  // 429
$response->assertServerError();      // 500
$response->assertStatus(302);        // Custom
```

## JSON Assertions

```php
// Structure check
$response->assertJsonStructure([
    'success',
    'data' => ['id', 'name', 'email'],
]);

// Exact value check
$response->assertJsonPath('success', true);
$response->assertJsonPath('data.email', 'test@example.com');

// Count check
$response->assertJsonCount(5, 'data.items');

// Contains subset
$response->assertJsonFragment(['email' => 'test@example.com']);

// Missing key
$response->assertJsonMissingPath('data.password');
```

## Database Assertions

```php
$this->assertDatabaseHas('users', ['email' => 'test@example.com']);
$this->assertDatabaseMissing('users', ['email' => 'deleted@example.com']);
$this->assertDatabaseCount('users', 5);
$this->assertSoftDeleted('users', ['id' => 1]);
$this->assertNotSoftDeleted('users', ['id' => 2]);
```

## Event / Job / Mail Assertions

```php
Event::fake();
Event::assertDispatched(UserRegistered::class);
Event::assertNotDispatched(OrderCancelled::class);
Event::assertDispatched(UserRegistered::class, fn ($e) => $e->user->id === 1);

Queue::fake();
Queue::assertPushed(SendNewsletterJob::class);
Queue::assertPushedOn('emails', SendOrderConfirmationJob::class);
Queue::assertNothingPushed();

Mail::fake();
Mail::assertSent(WelcomeEmail::class);
Mail::assertSent(WelcomeEmail::class, fn ($m) => $m->hasTo('test@example.com'));
Mail::assertNothingSent();

Notification::fake();
Notification::assertSentTo($user, OrderConfirmationNotification::class);
```
