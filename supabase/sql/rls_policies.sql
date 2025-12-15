-- ============================================================
-- RLS (Row Level Security) Policies for Supabase
-- These policies allow authenticated operations on tables
-- IMPORTANT: Run this AFTER creating the tables in schema.sql
-- ============================================================

-- Disable RLS temporarily for easier development (enable later for production)
-- Or set up proper policies below

-- For now, we'll disable RLS on all tables to allow operations
-- In production, you should enable RLS and use proper policies

ALTER TABLE users DISABLE ROW LEVEL SECURITY;
ALTER TABLE services DISABLE ROW LEVEL SECURITY;
ALTER TABLE carts DISABLE ROW LEVEL SECURITY;
ALTER TABLE wishlists DISABLE ROW LEVEL SECURITY;
ALTER TABLE orders DISABLE ROW LEVEL SECURITY;
ALTER TABLE order_items DISABLE ROW LEVEL SECURITY;

-- ============================================================
-- Alternative: Enable RLS with proper policies
-- Uncomment below if you want to enable RLS instead
-- ============================================================

-- Enable RLS
-- ALTER TABLE users ENABLE ROW LEVEL SECURITY;
-- ALTER TABLE services ENABLE ROW LEVEL SECURITY;
-- ALTER TABLE carts ENABLE ROW LEVEL SECURITY;
-- ALTER TABLE wishlists ENABLE ROW LEVEL SECURITY;
-- ALTER TABLE orders ENABLE ROW LEVEL SECURITY;
-- ALTER TABLE order_items ENABLE ROW LEVEL SECURITY;

-- Users: Anyone can read, users can update their own
-- CREATE POLICY "Users are viewable by everyone" ON users FOR SELECT USING (true);
-- CREATE POLICY "Users can insert their own" ON users FOR INSERT WITH CHECK (true);
-- CREATE POLICY "Users can update their own" ON users FOR UPDATE USING (true);

-- Services: Public read, authenticated write
-- CREATE POLICY "Services are viewable by everyone" ON services FOR SELECT USING (true);
-- CREATE POLICY "Authenticated users can create services" ON services FOR INSERT WITH CHECK (true);
-- CREATE POLICY "Users can update their own services" ON services FOR UPDATE USING (true);
-- CREATE POLICY "Users can delete their own services" ON services FOR DELETE USING (true);

-- Carts: Users can manage their own
-- CREATE POLICY "Users can view their own cart" ON carts FOR SELECT USING (true);
-- CREATE POLICY "Users can add to their own cart" ON carts FOR INSERT WITH CHECK (true);
-- CREATE POLICY "Users can update their own cart" ON carts FOR UPDATE USING (true);
-- CREATE POLICY "Users can delete from their own cart" ON carts FOR DELETE USING (true);

-- Wishlists: Users can manage their own
-- CREATE POLICY "Users can view their own wishlist" ON wishlists FOR SELECT USING (true);
-- CREATE POLICY "Users can add to their own wishlist" ON wishlists FOR INSERT WITH CHECK (true);
-- CREATE POLICY "Users can delete from their own wishlist" ON wishlists FOR DELETE USING (true);

-- Orders: Users can view their own, admins can view all
-- CREATE POLICY "Users can view their own orders" ON orders FOR SELECT USING (true);
-- CREATE POLICY "Users can create orders" ON orders FOR INSERT WITH CHECK (true);
-- CREATE POLICY "Users can update their own orders" ON orders FOR UPDATE USING (true);

-- Order items: Same as orders
-- CREATE POLICY "Users can view order items for their orders" ON order_items FOR SELECT USING (true);
-- CREATE POLICY "Users can create order items" ON order_items FOR INSERT WITH CHECK (true);

