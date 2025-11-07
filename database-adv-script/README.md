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
