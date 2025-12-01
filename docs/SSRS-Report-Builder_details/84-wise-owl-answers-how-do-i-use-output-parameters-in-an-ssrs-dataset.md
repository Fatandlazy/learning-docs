# Wise Owl Answers - How do I use output parameters in an SSRS dataset?

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>

[Watch on YouTube](https://youtu.be/GXZAeMgMTJM)

This note explains how to work with output parameters from stored procedures or queries in SSRS datasets. Output parameters let a stored procedure return scalar values (for example totals, status codes) in addition to result sets.

Can SSRS read output parameters?
- SSRS dataset types that execute stored procedures can receive return values and output parameters, but the Report Builder UI does not provide a direct, built-in way to map stored procedure output parameters to report parameters in all versions. The recommended approach is to return scalar values as part of the result set or use a second result set.

Approaches

1) Return output values as part of the result set (recommended)
- Modify the stored procedure to include the output values as additional columns in the main result set or a separate row. For example add `SELECT @TotalOrders AS TotalOrders` at the end, or include them in each row if appropriate.

2) Use a separate dataset to call the stored procedure for scalar outputs
- Create a second dataset that calls a stored procedure or a simple query returning the scalar values (for example `SELECT @TotalOrders AS TotalOrders`), and map the dataset field to a report parameter or textbox via `Fields!TotalOrders.Value`.

3) Using output parameters with shared data sources and custom code (advanced)
- Some advanced setups use custom data extensions or code to capture output parameters. This is not common and requires extra security and config on the report server.

Example: include scalar totals in the result

```sql
CREATE PROCEDURE dbo.GetOrdersAndTotals
	@StartDate DATE,
	@EndDate DATE
AS
BEGIN
	SELECT OrderID, OrderDate, Total
	FROM Orders
	WHERE OrderDate BETWEEN @StartDate AND @EndDate;

	-- Return scalar total as a second result set
	SELECT SUM(Total) AS GrandTotal
	FROM Orders
	WHERE OrderDate BETWEEN @StartDate AND @EndDate;
END
```

In SSRS you can create two datasets or configure one dataset to read the second result set depending on your data provider; often it's easier to add a separate dataset for the scalar values.

Tips
- Returning scalars in the result set is the most portable solution across SSRS versions and data providers.
- If you must rely on output parameters, test your data provider and SSRS version — behavior differs between providers (OLE DB, ODBC, SQLClient).

Security
- Stored procedures should validate inputs and avoid returning sensitive data unintentionally.

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>
