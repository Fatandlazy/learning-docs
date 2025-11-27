# SSRS Report Builder Part 5.6 - OR Filters in Tables and Datasets

Back to playlist

Purpose: Explain how to implement `OR` filters in SSRS/Report Builder at the dataset (SQL) and report (dataset/tablix/group) levels, the performance implications of `OR` conditions, and recommended alternatives (IN, UNION, TVP, parameterized queries) with examples.

1) OR in dataset SQL (preferred when possible)
- Filtering in the dataset query keeps work on the database engine and is generally the most efficient approach. Example:

```
SELECT OrderID, OrderDate, CustomerID, Total
FROM dbo.Orders
WHERE Status = 'Open' OR Status = 'Pending'
```

- When `OR` combines columns (e.g. `ColA = @p OR ColB = @q`), the query optimizer may not use indexes effectively. Test execution plans and consider alternatives below.

2) Use `IN` for single-column multiple values
- Replace `OR` chains on the same column with `IN` for clarity and often better plans:

```
-- instead of: WHERE Status = 'Open' OR Status = 'Pending' OR Status = 'Closed'
WHERE Status IN ('Open','Pending','Closed')
```

3) Use `UNION`/`UNION ALL` as an alternative for complex OR logic
- For complex conditions that prevent index usage, break the query into multiple SELECTs and combine with `UNION ALL` (if duplicates are acceptable) to allow each SELECT to use an index:

```
SELECT ... FROM dbo.Orders WHERE ColA = @p
UNION ALL
SELECT ... FROM dbo.Orders WHERE ColB = @q;
```

4) Table-Valued Parameters (TVP) or temporary tables for multi-value filtering
- For multi-value parameters (e.g., user selects many categories), prefer TVP (SQL Server) or a staging temp table rather than building large OR chains or CSV parsing.

5) Report-level OR filters (dataset/tablix/group filters)
- You can add filters in Report Builder (Dataset Properties → Filters, Group Properties → Filters). Those are applied after the dataset is returned and run in the report processor — use for small resultsets or when you cannot modify SQL.
- Example report-side filter expression combining OR logic:
  - Expression: `=Fields!Status.Value` Operator: `=` Value: `=Parameters!Status1.Value`
  - But for multiple OR conditions, you often use an expression with IIf or InStr, or check multiple conditions in a single expression: `=Fields!Status.Value = "Open" OR Fields!Priority.Value = "High"`

6) Parameter handling and multi-value parameters
- For multi-value parameters in report-side filters, you can use `Join(Parameters!MyParam.Value, ",")` in an expression, but this is inefficient server-side. Prefer passing multi-value selections to the dataset via TVP or stored procedure.

7) NULL-safe comparisons and OR
- Be careful with NULLs: `Col = @p OR Col IS NULL` must be explicit; use `ISNULL(Col,'') = ISNULL(@p,'')` or appropriate NULL handling in SQL.

8) Performance considerations and testing
- Always prefer server-side filtering; `OR` that spans multiple columns may cause full table scans.
- Check execution plans in SSMS. If the plan shows index scans instead of seeks, try rewriting queries using `IN`, `UNION ALL` or TVP.
- For large datasets, report-side `OR` filters can cause memory and CPU pressure on the report server — avoid them.

9) Examples

-- Example 1: multiple values on same column (use IN)
```
SELECT * FROM dbo.Products
WHERE CategoryID IN (1,2,3)
```

-- Example 2: OR across columns — use UNION ALL for better index use
```
SELECT OrderID, OrderDate FROM dbo.Orders WHERE CustomerID = @CustomerID
UNION ALL
SELECT OrderID, OrderDate FROM dbo.Orders WHERE SalesRepID = @SalesRepID
```

-- Example 3: Passing multi-value parameter to stored procedure (recommended for complex filters)
```
CREATE PROCEDURE dbo.GetOrdersByCategories @CategoryIDs dbo.IdList READONLY
AS
SELECT * FROM dbo.Orders o
JOIN @CategoryIDs c ON o.CategoryID = c.Id;
```

10) Troubleshooting common issues
- OR has no effect or returns unexpected rows: check precedence with parentheses and NULL handling.
- Query slow after adding OR: inspect execution plan, look for scans; try rewriting using IN/UNION/TVP.
- Report filter seems ignored: ensure filter expression references correct scope/field and that dataset contains expected rows.

11) Best practices summary
- Push filters to the database whenever possible.
- Prefer `IN` over long `OR` chains for the same column.
- Use `UNION ALL` to split complex OR logic so each branch can use indexes.
- For user multi-selects, use TVPs or stored procedures instead of building OR lists in SQL dynamically.
- When forced to use report-level OR filters, keep the dataset small and test report server resource usage.

Would you like me to continue to `18-ssrs-report-builder-part-61-grouping-rows-in-the-query-builder.md` or add annotated examples/screenshots for this page? Choose one and I'll proceed.
# SSRS Report Builder Part 5.6 - Or Filters in Tables and Datasets

TODO: Add detail notes for this tutorial.

Back to playlist

Back to playlist