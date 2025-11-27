
# SSRS Report Builder — Part 4.6: Using Stored Procedures as Datasets

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>

Objective: How to use Stored Procedures (SPs) as data sources for Datasets in Report Builder/SSRS. Covers benefits, parameter configuration, credentials/security, limitations, and troubleshooting.

1) Why use Stored Procedures?
- Stored Procedures are well suited for complex, multi-step query logic and advanced parameterization.
- Moving heavy logic to the database reduces report-side processing and can improve performance when the SP is optimized.

2) Create a Dataset that calls a Stored Procedure
- In Report Builder: `Data` → `Add Dataset` → name the dataset → set `Query type` to `Stored Procedure` (or in some versions set `Text` and use `EXEC dbo.MyStoredProcedure @Param1 = @Param1`).
- Choose a Data Source (embedded or shared) — the Data Source must have permission to execute the SP.

3) Mapping parameters
- When the SP defines parameters, Report Builder creates matching dataset parameters. You should:
  - Create corresponding Report Parameters (e.g., `StartDate`, `EndDate`).
  - In `Dataset Properties` → `Parameters`, map each SP parameter to an expression like `=Parameters!ParameterName.Value`.
- Note on output vs input parameters: SSRS supports input parameters for SPs; output parameters do not automatically become dataset columns — return a resultset (SELECT) from the SP to provide data to the report.

4) Multiple resultsets
- SSRS uses the first resultset returned by a Stored Procedure for the Dataset. If an SP returns multiple resultsets, only the first will be used — avoid returning multiple resultsets when the report expects a single tabular dataset.

5) Temp tables & session-scoped logic
- Using `#temp` tables inside the SP is fine because the SP executes in a single session. Avoid `GO` or multi-batch logic that splits session scope; keep the SP as a single batch.

6) Timeouts and performance
- Long-running SPs may require increased command timeout settings on the Data Source or SP optimization (indexes, query rewrite, pre-aggregated tables).

7) Security and permissions
- The user running the report needs `EXECUTE` permission on the Stored Procedure, or the Data Source should use Stored Credentials that have execute rights (for scheduled reports).
- Best practice: use a least-privilege account for stored credentials with only the necessary rights (SELECT, EXECUTE) on the DB.

8) Authentication: Stored Credentials vs Integrated Security
- With `Integrated Security`, the SP runs under the user's Windows account — ensure the account has the required DB permissions.
- With `Stored Credentials` on a Shared Data Source, the SP runs under the stored account — useful for scheduled/unattended reports.

9) Common troubleshooting
- SP returns no data: test the SP in SSMS with the same parameters.
- EXECUTE permission errors: verify the account (user or stored credentials) has EXECUTE on the SP.
- Parameter type mismatch: ensure Report Parameter types match the SP parameter types (Date, Int, etc.).
- Timeouts: inspect execution plans and optimize the SP.

10) Example

Stored Procedure:

```sql
CREATE PROCEDURE dbo.GetSales
  @StartDate DATE,
  @EndDate DATE,
  @TopN INT = 10
AS
BEGIN
  SET NOCOUNT ON;
  SELECT TOP (@TopN) CustomerID, SUM(Total) AS SalesTotal
  FROM dbo.Orders
  WHERE OrderDate BETWEEN @StartDate AND @EndDate
  GROUP BY CustomerID
  ORDER BY SalesTotal DESC;
END
```

In Report Builder: create a Dataset, choose the Stored Procedure `dbo.GetSales` → create Report Parameters `StartDate`, `EndDate`, `TopN` → map parameters to the dataset.

11) Best practices
- Return a single resultset for the report.
- Use Stored Procedures for heavy/complex logic to leverage database optimizations.
- Provide sensible default parameter values to avoid returning excessively large datasets when parameters are empty.

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>