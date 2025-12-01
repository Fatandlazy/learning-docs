# Wise Owl Answers - How do I calculate percentage of columns in a matrix with multiple groups?

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>

[Watch on YouTube](https://youtu.be/5IijWsEFcoo)

This note explains techniques for calculating percentages of column totals in a Matrix with multiple groups in SSRS. When a matrix has nested row or column groups, you must carefully choose the aggregate scope to compute correct percentages.

Problem statement
- You want each matrix cell to show a value and the percentage that value contributes to the column total (for example, show Sales and Sales / ColumnTotal) even when columns are generated dynamically by a group.

Approaches

1) Use aggregate functions with the column-group scope
- Use `Sum(Fields!Value.Value, "ColumnGroupName")` to compute the column total. For example, to display percentage of the column total for the current cell:

```vb
=IIF(Sum(Fields!Value.Value, "ColumnGroupName") = 0, 0, Sum(Fields!Value.Value) / Sum(Fields!Value.Value, "ColumnGroupName"))
```

Notes:
- Replace `ColumnGroupName` with the name of the column group in your matrix (not the dataset name).
- `Sum(Fields!Value.Value)` without a scope aggregates within the current cell's scope — often the intersection of row and column groups.

2) Use `Lookup` or conditional aggregates when group scoping is complicated
- If your dataset is normalized (rows with `RowKey`, `ColumnKey`, `Value`) you can compute the column total using `Sum(IIF(Fields!ColumnKey.Value = "CurrentColumnKey", Fields!Value.Value, 0), "DataSet1")` where `CurrentColumnKey` is the group value for the current column. Example:

```vb
=Sum(Fields!Value.Value) / Sum(IIF(Fields!ColumnKey.Value = Fields!ColumnKey.Value, Fields!Value.Value, 0), "DataSet1")
```

This pattern is trickier — prefer named group scopes when possible.

3) Pre-calculate column totals in the dataset (recommended for complex reports)
- The simplest reliable approach is to have your SQL return the column total as a field (for example using `SUM() OVER (PARTITION BY ColumnKey)` or a join). Then the percentage is simply `=Fields!Value.Value / Fields!ColumnTotal.Value`.

SQL example using window function:

```sql
SELECT *, SUM(Value) OVER (PARTITION BY ColumnKey) AS ColumnTotal
FROM YourMatrixSource
```

Formatting
- Wrap the percentage expression with `FormatPercent(...)` or set the placeholder format to `P0`/`P1` as required.

Tips
- Use the matrix column group name for scope-based aggregates when possible; it is less error-prone than trying to reproduce grouping logic in expressions.
- For very dynamic or multi-level column groups, pre-aggregating in SQL is usually the most maintainable solution.

Preview and test with multiple group levels and sample data to confirm percentages add up correctly across columns.

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>
