# SSRS Report Builder Part 9.9 — The Previous() Function

Back to playlist

`Previous()` returns the previous value of an expression in the current scope. It's useful for comparing a row to the prior row (for example, detecting changes or calculating differences).

Syntax
- `=Previous(Fields!Amount.Value)`

Examples
- Difference from previous row:
  `=Fields!Amount.Value - Previous(Fields!Amount.Value)`

Scope and behavior
- `Previous()` works within the current scope (detail or group). At the first row of the scope it returns `Nothing`.
- Protect against `Nothing`: `=IIF(IsNothing(Previous(Fields!Amount.Value)), 0, Fields!Amount.Value - Previous(Fields!Amount.Value))`

Common uses
- Detect changes in a sorted list: compare current and previous grouping keys to insert separators or change formatting.
- Calculate deltas (current - previous) for trend indicators.

Limitations
- `Previous()` depends on rendering order — ensure the dataset is sorted appropriately in the region before relying on Previous for comparisons.

Performance
- `Previous()` is computed at render time and is cheap for small lists; for large datasets or complex windows prefer SQL window functions (LAG) to return deltas.

Troubleshooting
- `#Error` if used outside a data region or when the expression contains `Nothing` and not guarded. Use `IsNothing` checks.

# SSRS Report Builder Part 9.9 - The Previous Function

TODO: Add detail notes for this tutorial.

Back to playlist

Back to playlist