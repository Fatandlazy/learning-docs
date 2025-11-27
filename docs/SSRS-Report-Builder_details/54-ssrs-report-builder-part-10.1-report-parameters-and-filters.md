# SSRS Report Builder Part 10.1 — Report Parameters and Filters (Overview)

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>

This page provides an overview of report parameters and how they differ from filters. Parameters are inputs provided by users (or defaulted); filters are applied either at the dataset/query level or at the report region level to restrict rows.

Parameters
- Create parameters via `Report` → `Report Parameters` or when adding a dataset parameter.
- Parameters can be single-value, multi-value, have default values, and be linked to datasets for drop-down lists.

Filters
- Dataset filters are applied after the dataset query returns data (unless the query uses parameters); Query parameters are preferred for large datasets.
- Tablix (region) filters apply after the dataset and only affect the region.

Common patterns
- Use query parameters to limit rows at source for performance.
- Use report/region filters for small visual adjustments or when you need multiple views of the same dataset with different filters in a single report.

Examples
- Query parameter: `SELECT * FROM Orders WHERE OrderDate BETWEEN @StartDate AND @EndDate`.
- Region filter: set a filter on a tablix to show only `Fields!Status.Value = "Open"`.

Troubleshooting
- Double-filtering: if you apply both query parameter and report filter, ensure they don't conflict and cause empty result sets.

# SSRS Report Builder Part 10.1 - Report Parameters and Filters

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>