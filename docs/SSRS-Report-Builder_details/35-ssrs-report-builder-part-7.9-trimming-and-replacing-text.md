# SSRS Report Builder Part 7.9 — Trimming and Replacing Text

Back to playlist

This page covers text-cleaning functions commonly used in SSRS expressions: `Trim`, `LTrim`, `RTrim`, and `Replace`.

Trim functions
- `Trim(string)`: removes leading and trailing whitespace.
- `LTrim(string)`: removes leading whitespace.
- `RTrim(string)`: removes trailing whitespace.

Replace
- `Replace(expression, find, replace)` replaces all occurrences of `find` with `replace`.
  Example: `=Replace(Fields!Address.Value, "\r\n", " ")` to flatten multi-line addresses.

Common cleaning patterns
- Normalize spaces: `=Trim(Replace(Fields!Name.Value, "  ", " "))`
- Remove non-printable characters (basic): `=Replace(Fields!Text.Value, Chr(10), " ")` and `=Replace(..., Chr(13), " ")`

International text
- `Trim` and `Replace` work with Unicode strings returned by datasets; be careful with special whitespace characters (NBSP). Use `Replace` with `ChrW` codes where needed.

When to pre-clean in SQL
- For heavy cleaning across many rows, consider doing the work in SQL for performance and to keep report expressions simple.

Troubleshooting
- Unexpected results: check for hidden characters (tab, non-breaking space). Use `Replace` with the appropriate `Chr`/`ChrW` values.

# SSRS Report Builder Part 7.9 - Trimming and Replacing Text

TODO: Add detail notes for this tutorial.

Back to playlist

Back to playlist