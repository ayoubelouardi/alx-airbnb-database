-- ALX Airbnb Database Module: Subqueries

-- 1. Non-Correlated Subquery: Find properties where the average rating is greater than 4.0.
-- This uses a non-correlated subquery (the inner query runs independently) to first calculate
-- the average rating per property from the Reviews table, and then filters the Properties table.
SELECT
  p.property_id,
  p.title,
  p.price_per_night
FROM Properties AS p
WHERE
  p.property_id IN (
    SELECT
      r.property_id
    FROM Reviews AS r
    GROUP BY
      r.property_id
    HAVING
      AVG(r.rating) > 4.0
  );

-- 2. Correlated Subquery: Find users who have made more than 3 bookings.
-- This uses a correlated subquery (the inner query depends on the outer query) to check the
-- booking count for each user in the outer query's row, ensuring efficiency by checking
-- only the relevant user's bookings.
SELECT
  u.user_id,
  u.username,
  u.email
FROM Users AS u
WHERE
  (
    SELECT
      COUNT(*)
    FROM Bookings AS b
    WHERE
      b.user_id = u.user_id
  ) > 3;
