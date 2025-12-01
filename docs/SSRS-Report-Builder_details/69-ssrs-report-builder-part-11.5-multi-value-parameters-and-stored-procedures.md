# SSRS Report Builder Part 11.5 - Multi Value Parameters and Stored Procedures

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>

[Watch on YouTube](https://youtu.be/C1F7dkuAL4I)

This guide covers techniques for passing multi-value parameter selections from SSRS Report Builder into stored procedures on SQL Server.

Problem
- Stored procedures typically accept scalar parameters. When the report parameter allows multiple values, you must convert or pass those values in a way the stored procedure can consume.

Common approaches

1) Pass CSV string and split inside the stored procedure (simple and widely supported)
- In SSRS dataset parameter mapping, pass `=Join(Parameters!MyMultiParam.Value, ',')` to the stored procedure parameter (e.g., `@CategoryList` NVARCHAR).
- Inside the stored procedure, split the CSV into a table. SQL Server 2016+ can use `STRING_SPLIT`:

```sql
CREATE PROCEDURE dbo.GetOrdersByCategories
	@CategoryList NVARCHAR(MAX)
AS
BEGIN
	SET NOCOUNT ON;

	IF @CategoryList IS NULL OR @CategoryList = ''
	BEGIN
		SELECT * FROM Orders; -- no filtering
		RETURN;
	END

	SELECT o.*
	FROM Orders o
	WHERE o.CategoryID IN (
		SELECT TRY_CAST(value AS INT) FROM STRING_SPLIT(@CategoryList, ',')
	);
END
```

Notes:
- Use `TRY_CAST`/`TRY_CONVERT` to safely convert values.
- Be careful with delimiters and trimming spaces (you may want to `LTRIM(RTRIM(value))`).

2) Pass XML and parse inside the stored procedure
- Build an XML string in SSRS (or join values into XML) and pass it to the stored procedure. The proc can use `nodes()` and `value()` to extract values.

3) Use a table-valued parameter (TVP)
- TVPs are the cleanest server-side approach but require the client to send a table-valued parameter. SSRS does not natively support TVPs from the parameter UI, so TVPs are typically used when calling from custom code or an application layer. If you control the data access layer, TVPs are recommended.

4) Use temporary table or staging table (advanced)
- For very large lists, insert the values into a staging table via application code and have the stored procedure read them. This is not typical for straight SSRS parameter scenarios.

Example: SSRS mapping for CSV approach
- Dataset parameter `@CategoryList` → set Value to `=Join(Parameters!CategoryIDs.Value, ',')`.
- Dataset uses stored procedure `dbo.GetOrdersByCategories` with `@CategoryList` parameter.

Security and performance
- Avoid SQL injection: treat parameter values as data — when using CSV to build dynamic SQL inside the proc, use safe parsing and `TRY_CAST` and avoid concatenating unsanitized values into executable SQL.
- For large lists, splitting and joining can affect performance. Test and prefer TVPs or server-side filtering where possible.

Testing
- Test with no values (empty string), a single value, many values, and values with unexpected characters (commas, spaces).

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>
