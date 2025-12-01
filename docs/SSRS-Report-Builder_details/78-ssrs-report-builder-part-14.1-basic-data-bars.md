# SSRS Report Builder Part 14.1 - Basic Data Bars

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>

[Watch on YouTube](https://youtu.be/NatODUBtU8Q)

This guide explains how to create basic data bars (inline bar charts) in SSRS Report Builder to show relative values directly inside table or matrix cells.

Approaches
- **Indicator Data Bar**: Some SSRS indicator types include a data bar option you can use directly and bind to a numeric value.
- **Textbox width expression**: Use a colored textbox or rectangle and set its `Width` property via an expression relative to the maximum value.
- **Sparkline / Data Bar chart**: Use a Sparkline or a small bar chart inside a tablix cell for richer visuals and scaling.

1) Using an Indicator data bar
1. Insert an Indicator into the cell and in the Indicator Properties choose a data bar style if available.
2. Set the Value expression to the numeric field (for example `=Fields!Sales.Value`).
3. Configure Minimum and Maximum values (either fixed numbers or expressions using `Max(Fields!Sales.Value, "DatasetName")`).

2) Textbox width expression method (simple, works everywhere)
- Insert a Rectangle or a Textbox inside the cell.
- Add a colored inner rectangle and set its `Width` to an expression that scales the value relative to the maximum. Example:

```vb
'= (Fields!Sales.Value / Max(Fields!Sales.Value, "DataSet1")) * 4cm'
```

- Use a fixed container width (e.g., 4cm) and ensure the inner element does not overflow; combine with `IIF` guards for zero/Null values.

3) Using a Sparkline or small bar chart
- Insert a Sparkline or small Chart inside the cell and use the dataset field as the data point. Configure axis and labels to be minimal to keep the visual compact.

Scaling and min/max
- Decide whether min should be 0 or a dynamic minimum. For relative comparisons, set min to 0 and max to `Max(Fields!Value, "DatasetName")` so bars occupy full width for the largest value.

Performance and rendering
- Many embedded charts or complex expressions in large tables can slow rendering. For large reports prefer pre-aggregated values returned by the dataset.

Accessibility
- Provide a numeric label alongside the bar or as a tooltip so users and screen readers can access the exact value.

Example full expression (inner rectangle width):

```vb
=IIF(Max(Fields!Sales.Value, "DataSet1") = 0, "0cm", (Fields!Sales.Value / Max(Fields!Sales.Value, "DataSet1")) * 4 & "cm")
```

Preview the report in several rendering modes (HTML, PDF, Excel) to ensure bars render acceptably in each output format.

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>
