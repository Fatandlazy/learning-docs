# SSRS Report Builder Part 7.6 — Calculating Date Parts

Back to playlist

This article describes common ways to extract parts of a date in SSRS expressions and when to perform date calculations in SQL vs report expressions.

Common functions
- `Year(date)`: returns the four-digit year.
- `Month(date)`: returns the month number (1-12).
- `Day(date)`: returns the day of month.
- `DatePart("interval", date)`: flexible extractor where `interval` can be `yyyy`, `m`, `d`, `ww`, etc.

Examples
- Year: `=Year(Fields!OrderDate.Value)`
- Month name: `=Format(Fields!OrderDate.Value, "MMMM")`
- Year-Month key: `=Format(Fields!OrderDate.Value, "yyyy-MM")`
- Quarter: `=DatePart("q", Fields!OrderDate.Value)`

When to do this in SQL
- For large datasets or grouping by date parts, do the extraction in SQL for performance and consistent results (e.g., `DATEPART(month, OrderDate)` or `FORMAT(OrderDate, 'yyyy-MM')`).

Handling NULLs
- Protect expressions: `=IIF(IsNothing(Fields!OrderDate.Value), "", Format(Fields!OrderDate.Value, "yyyy-MM"))`

Timezone considerations
- Report Builder expressions work with the raw datetime values returned by the database; handle timezone conversion in the query if required.

# SSRS Report Builder Part 7.6 - Calculating Date Parts

TODO: Add detail notes for this tutorial.

Back to playlist

Back to playlist