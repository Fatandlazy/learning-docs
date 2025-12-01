# SSRS Report Builder Part 11.3 - Multi Value Parameters

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>

[Watch on YouTube](https://youtu.be/g66aMjPuR8U)

This guide describes multi-value parameters in SSRS Report Builder: how to create them, use them in report filters, and pass the selected values to datasets.

What is a multi-value parameter?
- A multi-value parameter allows the user to select zero, one, or many items from a list. In the report UI this appears as a checklist inside the parameter dropdown.

1) Create a multi-value parameter
1. In **Report Data** → right-click `Parameters` → **Add Parameter**.
2. Give it a **Name** (e.g., `CategoryIDs`) and **Prompt**.
3. Choose the correct **Data type** (Text, Integer) and check **Allow multiple values**.
4. Provide **Available Values** (static or from a dataset) as with single-select parameters.

2) Using multi-value parameters in report expressions and filters
- In report expressions you can access the array of selected values via `Parameters!CategoryIDs.Value`.
- To display the selected list in a textbox, use `=Join(Parameters!CategoryIDs.Value, ", ")`.
- For a tablix/dataset filter, set the filter operator to `In` and set the Value to `=Parameters!CategoryIDs.Value`.

3) Passing multi-value parameters to SQL queries
SSRS cannot expand a multi-value parameter directly into a SQL `IN` list in all cases. Use one of these approaches:

- Dataset filter: Retrieve all candidate rows in the dataset and use the tablix/dataset filter operator `In` with the multi-value parameter (no SQL changes needed). This moves filtering to the report layer.

- Pass a delimited string and split in SQL: Map a single dataset parameter to `=Join(Parameters!CategoryIDs.Value, ",")` and in SQL split the CSV into rows (use `STRING_SPLIT` on SQL Server 2016+ or a custom split function). Example:

```sql
-- Example dataset parameter mapping: @CategoryList = =Join(Parameters!CategoryIDs.Value, ',')
SELECT * FROM Products
WHERE CategoryID IN (SELECT value FROM STRING_SPLIT(@CategoryList, ','))
```

- Use XML: pass the selected values as XML and shred them in SQL.
- Use a table-valued parameter (TVP): requires creating a TVP type and using a data source that supports TVPs; SSRS does not support passing TVPs directly from the parameter UI, so this usually requires custom code or a middle layer.

4) Example: simple report-level filter (recommended when values set is small)
- Add the dataset that returns rows.
- In the tablix properties → Filters, add a filter: Expression = `=Fields!CategoryID.Value`, Operator = `In`, Value = `=Parameters!CategoryIDs.Value`.

5) Tips and pitfalls
- Performance: filtering in the report is easier but less efficient for large datasets — prefer server-side filtering when possible.
- Type matching: ensure parameter value types match the field types (e.g., integers vs strings).
- Empty selections: decide whether no selection should mean "All" or "None" and handle accordingly (often easiest to provide an explicit "(All)" option).

Preview the report with various selections (single, multiple, none) to ensure the results match expectations.

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>
