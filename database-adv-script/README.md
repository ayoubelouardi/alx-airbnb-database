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
