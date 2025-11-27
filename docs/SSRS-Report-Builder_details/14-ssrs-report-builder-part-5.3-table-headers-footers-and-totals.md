# SSRS Report Builder Part 5.3 - Table Headers, Footers and Totals

Back to playlist

Purpose: Explain how to add and configure table headers, footers, group subtotals and grand totals, use RunningValue for running totals, and ensure headers repeat correctly across pages.

1) Header rows vs group headers
- Table headers (outside group) appear once per table and are ideal for column titles. Add via `Insert Row` → `Outside Group - Above`.
- Group headers appear for each group instance and are useful for group labels (e.g., Category name). Add via `Add Group` → `Parent Group` and include a header row.

2) Footer rows and subtotals
- Group footer: to show subtotal for a group, insert a row `Inside Group - Below` and use an aggregate expression scoped to the group, e.g. `=Sum(Fields!Amount.Value)`.
- Grand footer: insert `Outside Group - Below` to show a grand total across the whole dataset or tablix.

3) Running totals with RunningValue
- Use `RunningValue` to show a cumulative total across rows. Syntax: `=RunningValue(Fields!Amount.Value, Sum, "DataSetName")` or use group scope.
- Example (cumulative amount per row): `=RunningValue(Fields!Amount.Value, Sum, Nothing)` where `Nothing` uses current scope.

4) Repeating headers on each page
- To repeat table headers on every page: select the header row, open the `Row Group` pane, right-click the (static) header row group → `Properties` → set `RepeatOnNewPage = True` and `KeepWithGroup = After`.
- Also set the `RepeatRowHeaders` property on the tablix if available.

5) Page headers vs table headers
- Page header (Report → Page Header) appears on every page independent of the table. Use page header for report title, company logo and page-level info.
- Table header repeats only when configured and is specific to the tablix.

6) Formatting totals
- Format totals using `Text Box Properties` → `Number` → `Currency` or `Number`. Use the same formatting as detail cells for consistency.
- For percent calculations: use expressions like `=Sum(Fields!Amount.Value) / Sum(Fields!TotalBase.Value)` and format as percentage.

7) Avoid double-counting with scopes
- When using Sum inside group footers, ensure the aggregate scope is the group name, e.g. `=Sum(Fields!Amount.Value, "Group_Customer")` to avoid summing incorrectly.

8) Use of Visibility and toggles with footers
- You can hide/show group footers using `Row Visibility` with toggle. For example, keep subtotals hidden until the user expands the group.

9) Dealing with page breaks and totals
- Page breaks inside groups can affect running totals and page-level summaries. Prefer group-level totals for consistent results.

10) Quick example
- Add a group on `CustomerName`:
  - Group header: show `CustomerName`.
  - Detail rows: line items with `Amount`.
  - Group footer: show `=Sum(Fields!Amount.Value)` for subtotal.
  - Grand footer (outside group): show `=Sum(Fields!Amount.Value)` for grand total.

11) Troubleshooting
- Header not repeating: confirm header row is outside groups or `RepeatOnNewPage` is set.
- Totals wrong: check aggregate scope and that you haven't nested aggregates with the wrong scope.
- RunningValue not resetting: confirm correct scope or use group-specific scope name.

12) Best practices
- Use group footers for subtotals and a single grand footer for final totals.
- Keep page header for report-level info and use table headers for column titles.
- Document group names and scopes when building complex tablixes to avoid expression mistakes.

Would you like me to add annotated screenshots for headers/footers and running totals, or continue to the next file? Tell me which and I'll proceed.
# SSRS Report Builder Part 5.3 - Table Headers, Footers and Totals

TODO: Add detail notes for this tutorial.

Back to playlist

Back to playlist