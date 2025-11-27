# SSRS Report Builder Part 6.3 — Nested (Parent & Child) Groups in a Table

Back to playlist

This page covers nested groups (parent/child) inside a tablix, how to design them, show/hide child rows, subtotaling at each level, and handling pagination and page breaks for grouped data.

When to use nested groups
- Hierarchical data: categories → subcategories, departments → teams, or parent records with multiple child records.
- You want grouped summaries at multiple levels (e.g., category total and subcategory subtotal).

Creating parent and child groups
1. Start with your dataset that includes both parent and child keys (e.g., CategoryID and SubcategoryID).
2. Insert a table and bind the dataset.
3. In the Row Groups pane, add the parent group first (`Add Group` → `Parent Group`). Use the parent key as the group expression (e.g., `=Fields!CategoryID.Value`) and add a group header.
4. Then add a child group inside the parent group (`Add Group` → `Child Group`) using the child key (e.g., `=Fields!SubcategoryID.Value`). This will produce nested grouping rows in the tablix.

Design tips for nested groups
- **Indentation**: Use padding or nested columns in group headers to visually distinguish child groups.
- **Headers/Footers**: Add headers for parent and child groups to show labels. Use footers for subtotals at each level.
- **Group names**: Give group instances meaningful names (e.g., `CategoryGroup`, `SubcategoryGroup`) to reference in scope-sensitive expressions.

Subtotals and aggregates per group
- Use `=Sum(Fields!Amount.Value, "SubcategoryGroup")` in the child group footer and `=Sum(Fields!Amount.Value, "CategoryGroup")` in the parent group footer.
- If you need a parent total that depends on the child aggregations, use the parent group's footer to sum the same field with the parent scope.

Toggle visibility and interactive collapsing
- To create a collapsible interface where clicking the parent row shows/hides child rows:
  - Place the toggle item on the parent group's header (usually the parent group label textbox).
  - Set the child group row `Visibility` to `Hidden` by default and `Display can be toggled by` the parent label textbox.

Pagination and page breaks
- Group properties → Page Breaks: you can break the page before or after a group. Common options:
  - Page break between parent groups: `Page break at end` of the parent group for printing per parent.
  - Avoid excessive page breaks for many small groups — prefer keeping groups on the same page where practical.

KeepTogether and KeepWithGroup
- `KeepTogether` tries to keep group rows on the same page. Use it for small groups to avoid splitting a group's header from its data.
- `KeepWithGroup` in row grouping allows the header/footer to stay with the rows it pertains to — useful for readability when printing.

Common pitfalls
- Wrong scope names: aggregates return surprising results if you reference the wrong group name. Double-check the Row Groups pane.
- Over-nesting: too many nested groups with toggles and page breaks can degrade performance and complicate layout.

Performance considerations
- Filter in the dataset when possible to reduce row counts.
- Avoid complex expressions in group keys — pre-compute them in SQL if possible.

Example: Category → Subcategory layout
- Parent header: `=Fields!CategoryName.Value`
- Child header: `=Fields!SubcategoryName.Value`
- Child subtotal (footer): `=Sum(Fields!LineTotal.Value, "SubcategoryGroup")`
- Parent subtotal (footer): `=Sum(Fields!LineTotal.Value, "CategoryGroup")`

# SSRS Report Builder Part 6.3 - Nested Parent and Child Groups in a Table

TODO: Add detail notes for this tutorial.

Back to playlist

Back to playlist