# SSRS Report Builder Part 10.4 — Optional Report Parameters

Back to playlist

Making parameters optional allows users to run the report without selecting a value or to use a special behaviour (e.g., show all values). SSRS supports optional parameters by allowing `Null` or using multi-value parameters with an "All" option.

Allow Null values
- When creating the parameter, check `Allow null value`.
- In dataset queries, write logic that handles NULLs. Example T-SQL:
  `WHERE (@CategoryID IS NULL OR CategoryID = @CategoryID)`

Use an "All" option for multi-value parameters
- Provide a dataset for the parameter values that includes an `All` row (for example with value `-1` or blank). In the dataset query, treat `All` specially:
  `WHERE (@CategoryID = -1 OR CategoryID = @CategoryID)`

Filter logic in report vs query
- Prefer query-side handling for performance. When using dataset filters in the report, note that the full dataset still loads.

Handling empty or missing parameters in expressions
- Use `IsNothing(Parameters!MyParam.Value)` to detect NULLs in expressions.

Examples
- Optional date range: allow `StartDate` to be null and `WHERE (@StartDate IS NULL OR OrderDate >= @StartDate)` in SQL.

Troubleshooting
- When `Allow null` is set, ensure parameter type matches and report server is not enforcing default empty values via URL or subscription.

TODO: Add detail notes for this tutorial.

Back to playlist