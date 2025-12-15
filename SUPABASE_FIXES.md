# Supabase Cart, Wishlist, and Orders Fixes

## Issues Fixed

### 1. Cart Not Saving on Refresh ✅
- **Problem:** Cart items weren't persisting to Supabase database
- **Fix:** 
  - Improved `addToCart` function with better error handling
  - Added service existence validation before adding to cart
  - Cart now properly saves to database and reloads on page refresh
  - Fixed duplicate cart item handling

### 2. Wishlist Not Saving on Refresh ✅
- **Problem:** Wishlist items weren't persisting to Supabase
- **Fix:**
  - Fixed `toggleWishlist` to use `maybeSingle()` instead of `single()` to handle missing items
  - Wishlist now properly saves to database and reloads on refresh
  - Improved error handling

### 3. Add to Cart Error ✅
- **Problem:** "Failed to add to cart" error was showing
- **Fix:**
  - Added validation to check if service exists before adding
  - Added validation to check if user exists
  - Improved error messages for better debugging
  - Fixed foreign key constraint handling

### 4. Admin Panel - User Details in Orders ✅
- **Problem:** Admin couldn't see USN, phone, and semester in orders
- **Fix:**
  - Updated `getOrders` to join with `users` table
  - Admin panel now displays:
    - Buyer email
    - Buyer name
    - USN (University Seat Number)
    - Phone number
    - Semester
  - Order details page shows complete buyer information

### 5. Profile Completion Saves to Database ✅
- **Problem:** Profile edits (USN, phone, semester) weren't saving permanently
- **Fix:**
  - Profile updates now properly save to Supabase `users` table
  - All fields (phone, USN, semester) persist correctly
  - Profile data loads from database on sign-in

### 6. Admin Inventory Shows Student Details ✅
- **Problem:** Admin inventory didn't show student USN, phone in carts
- **Fix:**
  - Updated `getAdminInventory` to include student details:
    - Student name
    - Phone number
    - USN
    - Semester
  - Cart items grouped by student with complete profile info

## Database Setup Required

### Step 1: Run Schema SQL
Run the SQL in `supabase/sql/schema.sql` in your Supabase SQL editor to create all tables.

### Step 2: Disable RLS (For Development)
Run the SQL in `supabase/sql/rls_policies.sql` to disable Row Level Security for easier development:

```sql
ALTER TABLE users DISABLE ROW LEVEL SECURITY;
ALTER TABLE services DISABLE ROW LEVEL SECURITY;
ALTER TABLE carts DISABLE ROW LEVEL SECURITY;
ALTER TABLE wishlists DISABLE ROW LEVEL SECURITY;
ALTER TABLE orders DISABLE ROW LEVEL SECURITY;
ALTER TABLE order_items DISABLE ROW LEVEL SECURITY;
```

**⚠️ Important:** For production, you should enable RLS and set up proper policies (see the commented section in `rls_policies.sql`).

### Step 3: Verify Tables
Ensure these tables exist in Supabase:
- ✅ `users` - with columns: email, name, phone_number, usn, semester, role, avatar_url
- ✅ `services` - service listings
- ✅ `carts` - cart items with user_email, service_id
- ✅ `wishlists` - wishlist items with user_id, service_id
- ✅ `orders` - orders with buyer_email, host_email
- ✅ `order_items` - order line items

## How It Works Now

### Cart & Wishlist Flow:
1. User signs in → Cart/Wishlist loads from Supabase
2. User adds item → Saves to Supabase immediately
3. User refreshes page → Cart/Wishlist reloads from Supabase
4. All changes persist across sessions

### Profile Flow:
1. User edits profile (USN, phone, semester) → Saves to Supabase `users` table
2. Profile data persists permanently
3. Admin can see complete user details in orders

### Admin Panel:
1. Admin views orders → Sees complete buyer information including USN, phone, semester
2. Admin views inventory → Sees student details with carts
3. All data comes from Supabase database

## Testing Checklist

- [ ] Add item to cart → Check Supabase `carts` table
- [ ] Refresh page → Cart should reload
- [ ] Add to wishlist → Check Supabase `wishlists` table
- [ ] Refresh page → Wishlist should reload
- [ ] Edit profile → Save USN, phone, semester
- [ ] Refresh page → Profile should persist
- [ ] Admin views orders → Should see USN, phone, semester
- [ ] Admin views inventory → Should see student details

## Environment Variables Required

Make sure these are set in your `.env` file:

```env
VITE_SUPABASE_URL=your_supabase_url
VITE_SUPABASE_ANON_KEY=your_supabase_anon_key
VITE_GOOGLE_CLIENT_ID=your_google_client_id
```

## Troubleshooting

### Cart/Wishlist not saving?
- Check browser console for errors
- Verify RLS is disabled (for development)
- Check Supabase logs in dashboard
- Verify user is signed in (cart/wishlist requires authentication)

### Admin not seeing user details?
- Verify `users` table has data
- Check that orders have correct `buyer_email`
- Verify profile was saved (check `users` table for USN, phone, semester)

### "Failed to add to cart" error?
- Check if service exists in `services` table
- Verify user is signed in
- Check Supabase error logs
- Verify RLS policies allow inserts

