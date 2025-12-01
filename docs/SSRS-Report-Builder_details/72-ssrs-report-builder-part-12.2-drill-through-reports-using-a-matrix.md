# SSRS Report Builder Part 12.2 - Drill Through Reports using a Matrix

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>

[Watch on YouTube](https://youtu.be/fVAZxJ74_PM)

This guide covers configuring drill-through actions from cells inside a Matrix in SSRS Report Builder. Because matrices use dynamic row and column groups, you must be careful to pass the correct group values to the target report.

Key concepts
- A matrix creates dynamic columns (and/or rows) from group values. When adding a drill-through action on a matrix cell, pass the current row and column group keys so the target report receives the correct context.

Steps
1. Identify the matrix cell you want to be clickable (typically the data cell at the intersection of a row group and column group).
2. Right-click the textbox inside the cell → **Text Box Properties** → **Action** → **Go to report**.
3. Select the target report and add parameter mappings using the group fields. Example mappings:
- `Category = =Fields!Category.Value` (row group key)
- `Quarter = =Fields!Quarter.Value` (column group key)

Expressions and scope
- If the value you need is an aggregate, use an aggregate expression with the correct scope: `=Sum(Fields!Sales.Value, "MatrixRowGroup")`.
- To pass the column group value use the field or expression that represents the column grouping (for example `=Fields!Month.Value` or `=Fields!ColumnKey.Value`).

Examples
- Drill from Product × Quarter matrix to a detail report filtering on Product and Quarter. Map `ProductID = =Fields!ProductID.Value` and `Quarter = =Fields!Quarter.Value`.

Tips
- Ensure the target report parameters expect the values you pass (type and name).
- When columns are dynamic, include the column grouping field in the dataset so it is available for parameter mapping.
- Use `CStr()`/`CInt()` to cast parameter values to the expected types when necessary.

Troubleshooting
- Wrong context in target report: verify you passed the correct group key expressions and used the right aggregation scope when necessary.
- Blank values: ensure the dataset returns the grouping values at the cell level; if not, use aggregates or pass parent group values.

Preview and test with expanded and collapsed groups to ensure the drill-through always sends the intended context.

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>
