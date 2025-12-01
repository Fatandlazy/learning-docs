# Wise Owl Answers - How do I refer to the previous column in a matrix in SSRS?

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>

[Watch on YouTube](https://youtu.be/GaVs4VIRcu0)

This note explains techniques for referring to a previous column in a matrix in SSRS. Because matrix columns are dynamic, the approach depends on your dataset shape and required behavior.

Quick summary
- `Previous()` works on row-order within a scope and is not reliable for dynamic matrix columns.
- Preferred methods: use `Lookup`/conditional aggregates or pre-compute the previous column value in the dataset. For advanced scenarios consider custom code.

1) Use conditional aggregates to calculate values by column key
- If your dataset contains `GroupKey`, `ColumnKey`, and `Value`, compute the value for a specific column with a conditional aggregate, e.g.:

```vb
=Sum(IIF(Fields!ColumnKey.Value = "PrevColumnKey", Fields!Value.Value, 0), "DataSet1")
```

Replace `PrevColumnKey` with the key/name of the column you consider previous (for example `Q1`). This gives you a stable way to reference another column's value for the same group.

2) Use `Lookup` to fetch a sibling column value
- Construct a key from the group and column and use `Lookup` to retrieve the cell for the previous column. Example:

```vb
=Lookup(Fields!GroupKey.Value & "|Q1", Fields!GroupKey.Value & "|" & Fields!ColumnKey.Value, Fields!Value.Value, "DataSet1")
```

This returns the value for `Q1` within the same group.

3) Pre-compute previous column in SQL
- In many cases it's easiest and fastest to have your SQL return the previous column value as a field (for example via `LAG()` window function) so SSRS can refer to it directly: `LAG(Value) OVER (PARTITION BY GroupKey ORDER BY ColumnKey)`.

4) Use custom report code (advanced)
- You can write custom VB code in Report Properties to store and retrieve values while the report renders. This approach is fragile because rendering order matters and can break with grouping or interactive features.

Example: using SQL `LAG()` (recommended when supported)

```sql
SELECT *, LAG(Value) OVER (PARTITION BY GroupKey ORDER BY ColumnOrder) AS PrevValue
FROM YourMatrixSource
```

Then use `Fields!PrevValue.Value` inside the matrix cell.

Tips and caveats
- Preferred: compute in SQL (LAG) or use Lookup/conditional aggregates in SSRS.
- Avoid relying on `Previous()` for matrix columns — it is order-dependent and may not match column group boundaries.
- Test exported outputs (PDF/Excel) as rendering order can differ from interactive preview.

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>
