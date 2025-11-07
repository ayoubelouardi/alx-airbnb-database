# ⚡ Database Indexing and Performance Analysis

This document details the strategy for creating indexes to optimize query performance in the Airbnb database schema, focusing on high-usage columns identified from common analytical and retrieval queries.

---

## 1. High-Usage Column Identification

Columns were selected based on their frequent use in `JOIN`, `WHERE`, and `ORDER BY` clauses across the `Users`, `Bookings`, and `Properties` tables.

| Table | Column(s) | Usage Context | Index Type |
| :--- | :--- | :--- | :--- |
| `Users` | `email` | Unique identification, potential login/lookup filter. | Unique Index |
| `Users` | `user_id` | Primary Key, used in joins with `Bookings`. | (PK, usually indexed by default) |
| `Bookings` | `user_id` | Foreign Key, used in joining with `Users` (Correlated Subquery, Aggregation). | Non-Unique Index |
| `Bookings` | `property_id` | Foreign Key, used in joining with `Properties` (Aggregation, Ranking). | Non-Unique Index |
| `Properties` | `property_id` | Primary Key, used in joins and filtering. | (PK, usually indexed by default) |
| `Properties` | `price_per_night` | Potential filter for price range queries. | Non-Unique Index |
| `Reviews` | `property_id` | Foreign Key, used in joining with `Properties` (Subqueries for average rating). | Non-Unique Index |

---

## 2. SQL Index Creation Commands

The following commands are saved in `database_index.sql`. They create non-unique B-tree indexes on the frequently used foreign key columns and a unique index on the `Users.email` column.

```sql
-- 1. Index for Bookings to User join/lookup
-- Highly used for aggregations (total bookings per user) and correlated subqueries.
CREATE INDEX idx_bookings_user_id
ON Bookings (user_id);

-- 2. Index for Bookings to Property join/lookup
-- Highly used for aggregations (ranking properties by bookings).
CREATE INDEX idx_bookings_property_id
ON Bookings (property_id);

-- 3. Index for Reviews to Property join/lookup
-- Crucial for performance of average rating subqueries.
CREATE INDEX idx_reviews_property_id
ON Reviews (property_id);

-- 4. Unique Index on User email
-- Speeds up lookups by email (e.g., login) and ensures data integrity.
CREATE UNIQUE INDEX idx_users_email
ON Users (email);
