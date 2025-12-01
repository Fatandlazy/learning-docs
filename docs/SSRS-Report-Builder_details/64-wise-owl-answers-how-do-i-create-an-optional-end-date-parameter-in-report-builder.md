# Wise Owl Answers - How do I create an optional end date parameter in Report Builder?

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>

[Watch on YouTube](https://youtu.be/Jx-uvB93Rzw)

This note explains how to create an optional end date parameter in SSRS Report Builder and how to use it safely in dataset queries so that users can choose to filter by an end date or leave it blank to return all records up to today.

Problem statement
- A common requirement is to allow users to provide a start date and optionally an end date. If the end date is omitted, the dataset should return rows from the start date onward with no upper bound (or use Today as the upper bound depending on requirement).

1) Create the parameters
- In **Report Data** → `Parameters`, add two parameters: `StartDate` and `EndDate`.
- Set **Data type** to `Date/Time` for both.
- For `EndDate`, check **Allow null value** so the parameter can be left empty by the user.
- (Optional) Set a default value for `StartDate` (for example `=Today().AddDays(-30)` for a 30-day default window) and leave `EndDate` default as `Null`.

2) Dataset query examples
If you allow a null `EndDate` and want to return all rows when it is null, use a WHERE clause like this (T-SQL):

```sql
SELECT OrderId, OrderDate, Total
FROM Orders
WHERE (@StartDate IS NULL OR OrderDate >= @StartDate)
	AND (@EndDate IS NULL OR OrderDate <= @EndDate)
```

Behavior:
- If `EndDate` is null (user left it blank), the `(@EndDate IS NULL OR OrderDate <= @EndDate)` condition evaluates true for all rows and does not restrict by an upper bound.
- If `EndDate` is set, the condition restricts rows to those with `OrderDate <= @EndDate`.

Alternative: treat empty end date as Today
If business rules require that an omitted end date means "up to today" rather than no upper bound, set the dataset parameter mapping to an expression that substitutes Today when null. In the Dataset Properties → Parameters, map the dataset `@EndDate` to the expression:

```
=IIF(Parameters!EndDate.Value IS NOTHING, Today(), Parameters!EndDate.Value)
```

Then your query can use `WHERE OrderDate <= @EndDate` without the `IS NULL` check.

3) UI notes
- Date pickers show a blank value when **Allow null value** is enabled — helpful to indicate optionality.
- Provide clear prompt text: for example `End date (optional)`.

4) Edge cases and tips
- Time components: Date/Time parameters include time; if your `OrderDate` column includes time, consider normalizing the parameter (for example set the end date to end of day) or compare using `CAST`/`CONVERT` appropriately.
- Parameter validation: if you need to ensure `StartDate <= EndDate`, add report-level validation in the parameter default expressions, or handle invalid ranges in the query with `IIF` / `CASE` logic and return helpful messages.
- Stored procedures: when using stored procedures, allow a `NULL` for the end date parameter and implement the same `IF @EndDate IS NULL` logic inside the procedure.

Examples recap
- No upper bound when omitted: `(@EndDate IS NULL OR OrderDate <= @EndDate)`
- Treat omitted as Today: map dataset param `@EndDate` to `=IIF(Parameters!EndDate.Value IS NOTHING, Today(), Parameters!EndDate.Value)` and use `OrderDate <= @EndDate`.

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>
