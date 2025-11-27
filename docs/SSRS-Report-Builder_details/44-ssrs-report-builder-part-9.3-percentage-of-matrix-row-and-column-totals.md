# SSRS Report Builder Part 9.3 — Percentage of Matrix Row and Column Totals

Back to playlist

In a matrix (cross-tab), you may want to show each cell as a percentage of its row total (row-wise percent) or column total (column-wise percent).

Row-wise percentage (percent of row total)
- Use the row group scope in the denominator. Example data cell expression:
  `=IIF(Sum(Fields!Sales.Value, "RowGroup") = 0, 0, Sum(Fields!Sales.Value) / Sum(Fields!Sales.Value, "RowGroup"))`
  - `Sum(Fields!Sales.Value)` here is the cell aggregate (current row+column intersection scope).

Column-wise percentage (percent of column total)
- Use the column group scope in the denominator:
  `=IIF(Sum(Fields!Sales.Value, "ColumnGroup") = 0, 0, Sum(Fields!Sales.Value) / Sum(Fields!Sales.Value, "ColumnGroup"))`

Formatting
- Set `Format` to `P1` or `P2` for percent display, or wrap with `FormatPercent(...)`.

Scope names
- Replace `RowGroup` and `ColumnGroup` with the actual group names displayed in the Row Groups and Column Groups panes.

Handling totals
- For matrix totals, SSRS calculates totals automatically but you may need custom expressions for percent-of-total cells. Use explicit scope names to reference the desired totals.

Performance tip
- If there are many dynamic columns, calculate totals in SQL or a pre-aggregated dataset to reduce report renderer work.

Troubleshooting
- Blank or zero denominators: verify dataset returns expected rows for the group keys and guard against zero totals.

# SSRS Report Builder Part 9.3 - Percentage of Matrix Row and Column Totals

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>