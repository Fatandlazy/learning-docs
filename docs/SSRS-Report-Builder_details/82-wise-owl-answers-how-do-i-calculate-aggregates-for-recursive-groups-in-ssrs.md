# Wise Owl Answers - How do I calculate aggregates for recursive groups in SSRS?

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>

[Watch on YouTube](https://youtu.be/1oDvO0ouwfM)

This note covers calculating aggregates for recursive (hierarchical) groups in SSRS — for example aggregating values up a parent/child tree such as account hierarchies or organizational charts.

Understanding recursive groups
- A recursive group displays hierarchical data using a self-join (ParentID/ID). Aggregating correctly requires choosing whether you need a leaf-level sum, a running total per branch, or totals rolled up to each parent.

Approaches

1) Pre-calculate aggregates in SQL (recommended)
- Use a recursive CTE or hierarchical SQL to compute rollups on the server. This is the most reliable and performant approach for complex hierarchies.

Example (SQL Server recursive CTE):

```sql
;WITH Hierarchy AS (
	SELECT Id, ParentId, Value
	FROM Items
	WHERE ParentId IS NULL
	UNION ALL
	SELECT i.Id, i.ParentId, i.Value
	FROM Items i
	JOIN Hierarchy h ON i.ParentId = h.Id
)
SELECT Id, ParentId, SUM(Value) OVER (PARTITION BY Id) AS TotalValue
FROM Hierarchy
```

2) Use report-level aggregates with careful scope
- If you cannot pre-calculate, use `Sum()` with the appropriate grouping scope to aggregate values within a group. However, SSRS does not directly provide recursive aggregation helpers — expression complexity grows quickly for deep hierarchies.

3) Use custom code to accumulate values during rendering (advanced)
- In Report Properties → Code, add VB functions to store and retrieve running totals keyed by group. Call these functions in the row expressions. This is fragile and may fail with pagination, sorting, or interactive features; prefer server-side rollups.

Practical guidance
- For reports with deep or large hierarchies, do rollups in SQL (CTE, groupings, or specialized hierarchy functions).
- For shallow hierarchies or small datasets, you can sometimes compute parent totals by grouping at the parent level and summing child values with expressions, but this is error-prone.

Tips
- Always prefer server-side aggregation for correctness and performance.
- If you must use report expressions, test with various hierarchy depths and consider adding unit testing data to validate rollups.

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>
