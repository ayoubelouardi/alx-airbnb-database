-- ALX Airbnb Database Module: Aggregations and Window Functions

-- 1. Aggregation with GROUP BY: Find the total number of bookings made by each user.
-- Uses the COUNT() aggregate function and GROUP BY to summarize data per user.
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

-- 2. Window Function (RANK): Rank properties based on the total number of bookings.
-- Uses a Common Table Expression (CTE) to first calculate the booking count per property,
-- then applies the RANK() window function to assign a rank to each property.
WITH PropertyBookingCounts AS (
  SELECT
    p.property_id,
    p.title,
    COUNT(b.booking_id) AS booking_count
  FROM Properties AS p
  LEFT JOIN Bookings AS b
    ON p.property_id = b.property_id
  GROUP BY
    p.property_id,
    p.title
)
SELECT
  property_id,
  title,
  booking_count,
  RANK() OVER (ORDER BY booking_count DESC) AS booking_rank,
  ROW_NUMBER() OVER (ORDER BY booking_count DESC) AS booking_row_number
FROM PropertyBookingCounts
ORDER BY
  booking_rank ASC,
  booking_count DESC;
