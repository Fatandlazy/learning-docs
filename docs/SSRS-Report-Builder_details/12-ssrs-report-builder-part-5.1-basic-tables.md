# SSRS Report Builder Part 5.1 - Basic Tables

Back to playlist

Purpose: This page explains how to create and format basic tables (Tablix) in Report Builder: adding datasets, inserting tables, headers and footers, totals, grouping, sorting, and helpful layout tips.

1) Create a new table
- Open Report Builder → `Insert` → `Table` and choose a simple table (tabular layout).
- Bind fields: drag dataset fields from the `Report Data` pane into table cells (detail row cells).

2) Understand Tablix structure
- A table in Report Builder is a Tablix: it has row groups, column groups, and detail rows. Learn which row is the header, detail, and footer by toggling `View` → `Groupings` or inspecting the row handles.

3) Add and format headers/footers
- To add a header row: right-click row handle → `Insert Row` → `Outside Group - Above` (for table header).
- To add a footer/totals row: right-click → `Insert Row` → `Outside Group - Below` (useful for grand totals).
- Use `Text Box Properties` to set font, alignment, and number formats.

4) Add totals and subtotals
- Grand total: in a footer cell, use expression like `=Sum(Fields!Amount.Value)` or choose `Add Total` from the row group context menu.
- Subtotal per group: add a footer row inside a group and use `=Sum(Fields!Amount.Value)` — ensure the scope is set to the group if necessary.

5) Grouping rows
- Add a parent group: right-click the detail row → `Add Group` → `Parent Group` → choose the field to group by (e.g., `Category`).
- Choose whether to add a group header or footer; use header for group labels and footer for group totals.

6) Interactive sorting
- Add interactive sorting to a column header: right-click the header cell → `Text Box Properties` → `Interactive Sorting` → check `Enable interactive sorting on this text box` and pick the dataset or group to sort.

7) Repeat table headers across pages
- To repeat headers: select the header row → `Row Group` properties: set `RepeatOnNewPage = True` and `KeepWithGroup = After` for proper pagination.

8) Column widths and layout tips
- Resize columns by dragging column handles. Avoid very small columns which may wrap text.
- Use `Padding` and `CanGrow/CanShrink` properties on textboxes to control wrapping and row height.

9) Formatting numeric and date fields
- Select the cell → `Text Box Properties` → `Number` → choose `Currency`, `Number`, `Date` and set decimal places.

10) Visibility, toggles and collapse/expand
- Create collapsible groups: add a parent group → right-click the detail row → `Row Visibility` → check `Display can be toggled by this report item` and select the textbox on the group header to toggle.

11) Sorting and scope of aggregate functions
- When using aggregates like `Sum`, ensure the expression scope is correct: `=Sum(Fields!Amount.Value, "GroupName")` for group totals, or omit scope for dataset-level totals.

12) Accessibility & best practices
- Use meaningful column headers and add `ToolTip` on textboxes for screen readers.
- Keep layout simple and consistent; create shared templates for repeating table designs.

13) Troubleshooting common issues
- Column content truncates: check `CanGrow` and column width.
- Totals incorrect: verify group scope in the aggregate expression.
- Header not repeating: ensure `RepeatOnNewPage` is set and header row is outside the group.

14) Quick example
- Add a dataset `DS_Sales` with fields: `OrderID`, `OrderDate`, `CustomerName`, `Amount`.
- Insert Table with 4 columns and map fields accordingly.
- Add a group on `CustomerName` with a group footer showing `=Sum(Fields!Amount.Value)`.

Would you like screenshots added to this page, or should I continue to file `13-ssrs-report-builder-part-52-sorting-and-interactive-sorting-in-tables.md`? Let me know which.
# SSRS Report Builder Part 5.1 - Basic Tables

TODO: Add detail notes for this tutorial.

Back to playlist

Back to playlist