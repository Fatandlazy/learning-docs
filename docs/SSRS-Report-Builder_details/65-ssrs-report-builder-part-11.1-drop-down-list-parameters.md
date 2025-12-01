# SSRS Report Builder Part 11.1 - Drop Down List Parameters

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>

[Watch on YouTube](https://youtu.be/bDyP-LXSBPk)

This guide covers creating drop-down list (single-select) parameters in SSRS Report Builder, populating their available values from a query or static list, mapping label/value pairs, and mapping parameters into dataset queries.

When to use drop-down list parameters
- Use drop-downs when you want to constrain user inputs to a fixed set of choices (for example: Regions, Departments, Product categories).

1) Create a drop-down parameter
1. In **Report Data** → right-click `Parameters` → **Add Parameter**.
2. Give the parameter a **Name** (for example `RegionParam`) and a **Prompt** (for example "Select a region:").
3. Set **Data type** to the appropriate type (Text, Integer, etc.).

2) Provide available values (two options)
- Static values: choose **Available Values** → **Specify values** and add rows of **Label** (what user sees) and **Value** (what is passed to the dataset).
- Query-based values: choose **Available Values** → **Get values from a query**. Select the dataset that returns the list and choose the fields for **Value field** and **Label field**.

Example: populate regions from a dataset
- Create a dataset `dsRegions` with SQL: `SELECT RegionID, RegionName FROM Regions ORDER BY RegionName`.
- In the parameter, choose **Get values from a query**, pick `dsRegions`, set **Value field** = `RegionID`, **Label field** = `RegionName`.

3) Default value
- Optionally set a default value: choose **Default Values** → **Specify values** or **Get values from a query**.
- Common defaults: the first available value, a frequently used region, or `All` represented by a special value (e.g., 0 or NULL) if supported.

4) Mapping the parameter to dataset queries
- In the Dataset Properties → Parameters, map the query parameter to the report parameter: set dataset parameter `@RegionID` to `=Parameters!RegionParam.Value`.

SQL examples
- Simple filter:

```sql
SELECT * FROM Orders
WHERE RegionID = @RegionID
```

- Support an "All" choice (when `0` or `NULL` means all regions):

```sql
SELECT * FROM Orders
WHERE (@RegionID IS NULL OR @RegionID = 0) OR (RegionID = @RegionID)
```

5) Single-select vs multi-select
- Drop-downs described here are single-select. For multi-select, use a multi-value parameter and handle it in SQL with `IN (@Param)` or by expanding values into a table-valued parameter / splitting string depending on your data source.

6) Common pitfalls and tips
- Label vs Value: ensure the **Value** is the type your query expects (e.g., use integer IDs when your table uses integer keys).
- Sorting: when using query-based available values, sort the dataset for a user-friendly order.
- Caching: if the available values dataset is expensive, consider caching or using a shared dataset.
- Null/All behaviour: decide whether you want an explicit "All" option and implement consistent SQL handling.

7) Example: add an "All" option to a query-based list
- Create a dataset that unions an All row:

```sql
SELECT NULL AS RegionID, '(All regions)' AS RegionName
UNION ALL
SELECT RegionID, RegionName FROM Regions
ORDER BY RegionName
```

Then use this dataset for the parameter's available values. Map `NULL` or a sentinel value in your dataset query accordingly.

Preview the report and test selecting different values to ensure the parameter correctly filters the data and the default behaves as expected.

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>
