# Database Seeding Script (DML)

This directory contains the `seeding.sql` file, which is a PostgreSQL script used to populate the database with realistic sample data. This is essential for testing the application's functionality.

## Script Logic and Execution Order

The script is designed to be run *after* the `schema.sql` script has successfully created the database structure. It respects all foreign key constraints by inserting data in a specific, logical order.

To manage the `UUID` primary and foreign keys, the script uses **Common Table Expressions (CTEs)**, or `WITH` clauses.

The execution flow is as follows:

1.  **`WITH new_users`:**
    * Four sample users are inserted into the `"User"` table (2 guests, 2 hosts).
    * The `RETURNING user_id` clause captures the new UUIDs.

2.  **`WITH new_properties`:**
    * Three sample properties are inserted into the `Property` table.
    * The `host_id` for each property is assigned by sub-querying the `new_users` CTE (e.g., `(SELECT user_id FROM new_users WHERE email = 'bob@example.com')`).
    * The new `property_id`s are captured.

3.  **`WITH new_bookings`:**
    * Four sample bookings are inserted, linking users and properties from the previous CTEs.
    * This includes a mix of `confirmed`, `pending`, and `canceled` bookings to simulate real-world data.

4.  **`INSERT INTO Payment`:**
    * Payments are created for the confirmed and pending bookings, referencing the `booking_id`s captured from the `new_bookings` CTE.

5.  **`INSERT INTO Review`:**
    * A sample review is created for a past, confirmed booking, linking the correct `user_id` and `property_id`.

6.  **`INSERT INTO Message`:**
    * A sample message thread is created between a guest and a host, referencing their respective `user_id`s.

This approach ensures that all relationships are valid and the database is populated with a clean, interconnected set of sample data.
