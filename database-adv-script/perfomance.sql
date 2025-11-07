-- ALX Airbnb Database Module: Query Performance Optimization

-- Initial Query: Retrieve all bookings along with user, property, and payment details.
-- This query uses multiple INNER JOINs, which can be resource-intensive on large datasets,
-- especially without proper indexing.
SELECT
  b.booking_id,
  b.start_date,
  b.end_date,
  u.username,
  u.email AS user_email,
  p.title AS property_title,
  p.city AS property_city,
  py.amount AS payment_amount,
  py.payment_date
FROM Bookings AS b
INNER JOIN Users AS u
  ON b.user_id = u.user_id
INNER JOIN Properties AS p
  ON b.property_id = p.property_id
INNER JOIN Payments AS py
  ON b.booking_id = py.booking_id
ORDER BY
  b.start_date DESC;


-- Optimized Query: Refactor the complex query for better performance.
-- Assuming indexing has been applied to Foreign Keys (user_id, property_id, booking_id).
-- The structure remains largely the same, but the optimization relies on:
-- 1. Ensuring necessary indexes are present (as done in the previous step).
-- 2. Limiting the number of selected columns to only what is required (if the full data is not needed).
-- 3. Using specific JOIN types where a specific behavior is desired (though INNER JOIN is correct here).
-- This version assumes the database's query optimizer will use the indexes to perform the joins efficiently.
SELECT
  b.booking_id,
  u.username,
  p.title,
  py.amount,
  b.start_date,
  b.end_date
FROM Bookings AS b
INNER JOIN Users AS u
  ON b.user_id = u.user_id
INNER JOIN Properties AS p
  ON b.property_id = p.property_id
INNER JOIN Payments AS py
  ON b.booking_id = py.booking_id
ORDER BY
  b.start_date DESC
LIMIT 1000; -- Adding a LIMIT clause is a common optimization to prevent excessive resource use for front-end display.
