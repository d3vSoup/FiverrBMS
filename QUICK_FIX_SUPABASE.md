# Quick Fix for Cart and Wishlist Issues

## The Problem
The errors "Failed to add to cart" and "Failed to update wishlist" are likely caused by:

1. **RLS (Row Level Security) blocking operations** - Most common issue
2. **Example services** - Fallback services have string IDs, can't be added to database
3. **Service/user not found** - Database doesn't have the service or user

## Solution: Disable RLS (For Development)

**IMPORTANT:** Run this SQL in your Supabase SQL Editor:

```sql
-- Disable RLS on all tables
ALTER TABLE users DISABLE ROW LEVEL SECURITY;
ALTER TABLE services DISABLE ROW LEVEL SECURITY;
ALTER TABLE carts DISABLE ROW LEVEL SECURITY;
ALTER TABLE wishlists DISABLE ROW LEVEL SECURITY;
ALTER TABLE orders DISABLE ROW LEVEL SECURITY;
ALTER TABLE order_items DISABLE ROW LEVEL SECURITY;
```

## Verify Tables Exist

Run this to check if all tables exist:

```sql
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public' 
AND table_name IN ('users', 'services', 'carts', 'wishlists', 'orders', 'order_items');
```

## Create a Real Service to Test

Example services (like "Professional Logo Design") are just examples and can't be added to cart/wishlist because they don't exist in the database.

To test properly:

1. Switch to "Host" mode
2. Create a real service listing
3. Switch back to "Student" mode
4. Try adding that service to cart/wishlist

## Check Your User Exists

Run this query to verify your user exists in the database:

```sql
SELECT * FROM users WHERE email = 'your-email@bmsce.ac.in';
```

If your user doesn't exist, sign in again - it will create the user automatically.

## Check Services Exist

Run this query to see all services in the database:

```sql
SELECT id, title, category FROM services LIMIT 10;
```

If no services exist, create one in "Host" mode.

## Common Error Codes

- **PGRST116**: No rows found (this is OK for maybeSingle queries)
- **42501**: Permission denied (RLS is blocking - disable it!)
- **23503**: Foreign key violation (service/user doesn't exist)
- **23505**: Unique constraint violation (already in cart/wishlist)

## Still Not Working?

1. Open browser console (F12)
2. Try adding to cart/wishlist
3. Check the error message in console
4. Share the error message for further debugging

