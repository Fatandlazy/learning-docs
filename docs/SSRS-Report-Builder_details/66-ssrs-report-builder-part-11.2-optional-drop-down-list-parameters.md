# SSRS Report Builder Part 11.2 - Optional Drop Down List Parameters

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>

[Watch on YouTube](https://youtu.be/4k88uFFROE8)

This note explains how to make a drop-down list parameter optional in SSRS Report Builder and strategies for providing an "All" or null behavior in queries.

Problem
- By default, drop-down parameters require a selection. You may want to allow users to leave the parameter unset (meaning "All") or explicitly choose an "All" value.

Options to make a drop-down optional

1) Allow a NULL/All option in the available values
- Add a row to the parameter's available values that represents All (for example Value = NULL or Value = 0, Label = '(All)') so users can select it explicitly.
- If using a query for available values, you can UNION an All row at the top of the result set, for example:

```sql
SELECT NULL AS RegionID, '(All regions)' AS RegionName
UNION ALL
SELECT RegionID, RegionName FROM Regions
ORDER BY RegionName
```

2) Use a separate boolean parameter
- Create a `IncludeAll` Boolean parameter alongside the drop-down. In your dataset query, use `(@IncludeAll = 1) OR (RegionID = @RegionID)` to allow either all regions or the selected one.

3) Use NULL allowed on the dataset parameter (mapping trick)
- SSRS does not allow both multi-value and allow null on the same parameter, but for single-select you can permit the dataset mapping to receive `Nothing`.
- In Dataset Properties → Parameters, map `@RegionID` to an expression such as:

```
=IIF(Parameters!RegionParam.Value = "(All)", NOTHING, Parameters!RegionParam.Value)
```

SQL handling examples
- Simple filter when a sentinel value (NULL or 0) represents All:

```sql
SELECT * FROM Orders
WHERE (@RegionID IS NULL OR @RegionID = 0) OR (RegionID = @RegionID)
```

- Using a boolean include flag:

```sql
SELECT * FROM Orders
WHERE (@IncludeAll = 1) OR (RegionID = @RegionID)
```

UI notes
- Provide clear prompt text (e.g., "Region (optional)" or include "(All)" in the label).
- If you add a special All row, position it at the top of the list for discoverability.

Performance and UX tips
- Query-based available values should be cached if expensive.
- Keep the number of available values reasonable; consider search-as-you-type/custom UI for very long lists.

Preview and test both the All-case and the single-select case to ensure the dataset mapping and SQL behave as expected.

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>
