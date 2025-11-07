-- ALX Airbnb Database Module: Index Creation Commands

-- These indexes are created to optimize query performance, primarily targeting
-- columns frequently used in JOIN, WHERE, and ORDER BY clauses (Foreign Keys and lookup fields).

-- 1. Index for Bookings to User join/lookup
-- Highly used for aggregations (total bookings per user) and correlated subqueries.
CREATE INDEX idx_bookings_user_id
ON Bookings (user_id);

-- 2. Index for Bookings to Property join/lookup
-- Highly used for aggregations (ranking properties by bookings).
CREATE INDEX idx_bookings_property_id
ON Bookings (property_id);

-- 3. Index for Reviews to Property join/lookup
-- Crucial for performance of average rating subqueries.
CREATE INDEX idx_reviews_property_id
ON Reviews (property_id);

-- 4. Unique Index on User email
-- Speeds up lookups by email (e.g., login) and ensures data integrity.
CREATE UNIQUE INDEX idx_users_email
ON Users (email);
