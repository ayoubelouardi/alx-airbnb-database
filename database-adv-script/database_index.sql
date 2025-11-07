-- ALX Airbnb Database Module: Index Creation Commands and Performance Analysis

-- Test Query: Find the total number of bookings made by each user.
-- This query is used to demonstrate the performance gain from indexing.

-- === 1. PERFORMANCE BEFORE INDEXING (CHECK) ===
-- Use EXPLAIN ANALYZE to capture baseline performance before creating indexes.
EXPLAIN ANALYZE
SELECT
  u.user_id,
  u.username,
  COUNT(b.booking_id) AS total_bookings
FROM Users AS u
LEFT JOIN Bookings AS b
  ON u.user_id = b.user_id
GROUP BY
  u.user_id,
  u.username
ORDER BY
  total_bookings DESC;

-- === 2. INDEX CREATION ===
-- Create indexes to optimize query performance, primarily targeting
-- columns frequently used in JOIN, WHERE, and ORDER BY clauses (Foreign Keys and lookup fields).

-- Index for Bookings to User join/lookup
CREATE INDEX idx_bookings_user_id
ON Bookings (user_id);

-- Index for Bookings to Property join/lookup
CREATE INDEX idx_bookings_property_id
ON Bookings (property_id);

-- Index for Reviews to Property join/lookup
CREATE INDEX idx_reviews_property_id
ON Reviews (property_id);

-- Unique Index on User email
CREATE UNIQUE INDEX idx_users_email
ON Users (email);


-- === 3. PERFORMANCE AFTER INDEXING (CHECK) ===
-- Use EXPLAIN ANALYZE again to capture performance after creating indexes.
EXPLAIN ANALYZE
SELECT
  u.user_id,
  u.username,
  COUNT(b.booking_id) AS total_bookings
FROM Users AS u
LEFT JOIN Bookings AS b
  ON u.user_id = b.user_id
GROUP BY
  u.user_id,
  u.username
ORDER BY
  total_bookings DESC;
