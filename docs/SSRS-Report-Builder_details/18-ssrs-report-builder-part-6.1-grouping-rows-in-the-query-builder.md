# SSRS Report Builder Part 6.1 — Grouping rows in the Query Builder

Back to playlist

This page explains how to group rows at the SQL/query level using Report Builder's Query Designer (Query Builder) and when it makes sense to do grouping in the query versus inside the report (tablix). It includes examples of GROUP BY, aggregate functions, and some alternatives (window functions).

Why group in the query?
- **Reduce data sent to the report**: GROUP BY in SQL returns aggregated rows (one row per group), which reduces network traffic and client-side processing.
- **Leverage the DB engine**: Databases are optimized for aggregation and can use indexes and query plans to compute totals efficiently.
- **Simpler report layout**: If you only need aggregated results (totals, counts, sums), a query-level aggregation lets the report present a simple table without grouping complexity.

When to group in the report instead
- **You need detail rows plus group headers**: If the report must show raw rows and also group subtotals and collapsible groups, do grouping in the tablix.
- **Complex interactive behaviours**: Toggles, recursive groups, or advanced running-value calculations are easier/only possible at report level.

Using the Query Builder in Report Builder
1. Open Report Builder and create or edit a dataset.
2. Click `Query Designer` → `Design Query in the Query Builder` (or edit the text if you prefer hand-writing SQL).
3. Add the fields you want to select. Switch to the `Grouping`/`Aggregate` view if available in your Report Builder version.
4. Use `GROUP BY` fields for grouping columns and add aggregates like `SUM`, `COUNT`, `AVG` for measure columns.

Example: Sales by Product Category
```sql
SELECT
    c.CategoryName,
    COUNT(od.OrderID) AS OrdersCount,
    SUM(od.Quantity * od.UnitPrice * (1 - od.Discount)) AS TotalSales,
    AVG(od.UnitPrice) AS AvgUnitPrice
FROM
    dbo.OrderDetails od
    JOIN dbo.Products p ON od.ProductID = p.ProductID
    JOIN dbo.Categories c ON p.CategoryID = c.CategoryID
GROUP BY
    c.CategoryName
ORDER BY
    TotalSales DESC;
```

Notes on parameters and query-level grouping
- If your dataset uses parameters (e.g., @StartDate, @EndDate), reference them in the WHERE clause before grouping.
- For multi-value parameters, use appropriate SQL constructs (join tables, use IN(), or table-valued parameters if supported) so the DB performs filtering prior to grouping.

Alternatives & advanced patterns
- **Window functions (OVER)**: If you need both detail rows and aggregate values per group (for example show each row and the group total), use window functions instead of pre-aggregation.
  Example:
  ```sql
  SELECT
      p.ProductID,
      p.ProductName,
      c.CategoryName,
      od.Quantity,
      SUM(od.Quantity * od.UnitPrice) OVER (PARTITION BY c.CategoryName) AS CategoryTotal
  FROM OrderDetails od
  JOIN Products p ON od.ProductID = p.ProductID
  JOIN Categories c ON p.CategoryID = c.CategoryID
  ```
- **UNION / UNION ALL**: For combining aggregated rows with other sets, use UNION carefully; ordering and column consistency matter.
- **Stored procedures / TVFs**: If aggregation logic is complex, encapsulate it in a stored proc or table-valued function and call it from the dataset.

Performance tips
- Push as much filtering as possible into the WHERE clause before grouping.
- Ensure appropriate indexes exist on join and group-by columns.
- Avoid SELECT *; explicitly select only needed columns.

Troubleshooting
- If the Query Builder shows an error about non-aggregated columns, ensure all non-aggregated selected columns appear in the GROUP BY clause or are wrapped in aggregates.
- If results are unexpectedly large: check WHERE filters and parameter binding.

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>