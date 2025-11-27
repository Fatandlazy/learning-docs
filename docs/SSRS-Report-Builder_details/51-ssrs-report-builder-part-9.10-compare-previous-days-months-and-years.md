# SSRS Report Builder Part 9.10 — Compare Previous Days, Months and Years

Back to playlist

This guide shows common techniques for comparing values to previous periods: previous day, previous month, previous year (period-over-period comparisons). It covers report expressions, dataset approaches, and performance considerations.

Approaches
- SQL-side (recommended for performance): compute previous-period values in your query using `LAG`, self-joins, or date arithmetic and return current and prior values in the same row.
- Report-side: use `Previous()`, `Lookup`/`LookupSet`, or aggregate expressions with filtered datasets to compute previous-period totals.

Quick examples

1) Using SQL (example for previous month total alongside current month):
```sql
SELECT
   Year(OrderDate) AS Yr,
   Month(OrderDate) AS Mth,
   SUM(Total) AS MonthTotal,
   LAG(SUM(Total)) OVER (ORDER BY Year(OrderDate), Month(OrderDate)) AS PrevMonthTotal
FROM Orders
GROUP BY Year(OrderDate), Month(OrderDate)
```

2) Using Report Builder `Previous()` for row-level sorted data
- If your rows are sorted by date, `Previous(Fields!Total.Value)` returns the previous row's value. Use with `IsNothing` guard:
  `=IIF(IsNothing(Previous(Fields!Total.Value)), 0, Fields!Total.Value - Previous(Fields!Total.Value))`

3) Comparing by period using `Lookup` (when previous period is a different dataset or pre-aggregated set)
- If you have a dataset `MonthTotals` with `YearMonth` and `Total`, you can lookup the previous month value:
  `=Lookup(Format(DateAdd("m", -1, Fields!PeriodDate.Value), "yyyy-MM"), Fields!YearMonth.Value, Fields!Total.Value, "MonthTotals")`

Formatting percent change
- Percent change expression (guard division):
  `=IIF(Prev = 0, Nothing, (Curr - Prev) / Prev)`
  Then format as percentage: set `Format` to `P1` or use `FormatPercent(...,1)`.

Performance tips
- Prefer SQL-window functions (`LAG`, `LEAD`, `SUM() OVER (PARTITION BY ...)`) for large datasets — the DB is optimized for these operations.
- Use small lookup datasets cached as shared datasets for lookups rather than calling `Lookup` across thousands of rows.

Troubleshooting
- `Previous()` returns `Nothing` on the first row of the scope — guard with `IsNothing`.
- Mismatched periods: ensure date rounding/formatting matches between datasets when using `Lookup`.

# SSRS Report Builder Part 9.10 - Compare Previous Days, Months and Years

TODO: Add detail notes for this tutorial.

Back to playlist

Back to playlist