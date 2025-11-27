# SSRS Report Builder Part 6.2 — Grouping rows in a table

Back to playlist

This article explains how to add grouping to a tablix (table/matrix) in Report Builder: creating row groups, group expressions, group headers and footers, group scope and sorting, and how to use group variables and totals.

When to group in the report
- Show detail rows and group-level subtotals or headers.
- Provide collapsible/expandable sections controlled by toggles.
- Compute running totals and aggregates scoped to the group.

Creating a row group
1. Insert a table (tablix) onto the design surface and bind it to your dataset.
2. In the `Row Groups` pane (bottom of the designer), right-click the parent row group or the detail row and choose `Add Group` → `Parent Group` or `Child Group` depending on desired grouping level.
3. In the dialog, specify the group expression — typically a field like `=Fields!CategoryName.Value` or a more complex expression (date truncation, concatenation, IIF). Optionally check `Add group header` or `Add group footer`.

Group expressions examples
- Group by year from a datetime field:
  `=Year(Fields!OrderDate.Value)`
- Group by month and year (combined):
  `=Format(Fields!OrderDate.Value, "yyyy-MM")`

Header and footer usage
- **Group header**: place title text, group labels, or summary numbers. For example, show the category name in the header.
- **Group footer**: commonly used for subtotals, counts, or averages for the group. Use expressions like `=Sum(Fields!Amount.Value)` with the group scope.

Scope and aggregate functions
- When using aggregate functions, specify scope when needed: `=Sum(Fields!Amount.Value, "CategoryGroup")` where "CategoryGroup" is the group name displayed in the Row Groups pane.
- If scope is omitted, SSRS uses the innermost scope containing the expression.

Interactive sorting and toggles
- Add interactive sort by selecting the textbox you want to be sortable, right-click → `Text Box Properties` → `Interactive Sorting` and configure the expression and scope.
- To create collapsible groups, set the textbox `Visibility` to be toggled by another item (for example, the group header textbox). Right-click row → `Row Visibility` → `Show or hide based on an expression` or `Display can be toggled by this report item`.

RunningValue and group-specific calculations
- Use `RunningValue` for cumulative totals within a scope: `=RunningValue(Fields!Amount.Value, Sum, "CategoryGroup")`.
- Remember `RunningValue` restarts when the scope changes; choose the correct scope name.

Sorting and group order
- Group order is controlled in Group Properties → Sorting. Add expressions to control ascending/descending order. You can sort on aggregates (e.g. group total) by placing the aggregate expression in the sorting expression.

Best practices
- Name your groups clearly (double-click the group name in the Row Groups pane) so you can reference scope easily.
- Keep heavy aggregation in the database when possible; use report-level grouping when you need detail rows or interactive features.
- Use expressions sparingly in group keys when performance matters; prefer pre-computed columns in the dataset.

Troubleshooting
- If aggregates return unexpected values, check you are using the correct scope name.
- If toggles don't work, verify the toggle item is in the same parent scope and the target row/column is hidden by default.

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>