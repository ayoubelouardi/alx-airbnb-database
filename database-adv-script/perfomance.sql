-- ALX Airbnb Database Module: Query Performance Optimization

-- === 1. INITIAL QUERY ANALYSIS (Inefficient) ===
-- Write an initial query that retrieves all bookings along with the user details,
-- property details, and payment details. (Constraint: Must not contain WHERE or AND for filtering)

EXPLAIN
SELECT
  b.booking_id,
  b.start_date,
  b.end_date,
  u.username,
  u.email,
  p.title AS property_title,
  p.city,
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


-- === 2. REFACTORED QUERY ANALYSIS (Optimized) ===
-- Refactor the query to reduce execution time, primarily by relying on indexes
-- (assuming they are created) and reducing the number of retrieved columns.

EXPLAIN
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
LIMIT 500;
