# SSRS Report Builder Part 5.2 - Sorting and Interactive Sorting in Tables

Back to playlist

Purpose: Explain the difference between dataset-level/static sorting and report-level sorting, and demonstrate how to add interactive sorting to table headers so report viewers can sort results on demand.

1) Dataset-level (static) sorting
- Sorting in the dataset is performed by the database using `ORDER BY` in the dataset query. This is efficient for large datasets because the DB engine handles sorting.
- Example SQL: `SELECT OrderID, OrderDate, Amount FROM dbo.Orders ORDER BY OrderDate DESC`.

2) Report-level (static) sorting
- You can set sorting on groups or the tablix in Report Builder (Group Properties → Sorting). This sorting happens after the dataset is returned and is handled by the report processor.
- Use report-level sorting when you want a default order that depends on report scope, or when sorting by expressions not available in the dataset SQL.

3) Interactive sorting (enable viewer sorting)
- Interactive sorting allows end-users to click a column header to sort the table at runtime.
- To enable interactive sorting:
  - Right-click the header textbox → `Text Box Properties` → `Interactive Sorting`.
  - Check `Enable interactive sorting on this text box`.
  - Choose the scope to sort: the dataset or a row group. If your table has groups, select the appropriate group.
  - Optionally set a sort expression (e.g., `=Fields!Amount.Value` or `=CInt(Fields!InvoiceNo.Value)` for numeric values stored as text).

4) Sorting scope and groups
- When interactive sorting is applied to a group header, it sorts rows within that group or reorders the group members depending on where you attach the toggle.
- When attaching interactive sorting to a column in the detail row, choose the dataset scope to sort the whole table.

5) Sorting expressions
- Use expressions for custom sorts, e.g.:
  - Convert string to number: `=CInt(Fields!Qty.Value)`
  - Sort by date part: `=Year(Fields!OrderDate.Value)`
- Be mindful of NULL values; use `IIf(IsNothing(...), <fallback>, ...)` to avoid runtime errors.

6) Multi-column / persistent sorts
- Report Builder's interactive sorting toggles one column at a time. For multi-column sorting, implement a sort expression that combines fields (e.g., `=Fields!Category.Value & "|" & Fields!SubCategory.Value`) or sort at dataset level with `ORDER BY` multiple columns.

7) Visual cues and toggles
- When interactive sorting is enabled, the header shows an arrow indicating sort direction at runtime. You can add tooltips describing that the column is sortable.

8) Performance considerations
- For very large datasets prefer dataset-level sorting in SQL. Interactive sorting is convenient but can be slower because it runs in the report processor.

9) Troubleshooting
- Interactive sort has no effect: check the selected scope (dataset vs group) and ensure the sort expression references the correct fields.
- Sorting numeric values as text: convert to numeric type in the expression before sorting.

10) Quick example
- Add interactive sorting to an `Amount` column header:
  - `Text Box Properties` → `Interactive Sorting` → Enable → Sort by `=Fields!Amount.Value` → Scope: dataset.

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>