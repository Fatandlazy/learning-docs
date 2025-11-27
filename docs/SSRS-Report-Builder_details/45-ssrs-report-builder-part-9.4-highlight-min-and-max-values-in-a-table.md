# SSRS Report Builder Part 9.4 — Highlight Min and Max Values in a Table

Back to playlist

You can highlight the minimum and maximum values in a group using aggregate functions with the group scope.

Example expression for `BackgroundColor`
- Highlight min and max within `CategoryGroup`:
  `=IIF(Fields!Amount.Value = Min(Fields!Amount.Value, "CategoryGroup"), "#DFF0D8", IIF(Fields!Amount.Value = Max(Fields!Amount.Value, "CategoryGroup"), "#F2DEDE", "Transparent"))`

Notes
- If multiple rows share the same min or max value (ties), the expression highlights all matching rows.
- Use `CDec`/`CDbl` when comparing floating point numbers to avoid precision issues, or round values in the comparison.

Alternative: highlight relative min/max using ranking
- Use `Rank` or custom code to compute ordinal position; SSRS does not have a built-in Rank function, so compute rank in SQL or use `LookupSet` helpers.

Performance
- Min/Max per group are efficient but avoid nested expensive expressions; compute in SQL for very large datasets if necessary.

Troubleshooting
- `#Error`: check scope name matches the group shown in the Row Groups pane and ensure `Fields!Amount.Value` is numeric and not `Nothing`.

# SSRS Report Builder Part 9.4 - Highlight Min and Max Values in a Table

TODO: Add detail notes for this tutorial.

Back to playlist

Back to playlist