# Database Schema DDL (Data Definition Language)

This directory contains the `schema.sql` file, which is a PostgreSQL script used to create the complete database structure for the Airbnb Clone project.

## Script Overview

The script is organized into several logical sections to ensure correct creation order and readability.

### 1. ENUM Types
First, the script defines three custom `ENUM` types:
* `user_role`
* `booking_status`
* `payment_method_type`

This ensures data consistency by restricting the values allowed in specific columns (e.g., `role`, `status`).

### 2. Table Creation
The script creates the six core tables as defined in the database specification:
1.  `"User"` (Quoted to avoid conflict with the SQL `USER` keyword)
2.  `Property`
3.  `Booking`
4.  `Payment`
5.  `Review`
6.  `Message`

### 3. Constraints and Data Integrity
Each table includes robust constraints to protect data integrity:
* **Primary Keys (PK):** `UUID` type, set to `gen_random_uuid()` by default.
* **Foreign Keys (FK):** Enforces relationships between tables (e.g., `Booking.property_id` references `Property.property_id`).
* **Referential Actions:** Uses `ON DELETE CASCADE`, `ON DELETE RESTRICT`, and `ON DELETE SET NULL` to define behavior when a referenced record is deleted.
* **UNIQUE:** Ensures the `email` in the `"User"` table is unique.
* **CHECK:** Ensures `rating` in the `Review` table is between 1 and 5, and that `end_date` in `Booking` is after `start_date`.
* **NOT NULL:** Enforces that required fields contain a value.

### 4. Automatic Timestamp (Trigger)
A PostgreSQL-specific trigger (`trigger_set_timestamp()`) is created and applied to the `Property` table. This automatically updates the `updated_at` column to the current time whenever a row in that table is modified.

### 5. Performance Indexing
Finally, the script creates indexes on all foreign key columns and other frequently queried columns (like `User.email`). This is critical for optimizing database performance by speeding up read queries, `JOIN` operations, and `WHERE` clauses.
