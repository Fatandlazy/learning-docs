# SSRS Report Builder Part 10.5 — Optional Parameters (Advanced)

Back to playlist

This page expands on optional-parameter patterns: implementing an `All` option, expression-based defaults, hidden/internal parameters, and correctly handling empty multi-value inputs.

1) Implement an `All` option (recommended for multi-value lists)
- Create a parameter dataset that returns the real values plus a synthetic `All` row. Example (T-SQL):

  SELECT -1 AS CategoryID, '(All categories)' AS CategoryName
  UNION ALL
  SELECT CategoryID, CategoryName FROM dbo.Categories ORDER BY CategoryName

- Set the parameter to be multi-value and supply this dataset as `Available Values`.
- In your report dataset, check for the `All` marker:

  WHERE ((@CategoryID = -1) OR (CategoryID IN (@CategoryID)))

2) Expression-based defaults
- You can use expressions to set default parameter values. Example: set a default date to the first day of the current month:

  =DateSerial(Year(Today()), Month(Today()), 1)

- For multi-value defaults, return an array using `Split` or a `Parameter.DefaultValues` dataset. Example expression to default to two values:

  =Split("1,2", ",")

3) Hidden and Internal parameters
- `Hidden` parameters are not shown in the parameter area but can be set by URL, subscriptions, or default expressions.
- `Internal` parameters are only visible inside the report (not set from URL/subscription) and are useful for intermediate calculations or to hold transformed values.

4) Handling empty multi-value parameters (no user selection)
- If your parameter allows multiple selections but the user leaves it blank, `Parameters!MyParam.Count` is 0. Use expressions or query logic to treat that as `All`:

  WHERE ((Parameters!MyParam.Count = 0) OR (CategoryID IN (@MyParam)))

- When using IN (@MyParam) with no selections, server-side SQL may fail — prefer explicit conditional logic or pass a sentinel value.

5) Performance and dataset size
- Prefer handling optional logic in the data source (SQL) to reduce data sent to the report server.
- Avoid loading very large parameter datasets into the report parameter UI; consider paging or pre-filtering with a text search parameter.

6) Examples
- Optional date filter (T-SQL):

  WHERE (@StartDate IS NULL OR OrderDate >= @StartDate)
  AND   (@EndDate IS NULL OR OrderDate <= @EndDate)

- Optional multi-value with sentinel `-1`:

  WHERE (@CategoryID = -1 OR CategoryID IN (@CategoryID))

7) Troubleshooting
- If your report shows no rows when you expect all rows: check whether the parameter default is actually `NULL`, empty string, or a sentinel value—each requires different handling in SQL or expressions.
- If `Allow null` does not appear to work, verify dataset query parameter types and that the Report Server isn't injecting defaults via URL or subscriptions.

Back to playlist