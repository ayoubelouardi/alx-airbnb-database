-- This script populates the database with sample data (DML).
-- It uses WITH clauses (Common Table Expressions) to capture the
-- generated UUIDs and use them for foreign keys, ensuring
-- relational integrity.

WITH new_users AS (
    -- 1. Create Users
    -- We create 4 users: 2 guests and 2 hosts.
    INSERT INTO "User" (first_name, last_name, email, password_hash, phone_number, role)
    VALUES
        ('Alice', 'Wonder', 'alice@example.com', 'hash_pw_alice', '111-222-3333', 'guest'),
        ('Bob', 'Builder', 'bob@example.com', 'hash_pw_bob', '444-555-6666', 'host'),
        ('Charlie', 'Chaplin', 'charlie@example.com', 'hash_pw_charlie', '777-888-9999', 'host'),
        ('Dana', 'Scully', 'dana@example.com', 'hash_pw_dana', '123-456-7890', 'guest')
    RETURNING user_id, email
),
new_properties AS (
    -- 2. Create Properties
    -- We use the user_id of the hosts (Bob, Charlie) from the CTE above.
    INSERT INTO Property (host_id, name, description, location, pricepernight)
    VALUES
        ((SELECT user_id FROM new_users WHERE email = 'bob@example.com'), 'Cozy Cabin in the Woods', 'A beautiful, quiet cabin perfect for a getaway.', 'Forestville, CA', 150.00),
        ((SELECT user_id FROM new_users WHERE email = 'bob@example.com'), 'Modern Downtown Loft', 'A stylish loft in the heart of the city.', 'Metropolis, NY', 220.00),
        ((SELECT user_id FROM new_users WHERE email = 'charlie@example.com'), 'Sunny Beachside Villa', 'A luxurious villa with a private beach.', 'Malibu, CA', 450.00)
    RETURNING property_id, name
),
new_bookings AS (
    -- 3. Create Bookings
    -- We create bookings from guests (Alice, Dana) for the new properties.
    INSERT INTO Booking (property_id, user_id, start_date, end_date, total_price, status)
    VALUES
        -- Booking 1: Alice books Cozy Cabin (Past, Confirmed)
        ((SELECT property_id FROM new_properties WHERE name = 'Cozy Cabin in the Woods'), 
         (SELECT user_id FROM new_users WHERE email = 'alice@example.com'), 
         '2024-08-01', '2024-08-05', 600.00, 'confirmed'),
         
        -- Booking 2: Dana books Beachside Villa (Future, Confirmed)
        ((SELECT property_id FROM new_properties WHERE name = 'Sunny Beachside Villa'), 
         (SELECT user_id FROM new_users WHERE email = 'dana@example.com'), 
         '2025-12-10', '2025-12-15', 2250.00, 'confirmed'),

        -- Booking 3: Alice books Downtown Loft (Future, Pending)
        ((SELECT property_id FROM new_properties WHERE name = 'Modern Downtown Loft'), 
         (SELECT user_id FROM new_users WHERE email = 'alice@example.com'), 
         '2026-01-20', '2026-01-22', 440.00, 'pending'),

        -- Booking 4: Dana books Cozy Cabin (Canceled)
        ((SELECT property_id FROM new_properties WHERE name = 'Cozy Cabin in the Woods'), 
         (SELECT user_id FROM new_users WHERE email = 'dana@example.com'), 
         '2025-11-01', '2025-11-05', 600.00, 'canceled')
    RETURNING booking_id, property_id, user_id, status
)
-- 4. Create Payments
-- We create payments for the confirmed and pending bookings.
INSERT INTO Payment (booking_id, amount, payment_method)
VALUES
    ((SELECT booking_id FROM new_bookings WHERE status = 'confirmed' LIMIT 1), 600.00, 'credit_card'), -- For Alice's past booking
    ((SELECT booking_id FROM new_bookings WHERE status = 'confirmed' OFFSET 1 LIMIT 1), 2250.00, 'paypal'), -- For Dana's future booking
    ((SELECT booking_id FROM new_bookings WHERE status = 'pending' LIMIT 1), 440.00, 'stripe'); -- For Alice's pending booking

-- 5. Create Reviews
-- We create a review for the one completed booking (Alice's stay at the Cabin).
INSERT INTO Review (property_id, user_id, rating, comment)
VALUES
    ((SELECT property_id FROM new_bookings WHERE user_id = (SELECT user_id FROM new_users WHERE email = 'alice@example.com') AND status = 'confirmed' LIMIT 1), 
     (SELECT user_id FROM new_users WHERE email = 'alice@example.com'), 
     5, 
     'Absolutely wonderful stay! The cabin was clean, quiet, and exactly as described. Bob was a great host. Will be back!');

-- 6. Create Messages
-- We create a message thread between a guest (Dana) and a host (Charlie).
INSERT INTO Message (sender_id, recipient_id, message_body)
VALUES
    ((SELECT user_id FROM new_users WHERE email = 'dana@example.com'), 
     (SELECT user_id FROM new_users WHERE email = 'charlie@example.com'),
     'Hi Charlie, just confirming my booking for December. Is early check-in possible?'),
     
    ((SELECT user_id FROM new_users WHERE email = 'charlie@example.com'), 
     (SELECT user_id FROM new_users WHERE email = 'dana@example.com'),
     'Hi Dana, thanks for booking! Early check-in is no problem. We can have the villa ready by 1 PM.');

