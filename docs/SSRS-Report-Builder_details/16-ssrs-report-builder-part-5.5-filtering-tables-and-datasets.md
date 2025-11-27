# SSRS Report Builder Part 5.5 - Filtering Tables and Datasets

Back to playlist

Purpose: Explain the difference between filtering at the database (dataset query) and filtering in the report (dataset filters, tablix/group filters and report-level filters), how to implement parameter-driven filtering, and performance best practices.

1) Filtering at the source (recommended for performance)
- The most efficient place to filter is in the dataset query (SQL `WHERE` clause) because the database engine can use indexes and return only the rows you need.
- Example:

```
SELECT OrderID, OrderDate, CustomerID, Total
FROM dbo.Orders
WHERE OrderDate BETWEEN @StartDate AND @EndDate
```

- Use query parameters to pass values from Report Parameters to the dataset so filtering occurs on the server.

2) Dataset properties: Filters tab
- Report Builder provides a `Filters` tab on Dataset Properties where you can add filter expressions. These filters run in the report processor after the dataset has been fetched.
- Example: filter on dataset for small further filtering:
  - Expression: `=Fields!Status.Value`
  - Operator: `=`
  - Value: `="Active"`

- Note: Dataset filters are useful for quick, small adjustments or when you cannot change the original SQL. They are less efficient for large datasets because all rows are returned first.

3) Tablix / Group Filters
- You can add filters at the tablix level (affects the whole data region) or at a group level (affects only rows in that group). Right-click the tablix/group → `Group Properties` → `Filters`.
- Example: show only customers with total > 1000 at group level:
  - Expression: `=Sum(Fields!Total.Value)`
  - Operator: `>`
  - Value: `=1000`

4) Report-level filters and interactive filtering
- You can also use report parameters and expressions to show/hide items dynamically. This is a presentation-layer filter and does not reduce rows returned from the dataset.

5) Parameter-driven filtering: passing parameters to dataset vs. using report filters
- Preferred: pass parameters into the dataset query via dataset parameters. This has best performance because SQL Server filters rows.
- Alternative: fetch a broader dataset and use report filters to limit displayed rows. Use only for small resultsets.

6) Cascading filters and parameter defaults
- When implementing cascading filters (e.g., Country -> State -> City), do the filtering at the dataset level using parameterized queries for each parameter. Populate parameter available values using queries that depend on parent parameters.

7) Handling nulls and data types
- Ensure parameters and filter values match data types. Use `CDate`, `CInt`, etc., in expressions when necessary.
- For null-safe comparisons, use expressions like `=IIf(IsNothing(Fields!X.Value), "", Fields!X.Value)`.

8) Performance considerations
- Push filtering logic to the database where possible. For very large datasets, report-level filters can cause memory/CPU pressure on the report server.
- If you need complex filtering that is expensive, consider building a stored procedure or view that pre-filters and optimizes access patterns.

9) Examples
- SQL parameterized dataset example (preferred):

```
-- Dataset query
SELECT OrderID, OrderDate, CustomerID, Total
FROM dbo.Orders
WHERE (@CustomerID IS NULL OR CustomerID = @CustomerID)
  AND (@MinTotal IS NULL OR Total >= @MinTotal)
  AND (@StartDate IS NULL OR OrderDate >= @StartDate)
```

- Dataset filter example (report-side):
  - In Dataset Properties → Filters:
    - Expression: `=Fields!Category.Value`
    - Operator: `IN` (or `=`) and Value: `=Parameters!SelectedCategories.Value` (for multi-value parameter)

10) Multi-value parameters and filtering
- To pass multi-value parameters to a dataset query, some approaches:
  - Use a stored procedure that accepts a CSV string and parses it (or table-valued parameter if supported).
  - Build dynamic SQL carefully (beware SQL injection) or use TVP (recommended for performance/security).

11) Troubleshooting common problems
- Filter has no effect: check expression scope and that the field referenced exists in the dataset scope.
- Performance slow: move filters into the dataset SQL and check execution plan and indexes.
- Parameter mismatch: confirm Report Parameter type matches DB type and that you mapped dataset parameters correctly (Dataset Properties → Parameters).

12) Best practices
- Always prefer server-side filtering (SQL WHERE or SP) for large datasets.
- Use report-side filters only for small resultsets or when you cannot change the source query.
- Document parameter types and default values; use sensible defaults to avoid returning excessively large datasets.
- For multi-value parameter passing, prefer TVPs or stored procedures over string splitting when possible.

Would you like me to continue to `17-ssrs-report-builder-part-56-or-filters-in-tables-and-datasets.md` or add screenshots/placeholders to this page? Choose one and I'll continue.
# SSRS Report Builder Part 5.5 - Filtering Tables and Datasets

TODO: Add detail notes for this tutorial.

Back to playlist

Back to playlist