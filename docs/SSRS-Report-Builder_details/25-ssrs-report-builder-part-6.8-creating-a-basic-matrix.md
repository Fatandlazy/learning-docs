# SSRS Report Builder Part 6.8 — Creating a Basic Matrix (Cross-Tab)

Back to playlist

A matrix (cross-tab) in SSRS is used to pivot data dynamically by one or more grouping axes (columns and rows). This guide shows how to create a simple matrix to display aggregated values across categories and time periods.

When to use a matrix
- You need dynamic columns at runtime (e.g., months, product categories).
- You want a crosstab/pivot layout with aggregated values at intersections.

Steps to create a basic matrix
1. Insert → `Matrix` and place it on the design surface.
2. Bind the matrix to a dataset that includes row group, column group, and measure fields (for example: `Category`, `Month`, `SalesAmount`).
3. Drag the desired field to the Row Groups area (e.g., `Category`) and to the Column Groups area (e.g., `Month`).
4. Place an aggregate expression in the data cell, such as `=Sum(Fields!SalesAmount.Value)`.

Example: Sales by Category and Month
- Row Group: `=Fields!CategoryName.Value`
- Column Group: `=Format(Fields!OrderDate.Value, "yyyy-MM")`
- Data cell: `=Sum(Fields!LineTotal.Value)`

Handling dynamic columns
- The matrix generates a column for each distinct value in the column group. For long time ranges, consider rolling up into quarters or pre-filtering the dataset.

Formatting and layout
- Use `ColumnGrouping` to control order. Add sorting expressions on the column group to keep columns chronological.
- Use `Subtotal` and `Total` features to add row and column totals.

Performance tips
- Filter dataset to the necessary date range to avoid hundreds of dynamic columns.
- Pre-aggregate in SQL when possible, especially for large datasets.

Export considerations
- Matrixes with many dynamic columns may not translate cleanly to narrow PDF pages; consider using landscape page orientation for wide matrices.

Troubleshooting
- Columns missing or unexpected: check the dataset values and grouping expressions (formatting expressions can produce different distinct values).

# SSRS Report Builder Part 6.8 - Creating a Basic Matrix

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>