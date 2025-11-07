# 🏠 ALX Airbnb Database Module: Advanced SQL & Optimization

This repository contains SQL scripts and documentation for the ALX Airbnb Database Module project, focusing on **advanced SQL querying, performance optimization, indexing, and partitioning**.

The goal is to master database management techniques required for scalable, high-volume applications.

---

## 📂 Directory Structure

The project files are organized in the `database-adv-script` directory.

### `database-adv-script/`

| File Name | Description |
| :--- | :--- |
| `joins_queries.sql` | **Advanced SQL Joins**: Scripts demonstrating INNER, LEFT, and simulated FULL OUTER joins to combine data across core tables (Users, Bookings, Properties, Reviews). |
| `README.md` | This file. |

---

## 📝 File Explanation: `joins_queries.sql`

This file contains three mandatory SQL queries designed to demonstrate mastery of different SQL join types:

1.  **INNER JOIN**: Used to retrieve **only matching records** (e.g., Bookings *with* a corresponding User).
2.  **LEFT JOIN**: Used to retrieve **all records** from the primary (left) table and matching records from the secondary table (e.g., **All Properties**, showing reviews where they exist).
3.  **FULL OUTER JOIN (Simulated)**: Used to retrieve **all records** from both tables, combining matches and showing non-matched rows with `NULL`s. *Note: The script uses `LEFT JOIN` and `RIGHT JOIN` combined with `UNION` to simulate this functionality in MySQL.*

### ➡️ New File Added to `database-adv-script/`

| File Name | Description |
| :--- | :--- |
| `subqueries.sql` | **Advanced Subqueries**: Scripts demonstrating both non-correlated and correlated subqueries for filtering and analysis. |

---

## 📝 File Explanation: `subqueries.sql`

This file focuses on using subqueries to perform complex data filtering and analysis tasks:

* **Non-Correlated Subquery**: The first query uses a subquery in the `WHERE` clause (`IN` operator) to identify properties based on an aggregated value (average rating). The inner query calculates the average rating for all properties independently, and the outer query uses the results for filtering.
* **Correlated Subquery**: The second query uses a subquery in the `WHERE` clause that **references a column from the outer query** (`u.user_id`). This technique is used to dynamically check the number of bookings for *each specific user* being evaluated by the outer query, identifying users with high booking activity.

### ➡️ New File Added to `database-adv-script/`

| File Name | Description |
| :--- | :--- |
| `aggregations_and_window_functions.sql` | **Aggregation and Window Functions**: Scripts for summarizing data using `COUNT` with `GROUP BY`, and ranking properties using advanced window functions (`RANK` and `ROW_NUMBER`). |

---

## 📝 File Explanation: `aggregations_and_window_functions.sql`

This file demonstrates two critical advanced SQL concepts for data analysis:

* **Aggregation (`COUNT` and `GROUP BY`)**: The first query calculates the **total number of bookings** for every user. It uses a `LEFT JOIN` to include users with zero bookings and `COUNT(b.booking_id)` combined with `GROUP BY` to summarize the results by `user_id`.
* **Window Functions (`RANK` and `ROW_NUMBER`)**: The second query uses a **Common Table Expression (CTE)** to calculate booking totals per property. It then applies:
    * **`RANK()`**: Assigns a rank to each property based on the booking count. Properties with the same count receive the same rank, and the next rank skips a number.
    * **`ROW_NUMBER()`**: Assigns a unique, sequential number to each property in the ranked list, even if they have the same booking count.
