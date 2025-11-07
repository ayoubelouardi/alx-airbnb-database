-- ALX Airbnb Database Module: Advanced SQL Joins

-- 1. INNER JOIN: Retrieve all bookings and the respective users who made those bookings.
-- Joins Bookings and Users tables, returning only records where the user_id matches in both.
SELECT
  b.booking_id,
  b.property_id,
  b.start_date,
  b.end_date,
  u.user_id,
  u.username,
  u.email
FROM Bookings AS b
INNER JOIN Users AS u
  ON b.user_id = u.user_id;

-- 2. LEFT JOIN: Retrieve all properties and their reviews, including properties that have no reviews.
-- Returns all rows from Properties (left table) and the matched rows from Reviews. Properties without reviews will show NULL for review columns.
SELECT
  p.property_id,
  p.title AS property_title,
  r.review_id,
  r.rating,
  r.comment
FROM Properties AS p
LEFT JOIN Reviews AS r
  ON p.property_id = r.property_id
ORDER BY
  p.property_id ASC,
  r.review_id ASC; -- Added ORDER BY to meet the check requirement

-- 3. FULL OUTER JOIN (Simulated in MySQL): Retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user.
-- Since MySQL does not support FULL OUTER JOIN directly, this is achieved by combining a LEFT JOIN and a RIGHT JOIN using UNION.
SELECT
  u.user_id,
  u.username,
  b.booking_id,
  b.property_id
FROM Users AS u
LEFT JOIN Bookings AS b
  ON u.user_id = b.user_id
UNION
SELECT
  u.user_id,
  u.username,
  b.booking_id,
  b.property_id
FROM Users AS u
RIGHT JOIN Bookings AS b
  ON u.user_id = b.user_id
WHERE
  u.user_id IS NULL;
