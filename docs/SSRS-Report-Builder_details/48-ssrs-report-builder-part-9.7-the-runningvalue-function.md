# SSRS Report Builder Part 9.7 — The RunningValue Function

Back to playlist

`RunningValue` computes a cumulative aggregate over a specified scope. It's commonly used for running totals within groups or the whole dataset.

Syntax
- `=RunningValue(expression, function, scope)`
  - `expression`: the field or expression to accumulate (e.g. `Fields!Amount.Value`).
  - `function`: aggregate function like `Sum`, `Count`.
  - `scope`: group name or dataset; `Nothing` uses the current scope.

Examples
- Running sum across dataset:
  `=RunningValue(Fields!Amount.Value, Sum, Nothing)`
- Running sum per group:
  `=RunningValue(Fields!Amount.Value, Sum, "CategoryGroup")`

Notes
- RunningValue restarts when the scope changes.
- It's computed at render time and can be expensive if used on many rows.

Formatting
- Apply number formatting as usual, e.g. `=FormatCurrency(RunningValue(...))` or set the textbox `Format` property.

Common pitfalls
- Using RunningValue in headers: headers often evaluate before the row-level context — prefer to place running totals in detail cells or footers.
- If you need a previous-row value, use `Previous()` instead of RunningValue.

Performance
- For large datasets, consider calculating running totals in SQL using window functions (e.g., `SUM(...) OVER (ORDER BY ...)`) and return the precomputed running total.

# SSRS Report Builder Part 9.7 - The RunningValue Function

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>