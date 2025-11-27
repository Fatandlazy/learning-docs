# SSRS Report Builder Part 7.7 — Calculating the Difference Between Dates

Back to playlist

Use `DateDiff` in SSRS expressions to calculate the difference between two dates. For complex scenarios or performance, calculate differences in SQL.

Syntax
- `DateDiff(interval, startdate, enddate)` where `interval` can be `d` (days), `m` (months), `yyyy` (years), `h` (hours), `n` (minutes), `s` (seconds).

Examples
- Days between order and ship date:
  `=DateDiff("d", Fields!OrderDate.Value, Fields!ShipDate.Value)`
- Months difference (approximate by month boundaries):
  `=DateDiff("m", Fields!StartDate.Value, Fields!EndDate.Value)`

Notes
- `DateDiff` returns an integer count of boundaries crossed (not a precise timespan). For precise intervals consider calculating in SQL or using datetime arithmetic.
- Handle NULLs with `IsNothing` checks before calling `DateDiff`.

SQL alternative
- In T-SQL, `DATEDIFF(day, StartDate, EndDate)` returns equivalent results. Use SQL when filtering or grouping by date differences.

Timezone and daylight savings
- `DateDiff` operates on the datetime values returned; convert timezones in the dataset query when necessary for accurate results across zones.

# SSRS Report Builder Part 7.7 - Calculating the Difference Between Dates

TODO: Add detail notes for this tutorial.

Back to playlist

Back to playlist