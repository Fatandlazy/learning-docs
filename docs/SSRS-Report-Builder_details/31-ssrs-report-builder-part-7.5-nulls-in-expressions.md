# SSRS Report Builder Part 7.5 — Nulls in Expressions

Back to playlist

Null (Nothing) values are common in datasets and can cause expression errors if not handled. This page covers patterns to detect and safely handle NULLs (`Nothing`) in SSRS expressions.

Detecting NULLs
- Use `IsNothing(Fields!FieldName.Value)` to test for nulls.
  Example: `=IIF(IsNothing(Fields!MiddleName.Value), "", Fields!MiddleName.Value)`

Replacing NULLs
- In SQL: use `COALESCE` (T-SQL) or `ISNULL` to return a default value before the data reaches the report: `SELECT COALESCE(MiddleName, '') AS MiddleName FROM ...`
- In SSRS: use expressions like:
  `=IIF(IsNothing(Fields!Value.Value), "", Fields!Value.Value)`
  or create a small helper in Code for reuse.

Using `Lookup` / `LookupSet` safely
- When using `Lookup`, the returned value may be `Nothing` if no match is found. Wrap with `IsNothing` checks before using it.

Formatting with NULLs
- Formatting functions can throw when given `Nothing`. Protect them: `=IIF(IsNothing(Fields!Date.Value), "", Format(Fields!Date.Value, "yyyy-MM-dd"))`

Null and numeric operations
- Prevent arithmetic errors by ensuring numeric fields are not `Nothing`:
  `=IIF(IsNothing(Fields!Qty.Value), 0, Fields!Qty.Value) * Fields!UnitPrice.Value`

Best practices
- Prefer fixing/normalising data in SQL (COALESCE/ISNULL) for large datasets.
- Use a small set of reusable Code functions for common patterns (SafeValue, SafeFormat, SafeDivide).

Troubleshooting
- Unexpected `Nothing` values: confirm the dataset returns the expected rows and that joins are not turning results into NULLs.

# SSRS Report Builder Part 7.5 - Nulls in Expressions

TODO: Add detail notes for this tutorial.

Back to playlist

Back to playlist