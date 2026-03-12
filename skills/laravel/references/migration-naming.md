# Migration Naming Conventions

## Format

```
{timestamp}_{action}_{target}_table.php
```

## Actions

| Action | When to use | Example |
|---|---|---|
| `create` | Create a new table | `create_users_table` |
| `add` | Add columns to existing table | `add_avatar_url_to_users_table` |
| `remove` | Remove columns | `remove_phone_from_users_table` |
| `rename` | Rename column or table | `rename_name_to_full_name_in_users_table` |
| `update` | Modify column type/length | `update_body_column_in_posts_table` |
| `drop` | Drop a table | `drop_password_resets_table` |

## Examples

```bash
php artisan make:migration create_users_table
php artisan make:migration add_avatar_url_to_users_table
php artisan make:migration add_stripe_customer_id_to_users_table
php artisan make:migration remove_phone_from_users_table
php artisan make:migration create_order_items_table
php artisan make:migration add_index_to_orders_user_id
```
