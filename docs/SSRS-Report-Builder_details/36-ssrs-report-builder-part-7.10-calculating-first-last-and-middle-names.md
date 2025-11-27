# SSRS Report Builder Part 7.10 — Calculating First, Last and Middle Names

Back to playlist

This guide shows common strategies for splitting full names into first, middle and last name parts in SSRS expressions or in the dataset.

Best approach
- Prefer splitting names in the source dataset or a view when you control the data. SQL is easier to test and more reliable for edge cases.

Simple expression-based splitting
- First name (first token):
  `=Split(Fields!FullName.Value, " ")(0)`
- Last name (last token):
  `=Split(Fields!FullName.Value, " ")(UBound(Split(Fields!FullName.Value, " ")))
`
- Middle name (everything between):
  `=Join(Split(Fields!FullName.Value, " ").Skip(1).Take(UBound(Split(Fields!FullName.Value, " ")) - 0), " ")`

Safe patterns (handle single-token names and NULLs)
- First name safe:
  `=IIF(IsNothing(Fields!FullName.Value) OR Len(Trim(Fields!FullName.Value)) = 0, "", Split(Trim(Fields!FullName.Value), " ")(0))`
- Last name safe:
  `=IIF(IsNothing(Fields!FullName.Value) OR Len(Trim(Fields!FullName.Value)) = 0, "", Split(Trim(Fields!FullName.Value), " ")(UBound(Split(Trim(Fields!FullName.Value), " "))))`

Advanced: handle prefixes/suffixes
- For names with prefixes (Dr., Mr.) or suffixes (Jr., III) normalization in SQL or pre-processing with custom code is recommended.

SQL alternatives (recommended for production)
- Use T-SQL functions or a table-valued function to parse names reliably. For example, use `PARSE` logic or split by spaces and handle common suffixes.

Troubleshooting
- Index out of range errors: protect `Split(...)` access with checks for empty or single-token names.
- Unexpected tokens: consider trimming, replacing multiple spaces, and normalizing special whitespace characters before splitting.

# SSRS Report Builder Part 7.10 - Calculating First, Last and Middle Names

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>