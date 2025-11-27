# SSRS Report Builder Part 9.11 — Creating SUMIF / COUNTIF / AVERAGEIF Expressions

Back to playlist

SSRS doesn't have Excel-style SUMIF/COUNTIF functions, but you can achieve the same results using `Sum`/`Count` with `IIF`, by using `RunningValue`/`Scope`, or by pre-aggregating in SQL.

Common patterns

- SUMIF equivalent:
  `=Sum(IIF(Fields!Category.Value = "A", Fields!Amount.Value, 0))`

- COUNTIF equivalent:
  `=Sum(IIF(Fields!Status.Value = "Open", 1, 0))`

- AVERAGEIF equivalent:
  `=IIF(Sum(IIF(Fields!Category.Value = "A", 1, 0)) = 0, Nothing, Sum(IIF(Fields!Category.Value = "A", Fields!Amount.Value, 0)) / Sum(IIF(Fields!Category.Value = "A", 1, 0)))`

Using scopes
- To restrict to a group or dataset, include the scope argument: `Sum(IIF(...), "CategoryGroup")`.

Performance tips
- For large datasets, perform conditional aggregation in SQL: `SUM(CASE WHEN Category = 'A' THEN Amount ELSE 0 END)`.

Edge cases
- Nulls: guard `Fields!Amount.Value` with `IsNothing` or use `CDec` and default values inside the `IIF`.

Examples
- Sum of sales for current category group:
  `=Sum(IIF(Fields!Category.Value = Fields!Category.Value, Fields!Sales.Value, 0), "CategoryGroup")`

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>