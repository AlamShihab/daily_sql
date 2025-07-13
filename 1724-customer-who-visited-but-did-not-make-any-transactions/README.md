# LeetCode 1581: Customer Who Visited but Did Not Make Any Transactions 🛍️

This repository contains the problem description and two common SQL solutions for LeetCode Problem 1581, **Customer Who Visited but Did Not Make Any Transactions**, which is frequently encountered in SQL interviews and part of the LeetCode SQL 50 study plan.

---

## 📝 Problem Description

We are provided with two tables: **Visits** and **Transactions**.

**Table: Visits**

| Column Name   | Type | Description          |
| ------------- | ---- | -------------------- |
| `visit_id`    | INT  | Primary key (unique) |
| `customer_id` | INT  | ID of the customer   |

This table contains information about customer visits to a mall. 🏬

**Table: Transactions**

| Column Name      | Type | Description                              |
| ---------------- | ---- | ---------------------------------------- |
| `transaction_id` | INT  | Primary key (unique)                     |
| `visit_id`       | INT  | Foreign key linking to `Visits.visit_id` |
| `amount`         | INT  | Transaction amount                       |

This table contains information about the transactions made during each visit. 💳

---

## 🎯 Objective

Write a SQL query to find the IDs of customers who **visited** the mall but **did not make any transactions**, and count the number of such visits per customer.
Return the result in any order.

---

## 📊 Example

**Input**

**Visits**

| visit\_id | customer\_id |
| --------- | ------------ |
| 1         | 23           |
| 2         | 9            |
| 4         | 30           |
| 5         | 54           |
| 6         | 96           |
| 7         | 54           |
| 8         | 54           |

**Transactions**

| transaction\_id | visit\_id | amount |
| --------------- | --------- | ------ |
| 2               | 5         | 310    |
| 3               | 5         | 300    |
| 9               | 5         | 200    |
| 12              | 1         | 910    |
| 13              | 2         | 970    |

**Output**

| customer\_id | count\_no\_trans |
| ------------ | ---------------- |
| 30           | 1                |
| 54           | 2                |
| 96           | 1                |

**Explanation**

* **23** (visit 1) and **9** (visit 2) made transactions. ✅
* **30** (visit 4) did not make any transactions. ❌
* **54** visited three times (visits 5, 7, 8). They transacted on visit 5 but not on visits 7 and 8 → **2** no-transaction visits. 🚶‍♀️🚶‍♀️
* **96** (visit 6) did not make any transactions. 🚫

---

## 💡 Solutions

We’ll explore two common approaches: **LEFT JOIN** and **NOT IN**.

---

### 1. Solution using LEFT JOIN 🤝

```sql
SELECT
    V.customer_id,
    COUNT(V.visit_id) AS count_no_trans
FROM
    Visits AS V
LEFT JOIN
    Transactions AS T
  ON V.visit_id = T.visit_id
WHERE
    T.transaction_id IS NULL
GROUP BY
    V.customer_id;
```

#### 📖 Line-by-Line Explanation

1. `SELECT V.customer_id, COUNT(V.visit_id) AS count_no_trans`

   * Selects each customer’s ID and counts their visits without transactions.
2. `FROM Visits AS V`

   * Sets **Visits** as the primary table, aliased to `V`.
3. `LEFT JOIN Transactions AS T ON V.visit_id = T.visit_id`

   * Joins **Visits** to **Transactions**, returning all visits and matching transactions (if any).
4. `WHERE T.transaction_id IS NULL`

   * Filters to only those visits with **no** matching transaction.
5. `GROUP BY V.customer_id`

   * Groups by customer to aggregate the count of no-transaction visits.

#### 👍 Pros of LEFT JOIN

* **Performance**: Highly optimized in most engines, especially with appropriate indexes. 🚀
* **Flexibility**: Can include columns from both tables if needed.
* **Clarity**: Clearly expresses the “anti-join” pattern.

#### 👎 Cons of LEFT JOIN

* Might be less intuitive for beginners unfamiliar with `IS NULL` anti-join logic.

---

### 2. Solution using NOT IN 🚫

```sql
SELECT
    customer_id,
    COUNT(visit_id) AS count_no_trans
FROM
    Visits
WHERE
    visit_id NOT IN (
        SELECT DISTINCT visit_id
        FROM Transactions
    )
GROUP BY
    customer_id;
```

#### 📖 Line-by-Line Explanation

1. `SELECT customer_id, COUNT(visit_id) AS count_no_trans`

   * Selects the customer ID and counts their visits that have no transactions.
2. `FROM Visits`

   * Operates on the **Visits** table.
3. `WHERE visit_id NOT IN ( … )`

   * Excludes any `visit_id` present in the subquery.
4. Subquery:

   ```sql
   SELECT DISTINCT visit_id
   FROM Transactions
   ```

   * Retrieves all unique `visit_id` values that **do** have transactions.
5. `GROUP BY customer_id`

   * Groups remaining visits (without transactions) by customer.

#### 👍 Pros of NOT IN

* **Readability**: Clearly expresses exclusion logic.
* **Simplicity**: Straightforward for basic filters.

#### 👎 Cons of NOT IN

* **Performance**: Can be slower on large datasets, as the engine may evaluate row-by-row. 🐌
* **NULL Handling**: If the subquery returns NULL, `NOT IN` may yield unexpected results. (Not an issue here since `visit_id` is non-NULL.)

---

## ✅ Conclusion

Both approaches correctly identify customers with visits that lack transactions:

* **LEFT JOIN … WHERE IS NULL** is generally more robust and performant for large/complex datasets.
* **NOT IN** offers concise, readable exclusion but requires caution regarding performance and NULLs.

In practice, **LEFT JOIN** is often the recommended default; however, understanding both patterns is essential for writing efficient, maintainable SQL.
