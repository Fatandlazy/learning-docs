# Wise Owl Answers - How do I compare specific columns in a matrix in SSRS?

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>

[Watch on YouTube](https://youtu.be/ehhMBNX-0mg)

This note describes ways to compare specific columns in a matrix in SSRS — for example comparing Quarter 2 sales to Quarter 1 sales or comparing a particular product column against another column.

Challenges
- Matrix columns are generated dynamically from column group values, so you cannot reference columns by a static column index in expressions. Instead use grouping keys, lookups, or pre-aggregated dataset columns.

Approaches

1) Pre-aggregate values per column in the dataset
- The simplest and most reliable approach is to have the dataset return columns you need for comparison (for example `Q1Sales`, `Q2Sales`) so the matrix (or table) can reference explicit fields.

2) Use Lookup (or LookupSet) to find the comparison value
- If the dataset returns rows with `GroupKey`, `ColumnKey`, and `Value`, you can use `Lookup` to find the value for a specific column within the same dataset. Example:

```vb
=Lookup(Fields!GroupKey.Value & "|Q1", Fields!GroupKey.Value & "|" & Fields!ColumnKey.Value, Fields!Value.Value, "DataSet1")
```

Construct the lookup key so you can retrieve the cell value for another column (e.g., Q1) for the same row group.

3) Use custom aggregates and filters in expressions
- Use `Sum(IIF(Fields!ColumnKey.Value = "Q1", Fields!Value.Value, 0), "DataSet1")` to compute the Q1 total for the current outer group. Compare this against `Sum(IIF(Fields!ColumnKey.Value = "Q2", Fields!Value.Value, 0), "DataSet1")` for Q2.

Example comparing two columns in the same group:

```vb
=Sum(IIF(Fields!ColumnKey.Value = "Q2", Fields!Value.Value, 0), "DataSet1")
- Sum(IIF(Fields!ColumnKey.Value = "Q1", Fields!Value.Value, 0), "DataSet1")
```

4) Use custom code to track previous values (advanced)
- For complex requirements (previous column stored across rendering), you can add custom code in Report Properties to store and retrieve values as the report processes rows — this is advanced and has scope/ordering caveats.

Tips
- Ensure `DataSet1` (or your dataset) returns the keys necessary to identify the column you want to compare.
- Test with grouped and ungrouped matrixes — aggregation scopes matter.
- For performance, perform heavy aggregation in SQL rather than inside SSRS expressions where possible.

Preview with realistic data to ensure comparisons align with expected grouping and ordering.

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>
