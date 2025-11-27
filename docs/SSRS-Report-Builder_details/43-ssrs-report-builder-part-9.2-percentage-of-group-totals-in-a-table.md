# SSRS Report Builder Part 9.2 — Percentage of Group Totals in a Table

Back to playlist

This article shows how to calculate a row's percentage of its group total (for example, a product's sales as a percentage of the category total).

Basic expression
- In the data cell, use the current row value divided by the group total using the group scope:
  `=IIF(Sum(Fields!Sales.Value, "CategoryGroup") = 0, 0, Fields!Sales.Value / Sum(Fields!Sales.Value, "CategoryGroup"))`

Formatting as percentage
- Set the textbox `Format` to `P2` or use `FormatPercent`:
  `=FormatPercent(Fields!Sales.Value / Sum(Fields!Sales.Value, "CategoryGroup"), 2)`

Notes on scope and Row vs Sum
- `Fields!Sales.Value` is the row's raw value. `Sum(..., "CategoryGroup")` computes the group total. Replace "CategoryGroup" with the actual group name from the Row Groups pane.

Handling multi-level groups
- For nested groups, reference the desired group scope name. For example for subcategory percentage of category: `Sum(..., "CategoryGroup")` and compute per subcategory rows.

Performance tips
- If dataset is large, consider pre-calculating group totals in SQL (join to pre-aggregated dataset) to reduce per-row computations in the report renderer.

Troubleshooting
- Division by zero: guard with `IIF` (or safe helper) as shown above.
- Incorrect totals: double-check the group name and ensure the dataset isn't filtered differently between scopes.

# SSRS Report Builder Part 9.2 - Percentage of Group Totals in a Table

TODO: Add detail notes for this tutorial.

Back to playlist

Back to playlist