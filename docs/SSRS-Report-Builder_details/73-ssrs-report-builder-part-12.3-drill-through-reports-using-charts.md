# SSRS Report Builder Part 12.3 - Drill Through Reports using Charts

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>

[Watch on YouTube](https://youtu.be/NAl9Oo7bwDI)

This note explains how to add drill-through actions to chart data points in SSRS Report Builder. Chart drill-throughs let users click a point, bar, or slice and open a target report filtered to that data point's context.

Where to attach actions
- Actions can be attached to the data point (series point) or to the series itself depending on whether you want the drill to be invoked for individual points or entire series.

Steps to add a drill action on a chart point
1. Select the chart and click on the series; right-click the **Data Point** (or use the Series Properties) and choose **Series Properties** → **Action**.
2. Choose **Go to report** and pick the target report.
3. Add parameter mappings using the fields or expressions that represent the point's category and series values. Example: `Category = =Fields!Month.Value`, `Product = =Fields!ProductID.Value`.

Passing aggregated or bucketed values
- Charts frequently use aggregates or groupings. Use the same expression that drives the chart's data point when mapping parameters. For example if the point represents `Sum(Fields!Sales.Value) WHERE Year = 2024`, pass the group keys (Year, Month) rather than the aggregated sum unless the target expects a numeric filter.

Examples
- Click on a bar for March (Category = March, Series = Region North) and drill to `MonthlyRegionDetails` with `Month = "March"`, `Region = "North"`.

Tips
- Use `=CStr()` or `=CInt()` to cast parameter values to the expected type.
- If the chart is based on a dataset with multiple grouping fields, ensure the fields you need are included in the chart's dataset so they are available for the action mapping.
- Consider adding a tooltip that explains the drill action to users (DataPoint ToolTip property).

Troubleshooting
- Action not firing: ensure you added the action to the Data Point or Series, not only the chart area.
- Incorrect filters in target report: verify you passed the correct group/category fields and not aggregated measures unless intended.

Preview and test drill-throughs in interactive preview and after deployment — chart rendering and clickable areas can vary slightly between viewers.

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>
