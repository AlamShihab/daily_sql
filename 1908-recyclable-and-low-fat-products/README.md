<h2><a href="https://leetcode.com/problems/recyclable-and-low-fat-products">Recyclable and Low Fat Products</a></h2> <img src='https://img.shields.io/badge/Difficulty-Easy-brightgreen' alt='Difficulty: Easy' /><hr><p>Table: <code>Products</code></p>

<pre>
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| product_id  | int     |
| low_fats    | enum    |
| recyclable  | enum    |
+-------------+---------+
product_id is the primary key (column with unique values) for this table.
low_fats is an ENUM (category) of type (&#39;Y&#39;, &#39;N&#39;) where &#39;Y&#39; means this product is low fat and &#39;N&#39; means it is not.
recyclable is an ENUM (category) of types (&#39;Y&#39;, &#39;N&#39;) where &#39;Y&#39; means this product is recyclable and &#39;N&#39; means it is not.</pre>

<p>&nbsp;</p>

<p>Write a solution to find the ids of products that are both low fat and recyclable.</p>

<p>Return the result table in <strong>any order</strong>.</p>

<p>The result format is in the following example.</p>

<p>&nbsp;</p>
<p><strong class="example">Example 1:</strong></p>

<pre>
<strong>Input:</strong> 
Products table:
+-------------+----------+------------+
| product_id  | low_fats | recyclable |
+-------------+----------+------------+
| 0           | Y        | N          |
| 1           | Y        | Y          |
| 2           | N        | Y          |
| 3           | Y        | Y          |
| 4           | N        | N          |
+-------------+----------+------------+
<strong>Output:</strong> 
+-------------+
| product_id  |
+-------------+
| 1           |
| 3           |
+-------------+
<strong>Explanation:</strong> Only products 1 and 3 are both low fat and recyclable.
</pre>

**Product Selection: Comparing Conditional Filters vs. String Concatenation**

This repository demonstrates two approaches for querying the `Products` table to identify items that are both low in fat and have recyclable packaging. We compare the traditional boolean filter method against a string-based approach using `CONCAT()`.

---

## Problem Statement

Given a `Products` table with columns:

* `product_id` (INT)
* `low_fats` (CHAR(1)): 'Y' or 'N'
* `recyclable` (CHAR(1)): 'Y' or 'N'

Return the `product_id` of all products where both `low_fats` and `recyclable` are 'Y'.

---

## Solutions

### Option 1: String Concatenation

```sql
SELECT
    product_id
FROM Products
WHERE CONCAT(low_fats, recyclable) = 'YY';
```

**How it works:**

* Combines `low_fats` and `recyclable` into a two-character string.
* Compares the result against the literal `'YY'`.

**Pros:**

* **Single comparison:** MySQL can often optimize a single string comparison more efficiently than multiple boolean checks.
* **Concise syntax:** Reduces verbosity by avoiding repetitive `AND` clauses.

**Cons:**

* Introduces a minor string‑concatenation step, which may have negligible overhead in small datasets.

---

### Option 2: Boolean AND

```sql
SELECT
    product_id
FROM Products
WHERE low_fats = 'Y'
  AND recyclable = 'Y';
```

**How it works:**

* Evaluates two separate conditions (`low_fats = 'Y'` and `recyclable = 'Y'`).
* Combines results via the `AND` operator.

**Pros:**

* **Readability:** Expresses intent directly—check each flag independently.
* **Index-friendly:** If individual columns are indexed, MySQL can leverage separate indexes for each predicate.

**Cons:**

* **Multiple evaluations:** Evaluates two boolean expressions per row.
* **Slightly more verbose:** Increased code length and repetition.

---

## Performance Considerations

| Metric                      | CONCAT Approach    | Boolean AND Approach |
| --------------------------- | ------------------ | -------------------- |
| Number of comparisons       | 1 (string)         | 2 (boolean)          |
| Execution plan complexity   | Lower              | Slightly higher      |
| Potential index utilization | No (concatenation) | Yes (per-column)     |
| Readability                 | Medium             | High                 |

> **Note:** On small tables or infrequent queries, the performance difference is negligible. For large-scale OLAP workloads, reducing the number of evaluated expressions can yield marginal gains.

---

## Recommendation

* Use **Option 1** (string concatenation) when striving for concise queries and when working with homogeneous, low-cardinality flag columns.
* Use **Option 2** (boolean AND) when clarity is paramount or when individual columns are separately indexed and performance profiling favors per‑column filtering.

---

## License

This code is released under the MIT License. Feel free to use and adapt it for your own analytics queries.


