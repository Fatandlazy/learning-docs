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
- When implementing cascading filters (for example, Country -> State -> City), perform filtering at the dataset level using parameterized queries for each level. Populate the available values for child parameters by running queries that depend on the selected parent parameter(s). This keeps datasets small and avoids unnecessary round-trips.

7) Handling nulls and data types
- Match data types: ensure Report Parameter types match the database column types (e.g., DateTime, Integer, Text). In dataset parameters mapping, map `@StartDate` to `=Parameters!StartDate.Value` (type DateTime) rather than a string.
- SQL-side null handling: write queries that tolerate NULL parameter values so the same dataset works for optional parameters. Example:

```sql
WHERE (@StartDate IS NULL OR OrderDate >= @StartDate)
  AND (@EndDate IS NULL OR OrderDate <= @EndDate)
```

- Report expression null-safety: in report expressions use `IsNothing` or the `IIf` pattern to avoid runtime errors and to provide defaults. Examples:

- `=IIf(IsNothing(Fields!X.Value), "", Fields!X.Value)`  -- returns empty string when NULL.
- `=IIf(IsNothing(Parameters!StartDate.Value), Today(), Parameters!StartDate.Value)`  -- use Today() when parameter is missing.
- Use type converters when coercion is necessary: `CDate(...)`, `CInt(...)`, `CDbl(...)`.

8) Performance considerations
- Push filtering logic to the database where possible. For very large datasets, report-side filters (dataset, tablix or group filters) will consume report server memory and CPU because the engine must load and process all returned rows.
- For complex or expensive filters, encapsulate them in a stored procedure or view and return only the rows needed by the report. This also simplifies query plan tuning and index usage.

9) Examples
- SQL parameterized dataset example (preferred):

```sql
-- Dataset query (handles optional parameters)
SELECT OrderID, OrderDate, CustomerID, Total
FROM dbo.Orders
WHERE (@CustomerID IS NULL OR CustomerID = @CustomerID)
  AND (@MinTotal IS NULL OR Total >= @MinTotal)
  AND (@StartDate IS NULL OR OrderDate >= @StartDate)
  AND (@EndDate IS NULL OR OrderDate <= @EndDate);
```

- Dataset filter example (report-side):
  - In Dataset Properties → Filters:
    - Expression: `=Fields!Category.Value`
    - Operator: `In`
    - Value: `=Parameters!SelectedCategories.Value`  (works when `SelectedCategories` is a multi-value parameter)

  Note: Using the `In` operator in dataset/tablix filters compares each row's field to the set of values in the multi-value parameter. This still requires the dataset to be fetched in full first, so prefer server-side filtering when possible.

10) Multi-value parameters and filtering
- Recommended approaches to handle multi-value parameters:
  - Table-Valued Parameter (TVP) — best for performance and security (SQL Server): create a user-defined table type and a stored procedure that accepts the TVP. From Report Builder set the dataset type to Stored Procedure and map the parameter to the TVP.

  Example: TVP approach (SQL Server)

  ```sql
  -- Create a table type (run once on the DB)
  CREATE TYPE dbo.IdList AS TABLE (Id INT);

  -- Stored procedure using TVP
  CREATE PROCEDURE dbo.GetOrdersByCustomerIds
    @Ids dbo.IdList READONLY
  AS
  BEGIN
    SELECT o.*
    FROM dbo.Orders o
    JOIN @Ids i ON o.CustomerID = i.Id;
  END
  ```

  In Report Builder you call `dbo.GetOrdersByCustomerIds` and map the dataset parameter to a TVP value (Report Builder support for TVP depends on your data provider and server configuration; if TVP is not available, use the STRING_SPLIT approach below).

  - CSV / STRING_SPLIT approach — simpler but less efficient/security-conscious. Use a stored procedure that accepts a delimited string and uses `STRING_SPLIT` (SQL Server 2016+) to parse it. Beware SQL injection and ensure input is sanitized.

  Example: CSV approach

  ```sql
  CREATE PROCEDURE dbo.GetOrdersByCustomerCsv
    @CustomerCsv NVARCHAR(MAX)
  AS
  BEGIN
    SELECT o.*
    FROM dbo.Orders o
    JOIN (SELECT TRY_CAST(value AS INT) AS Id FROM STRING_SPLIT(@CustomerCsv, ',') WHERE TRY_CAST(value AS INT) IS NOT NULL) s
      ON o.CustomerID = s.Id;
  END
  ```

  In Report Builder, join multi-value parameter values into a CSV using an expression like `=Join(Parameters!SelectedCustomers.Value, ",")` and map it to `@CustomerCsv`.

  - Avoid building ad-hoc dynamic SQL from untrusted inputs. Prefer parameterized TVPs or stored procedures to reduce injection risk and improve query plans.

11) Troubleshooting common problems
- Filter has no effect:
  - Confirm the filter is on the correct scope (Dataset vs Tablix vs Group). A dataset-level filter runs after the dataset is fetched; a group filter affects rows in that group only.
  - Ensure the field referenced exists in the scope you're filtering (use `Fields!FieldName.Value` only when the dataset contains that field).
  - For multi-value parameters, verify you used `In` and provided the parameter as a multi-value parameter (not a single concatenated string) when using report-side filters.

- Parameter mapping problems:
  - In Dataset Properties → Parameters, map dataset parameter names (e.g., `@StartDate`) to report expressions (e.g., `=Parameters!StartDate.Value`).
  - Preview the dataset in Report Builder and supply parameter values to see the raw query result.

- Performance issues:
  - Use SQL Server execution plans and statistics to identify missing indexes or slow predicates.
  - If filters are applied in the report, check memory and execution time on the report server.

- Data type or null errors:
  - Ensure Report Parameter types match DB types. If passing dates, use DateTime report parameters.
  - Use `IsNothing()` checks in expressions to avoid runtime errors.

- If still stuck, enable remote errors or check the Report Server trace logs for detailed failure messages.

12) Best practices
- Always prefer server-side filtering (SQL WHERE or SP) for large datasets.
- Use report-side filters only for small resultsets or when you cannot change the source query.
- Document parameter types and default values; use sensible defaults to avoid returning excessively large datasets.
- For multi-value parameter passing, prefer TVPs or stored procedures over string splitting when possible.

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>