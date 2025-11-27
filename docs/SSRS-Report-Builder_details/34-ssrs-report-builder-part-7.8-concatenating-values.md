# SSRS Report Builder Part 7.8 — Concatenating Values

Back to playlist

Concatenation joins text values together. SSRS expressions commonly use the `&` operator or `Join` for arrays/collections.

Simple concatenation
- `=Fields!FirstName.Value & " " & Fields!LastName.Value`

Handling NULLs
- Protect against `Nothing`: `=Trim(CStr(IsNothing(Fields!FirstName.Value) ? "" : Fields!FirstName.Value) & " " & CStr(IsNothing(Fields!LastName.Value) ? "" : Fields!LastName.Value))`
- In VB expressions use `IIF(IsNothing(...), "", ...)` or create a `SafeString` helper in Code.

Using `Join` for multi-value fields
- If you have arrays or multi-value parameters, use `Join`: `=Join(Parameters!SelectedValues.Value, ", ")`

Concatenate with separators safely
- Example helper expression for optional middle name:
  `=Fields!FirstName.Value & IIF(IsNothing(Fields!MiddleName.Value) OR Fields!MiddleName.Value = "", "", " " & Fields!MiddleName.Value) & " " & Fields!LastName.Value`

Performance
- Concatenation is cheap in report expressions; if many rows and heavy processing is needed, consider creating the full name in SQL.

Troubleshooting
- Blank results: check for `Nothing` values and use `IsNothing` guards.

# SSRS Report Builder Part 7.8 - Concatenating Values

TODO: Add detail notes for this tutorial.

Back to playlist

Back to playlist