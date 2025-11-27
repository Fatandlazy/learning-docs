# SSRS Report Builder Part 7.11 — Splitting and Joining Text

Back to playlist

This guide explains the `Split` and `Join` functions in SSRS expressions and common uses: parsing CSVs, handling multi-value parameters, or formatting lists.

Split
- `Split(string, delimiter)` returns an array of substrings.
- Example: `=Split(Fields!Tags.Value, ",")` and access first token with `(0)`.
- Always `Trim` tokens when needed: `=Trim(Split(Fields!Tags.Value, ",")(0))`.

Join
- `Join(array, separator)` joins an array into a single string.
- Example for multi-value parameter: `=Join(Parameters!Countries.Value, ", ")`

Handling CSV in a field
- If a single field contains a CSV list and you want to display it as bullet list, use `Split` and `Join` or iterate in code. Example to replace commas with line breaks:
  `=Replace(Fields!CsvList.Value, ",", vbCrLf)`

Safe checks and edge cases
- Protect `Split` access: check `IsNothing` and ensure token count using `UBound(Split(...))` before indexing.

Using with `LookupSet`
- `LookupSet` returns an array — use `Join(LookupSet(...), ", ")` to display multiple matches.

Performance
- Splitting many large strings in report expressions can impact rendering time. If possible normalize lists in SQL or return them already exploded.

# SSRS Report Builder Part 7.11 - Splitting and Joining Text

TODO: Add detail notes for this tutorial.

Back to playlist

Back to playlist