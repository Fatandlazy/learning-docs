# SSRS Report Builder Part 9.5 — Highlight Min and Max Values in a Matrix

Back to playlist

Highlighting min and max values in a matrix (cross-tab) is similar to tables but you often need to consider both row and column scopes when deciding which total to compare against.

Examples
- Highlight cell equal to the minimum for its row (RowGroup):
  - `BackgroundColor` expression on the data cell:
    `=IIF(Sum(Fields!Sales.Value) = Min(Fields!Sales.Value, "RowGroup"), "#DFF0D8", "Transparent")`
  - Here `Sum(Fields!Sales.Value)` is the cell aggregate at the intersection of current row+column.

- Highlight cell equal to the maximum for its column (ColumnGroup):
  - `=IIF(Sum(Fields!Sales.Value) = Max(Fields!Sales.Value, "ColumnGroup"), "#F2DEDE", "Transparent")`

Notes
- Replace `RowGroup` and `ColumnGroup` with the actual group names visible in the Row/Column Groups panes.
- For tied min/max values, all matching cells are highlighted.
- When comparing floating point numbers, consider rounding: `=IIF(Round(Sum(Fields!Sales.Value),2) = Round(Min(Fields!Sales.Value, "RowGroup"),2), ...)`

Performance
- Min/Max computations across groups are handled by the engine but can be expensive for very large, highly-dynamic matrices. Consider pre-calculating totals in SQL or a pre-aggregated dataset.

Troubleshooting
- `#Error` or unexpected results: verify the group names, ensure the cell expression uses `Sum(...)` if the intersection is aggregated, and guard against `Nothing` values.

# SSRS Report Builder Part 9.5 - Highlight Min and Max Values in a Matrix

TODO: Add detail notes for this tutorial.

Back to playlist

Back to playlist