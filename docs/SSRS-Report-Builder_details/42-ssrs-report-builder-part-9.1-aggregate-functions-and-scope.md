# SSRS Report Builder Part 9.1 — Aggregate Functions and Scope

Back to playlist

Aggregate functions compute summary values. Common aggregates: `Sum`, `Avg`, `Count`, `Min`, `Max`, `First`, `Last`.

Syntax and scope
- `=Sum(Fields!Amount.Value)` — default scope is the innermost containing scope.
- To specify scope explicitly: `=Sum(Fields!Amount.Value, "CategoryGroup")` where "CategoryGroup" is the group name in the Row Groups pane.

Common aggregates
- `Sum(expr, scope)`: total of `expr` in `scope`.
- `Avg(expr, scope)`: average of `expr` in `scope`.
- `Count(expr|Nothing, scope)`: number of rows (CountRows() counts rows in scope).
- `Min`, `Max`: minimum and maximum values in scope.

Scope rules
- Scopes can be dataset names, data region names, or group names.
- If you use `Nothing` as scope (or omit scope), SSRS uses the current (innermost) scope.

Examples
- Grand total across dataset: `=Sum(Fields!Sales.Value, "DataSet1")`
- Subtotal in category group: `=Sum(Fields!Sales.Value, "CategoryGroup")`
- Count rows in group: `=CountRows("CategoryGroup")`

Using aggregates in expressions
- Combine aggregates with formatting: `=FormatCurrency(Sum(Fields!Sales.Value, "CategoryGroup"))`
- When nesting aggregates be careful: SSRS does not allow aggregate of aggregate directly; compute aggregate at proper scope or use custom code/SQL.

Performance tips
- Push heavy aggregation to SQL when possible for large datasets.

Troubleshooting
- #Error in aggregate: check the scope name and ensure the field type matches the function (eg numeric for `Sum`).

# SSRS Report Builder Part 9.1 - Aggregate Functions and Scope

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>