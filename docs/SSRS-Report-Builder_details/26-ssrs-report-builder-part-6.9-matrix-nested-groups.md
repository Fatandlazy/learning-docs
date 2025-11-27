# SSRS Report Builder Part 6.9 — Matrix Nested Groups

Back to playlist

This page shows how to use nested row and column groups inside a matrix (cross-tab) to support multi-level cross-tab layouts (for example, Region → Country down the rows and Year → Quarter across columns).

When to use nested groups in a matrix
- You need multi-level aggregation on both axes (rows and columns).
- You want subtotals at intermediate levels (e.g., subtotal by Country inside Region).

Steps to create nested groups
1. Insert a Matrix and bind it to your dataset.
2. Add the top-level row group (e.g., `Region`), then add a child row group inside it (e.g., `Country`).
3. Similarly, set column groups: add the top-level column group (e.g., `Year`) then a child column group (e.g., `Quarter`).
4. Use aggregate expressions in the data cell (e.g., `=Sum(Fields!Sales.Value)`).

Subtotals and totals
- Matrix allows automatic subtotals: right-click a group → `Add Total` and choose `Before` or `After` as needed.
- Ensure totals use correct scope names when writing expressions manually: `=Sum(Fields!Sales.Value, "CountryGroup")`.

Layout considerations
- For many nested column groups, the matrix can become wide; consider collapsing quarters into months or filtering the dataset.
- Use formatting to indent row group headers for clarity.

Performance tips
- Pre-aggregate in SQL for very large datasets.
- Limit dynamic column cardinality using filters or rolling periods.

Troubleshooting
- Missing subtotals: ensure group names are correct and totals are added at the desired group level.
- Unexpected blank cells: verify that the dataset returns rows for the combination of group keys or use `ISNULL`/`COALESCE` in SQL.

# SSRS Report Builder Part 6.9 - Matrix Nested Groups

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>