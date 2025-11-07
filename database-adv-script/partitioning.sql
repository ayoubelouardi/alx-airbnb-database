-- ALX Airbnb Database Module: Table Partitioning

-- WARNING: Running this command on a populated table can take a long time.
-- This script assumes the database supports MySQL-style RANGE partitioning.

-- Drop the existing Bookings table if it exists (for fresh creation with partitioning)
-- If the table is already populated, use ALTER TABLE... REORGANIZE PARTITION instead.
DROP TABLE IF EXISTS Bookings;

-- === 1. Create Partitioned Bookings Table ===
-- Partition the table by RANGE using the YEAR() of the start_date.
-- Future partitions (e.g., 2026 and MAXVALUE) will need to be added manually as time progresses.
CREATE TABLE Bookings (
    booking_id INT NOT NULL PRIMARY KEY,
    user_id INT NOT NULL,
    property_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2),
    -- Add Foreign Key constraints here if needed, linking to Users and Properties
    KEY (user_id),
    KEY (property_id)
)
PARTITION BY RANGE (YEAR(start_date)) (
    -- Partition for bookings starting before 2023
    PARTITION p_before_2023 VALUES LESS THAN (2023),
    -- Partition for bookings starting in 2023
    PARTITION p_2023 VALUES LESS THAN (2024),
    -- Partition for bookings starting in 2024
    PARTITION p_2024 VALUES LESS THAN (2025),
    -- Partition for bookings starting in 2025 (current year)
    PARTITION p_2025 VALUES LESS THAN (2026),
    -- Catch-all partition for future bookings or unexpected dates (highly recommended)
    PARTITION p_future VALUES LESS THAN MAXVALUE
);


-- === 2. PERFORMANCE TEST QUERY (Date Range) ===
-- Test query that benefits significantly from date-based partitioning.
-- When querying a specific date range, the database only checks the relevant partition(s).
EXPLAIN ANALYZE
SELECT
    booking_id,
    start_date,
    end_date,
    total_price
FROM Bookings
WHERE
    start_date BETWEEN '2024-01-01' AND '2024-03-31'
ORDER BY
    start_date ASC;
