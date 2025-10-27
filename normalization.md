# 🗂️ Database Normalization Analysis (3NF)

This document outlines the review process for ensuring the database schema for the Airbnb Clone project adheres to the Third Normal Form (3NF).

## Objective

The goal of normalization is to reduce data redundancy, improve data integrity, and prevent update anomalies. A database is in **3NF** if it meets two primary conditions:
1.  It is already in **Second Normal Form (2NF)**.
2.  It contains no **transitive dependencies** (i.e., no non-key attribute is dependent on another non-key attribute).

---

## Analysis of the Schema

The database schema provided in the "Database Specification" was reviewed table by table to assess its normalization level.

### 1. First Normal Form (1NF)
* **Check:** Does every column contain atomic (indivisible) values?
* **Result:** **Yes.** All tables in the schema (`User`, `Property`, `Booking`, `Payment`, `Review`, `Message`) list attributes that are atomic. There are no repeating groups or multi-value columns (e.g., a `phone_numbers` column storing a list of numbers).
* **Status:** The schema is in **1NF**.

### 2. Second Normal Form (2NF)
* **Check:** Is the schema in 1NF, and do all non-key attributes depend on the *entire* primary key?
* **Result:** **Yes.** 2NF is primarily a concern for tables with composite primary keys (keys made of multiple columns). In our schema, every table (`User`, `Property`, `Booking`, etc.) uses a single, non-composite `UUID` as its primary key (e.g., `user_id`, `property_id`).
* **Status:** Since there are no partial dependencies, the schema is in **2NF**.

### 3. Third Normal Form (3NF)
* **Check:** Is the schema in 2NF, and are there no transitive dependencies?
* **Result:** **Yes.** A transitive dependency would occur if a non-key attribute depended on another non-key attribute. We reviewed each table:
    * **User:** Attributes like `first_name` and `email` depend only on `user_id`.
    * **Property:** Attributes like `name` and `location` depend only on `property_id`. The `host_id` is a foreign key.
    * **Review:** `rating` and `comment` depend only on `review_id`.
    * **Message:** `message_body` depends only on `message_id`.
    * **Payment:** `amount` and `payment_method` depend only on `payment_id`.
    * **Booking:** This table is the most important to check.
        * `start_date`, `end_date`, and `status` depend directly on the `booking_id`.
        * The `total_price` attribute might seem like a calculated field (a 3NF violation). However, in this context, `total_price` is a **transactional snapshot**—it's the price the user agreed to *at the time of booking*. It is not transitively dependent on the `Property` table's current `pricepernight`, which could change. Therefore, `total_price` is an attribute that depends directly and only on the `booking_id`.

---

## Conclusion

The database schema, as defined in the specification, is **already in Third Normal Form (3NF)**.

* ✅ It satisfies **1NF** (all values are atomic).
* ✅ It satisfies **2NF** (no partial dependencies exist, as all PKs are single columns).
* ✅ It satisfies **3NF** (no transitive dependencies were identified).

No adjustments to the schema are necessary to achieve 3NF. The design is well-normalized, reduces redundancy, and ensures data integrity.
