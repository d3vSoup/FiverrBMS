# Supabase Setup Guide

This project now supports Supabase as the database backend. Follow these steps to set it up.

## 1. Create a Supabase Project

1. Go to [supabase.com](https://supabase.com) and create an account
2. Create a new project
3. Wait for the database to be provisioned

## 2. Set Up Database Schema

1. In your Supabase project, go to the SQL Editor
2. Copy and paste the contents of `supabase/sql/schema.sql` into the editor
3. Run the SQL to create all tables
4. (Optional) Run `supabase/sql/admin_views.sql` for admin dashboard views

## 3. Configure Environment Variables

Create a `.env` file in the `fiverrfront/` directory:

```env
# Enable Supabase
VITE_USE_SUPABASE=true

# Your Supabase project URL (found in Project Settings > API)
VITE_SUPABASE_URL=https://your-project-id.supabase.co

# Your Supabase anon/public key (found in Project Settings > API)
VITE_SUPABASE_ANON_KEY=your-anon-key-here

# Optional: Google OAuth (if using)
VITE_GOOGLE_CLIENT_ID=your-google-client-id
```

## 4. Enable Row Level Security (RLS) Policies

For production, you should set up RLS policies. For development, you can disable RLS temporarily:

```sql
-- Temporarily disable RLS for development (NOT recommended for production)
ALTER TABLE users DISABLE ROW LEVEL SECURITY;
ALTER TABLE services DISABLE ROW LEVEL SECURITY;
ALTER TABLE carts DISABLE ROW LEVEL SECURITY;
ALTER TABLE wishlists DISABLE ROW LEVEL SECURITY;
ALTER TABLE orders DISABLE ROW LEVEL SECURITY;
```

For production, set up proper RLS policies based on your authentication needs.

## 5. Test the Integration

1. Start your development server:
   ```bash
   cd fiverrfront
   npm run dev
   ```

2. Sign in with a valid email (must match allowed domains)
3. Create a service listing
4. Add items to cart
5. Check your Supabase dashboard to verify data is being saved

## Features Using Supabase

- ✅ User authentication and profile management
- ✅ Service listings (create, read, update, delete)
- ✅ Shopping cart
- ✅ Wishlist
- ✅ Orders (when implemented)
- ✅ Profile editing with permanent storage

## Switching Between Supabase and REST API

The app automatically detects which backend to use based on `VITE_USE_SUPABASE`:
- `true` or if `VITE_SUPABASE_URL` is set: Uses Supabase
- `false` or unset: Uses REST API (default backend)

## Troubleshooting

1. **Data not saving**: Check that RLS is disabled or proper policies are set
2. **Connection errors**: Verify your Supabase URL and anon key are correct
3. **User not found errors**: Make sure the users table exists and has the correct schema
4. **Cart/Wishlist not loading**: Check that foreign key relationships are set up correctly

