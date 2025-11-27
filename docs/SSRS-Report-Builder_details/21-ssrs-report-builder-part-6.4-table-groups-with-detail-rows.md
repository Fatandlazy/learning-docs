# SSRS Report Builder Part 6.4 — Table Groups with Detail Rows

Back to playlist

This topic covers how to design a table (tablix) that shows both detail rows and group-level headings/subtotals. It's a common requirement to show every record while also summarising by a grouping key.

Key concepts
- **Detail row**: the row in the tablix bound directly to each dataset record.
- **Group header/footer**: rows that appear once per group to show group labels or summaries.
- **Scope**: the target group name used when calculating aggregates like `Sum` or `Count`.

Design steps
1. Insert a table and set the dataset.
2. In the `Row Groups` pane, add a parent group for the grouping key (e.g., `CategoryID`). When adding, choose `Add group` → `Parent Group` and check `Add group header` (and footer if you want subtotals).
3. The detail row stays inside the group. It will repeat for each record belonging to the current group.
4. Place group labels (like `=Fields!CategoryName.Value`) in the group header and aggregates (`=Sum(Fields!Amount.Value)`) in the group footer.

Example layout
- Parent header row: Category name and optional group-level information.
- Detail rows: Product, quantity, price, etc. These rows repeat per product within the category.
- Child footer (group footer): subtotal for the group: `=Sum(Fields!LineTotal.Value, "CategoryGroup")`.

Working with visibility and toggles
- To hide the detail rows initially and allow users to expand a group:
  - Set the detail row visibility to hidden by default.
  - Configure the parent header textbox to be the toggle owner (Row Visibility → Display can be toggled by this report item).

Scope-aware aggregates
- Use the group name from the Row Groups pane as the scope in aggregate functions: `=CountRows("CategoryGroup")` or `=Sum(Fields!Amount.Value, "CategoryGroup")`.

Formatting tips
- Use subtle shading or borders on group headers to visually separate groups.
- Keep column widths stable to avoid layout jumps when toggling visibility.

Common mistakes
- Placing totals in the wrong row: totals for a group must be in the group footer (or header), not the detail row.
- Using the wrong scope: when you omit the scope parameter the aggregate may target the dataset or a different scope.

# SSRS Report Builder Part 6.4 - Table Groups with Detail Rows

TODO: Add detail notes for this tutorial.

Back to playlist

Back to playlist