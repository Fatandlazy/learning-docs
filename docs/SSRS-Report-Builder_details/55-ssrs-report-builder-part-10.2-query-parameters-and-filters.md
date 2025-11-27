# SSRS Report Builder Part 10.2 — Query Parameters and Filters

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>

This page explains how to pass parameters to dataset queries and how query-side filtering compares to report/region filters. For period-over-period comparisons (previous period, percent change), it's often best to calculate in the query.

Passing parameters to queries
- In Dataset Properties → Query, add parameter placeholders (e.g., `@StartDate`, `@EndDate`).
- Map report parameters to query parameters in the `Parameters` tab of Dataset Properties.

Filter at source vs in report
- Source-side filtering (in SQL) reduces data transferred and improves performance.
- Report/region filters are post-processing and useful when you need to use the same dataset multiple ways within the report.

Period-over-period in SQL (recommended)
- Use window functions (LAG) or self-joins to return both current and previous period values in each row for easy percent-change calculation in the report.

Example: percent change computed in SQL
```sql
SELECT
  PeriodKey,
  SUM(Sales) AS Sales,
  LAG(SUM(Sales)) OVER (ORDER BY PeriodKey) AS PrevSales,
  CASE WHEN LAG(SUM(Sales)) OVER (ORDER BY PeriodKey) = 0 THEN NULL ELSE (SUM(Sales) - LAG(SUM(Sales)) OVER (ORDER BY PeriodKey)) * 1.0 / LAG(SUM(Sales)) OVER (ORDER BY PeriodKey) END AS PctChange
FROM SalesTable
GROUP BY PeriodKey
```

Security and parameterisation
- Avoid string concatenation for parameters — use parameterised queries to prevent SQL injection and caching problems.

Troubleshooting
- Parameter type mismatches: ensure report parameter types match the SQL parameter types (date, integer, string).

# SSRS Report Builder Part 10.2 - Query Parameters and Filters

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>