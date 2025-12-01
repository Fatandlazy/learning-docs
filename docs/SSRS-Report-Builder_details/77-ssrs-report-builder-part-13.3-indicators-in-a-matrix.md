# SSRS Report Builder Part 13.3 - Indicators in a Matrix

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>

[Watch on YouTube](https://youtu.be/_GbeiCP32EE)

This note explains using indicators inside a Matrix (dynamic columns and rows). It covers expression scope, grouping considerations, and layout tips so indicators render correctly for each intersection.

Where to place indicators
- Insert an Indicator into a matrix cell (the intersection of a row group and column group) to display a visual status for each combination, e.g., Product × Quarter.

Expression and scope
- Indicators evaluate against the value expression you provide. When the dataset contains multiple rows per cell intersection, wrap the value in an aggregate with the correct scope, for example:

```vb
=Sum(Fields!Sales.Value, "DataSetName")
```

or to aggregate for the current cell scope:

```vb
=Sum(Fields!Sales.Value, "MatrixRowGroupName")
```

Using group-level aggregates ensures each cell's indicator reflects the intended data slice instead of raw row-by-row values.

Formatting and alignment
- Keep indicators small to avoid disrupting the matrix layout (16–20 px). Use padding and align the indicator vertically and horizontally so it sits neatly in the cell.
- If a cell contains both text and an indicator, consider using a small two-column internal table or place the indicator in a separate adjacent column.

Performance
- Indicators are lightweight, but many indicators in a large matrix can add rendering overhead. Where possible, compute the value in the dataset query (for example pre-aggregate per grouping) and return a single numeric/status value per intersection.

Conditional states and thresholds
- Use expressions for states (for example `=IIF(Sum(Fields!Sales.Value) > 100000, 2, IIF(Sum(Fields!Sales.Value) > 50000, 1, 0))`) to map numerical values to indicator states.

Handling nulls and empty cells
- Provide a default state for null or empty results (for example state 0) or hide the indicator by setting the `Hidden` property to `=IsNothing(Sum(Fields!Sales.Value))`.

Example: indicator expression for a cell showing performance vs target:

```vb
='IIF(Sum(Fields!ActualSales.Value) / Sum(Fields!TargetSales.Value) >= 1, 2, IIF(Sum(Fields!ActualSales.Value) / Sum(Fields!TargetSales.Value) >= 0.9, 1, 0))'
```

Testing
- Preview with different groupings and drill-down states to ensure indicators update correctly when matrix groups are expanded or collapsed.

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>
