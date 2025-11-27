# SSRS Report Builder Part 7.2 — The IIF and Switch Functions

Back to playlist

This page covers two common conditional expression helpers in SSRS: `IIF()` and `Switch()`. Use them to return different values based on conditions inside report expressions.

IIF(condition, truePart, falsePart)
- Example: `=IIF(Fields!Amount.Value > 0, "Credit", "Debit")`
- Notes:
  - `IIF` evaluates both `truePart` and `falsePart` even if only one is needed; this can cause divide-by-zero or null reference errors if the non-selected branch contains invalid operations.

Switch(condition1, value1, condition2, value2, ...)
- Example:
  `=Switch(
     Fields!Score.Value >= 90, "A",
     Fields!Score.Value >= 80, "B",
     Fields!Score.Value >= 70, "C",
     True, "F"
   )`
- Notes:
  - `Switch` evaluates conditions in order and returns the corresponding value for the first true condition.
  - Unlike `IIF`, `Switch` does not evaluate all value expressions up front, reducing some risk of side-effect errors.

Defensive patterns
- Protect `IIF` branches with `IsNothing` checks and avoid dangerous operations inside both branches.
- Use `Switch` for multi-way conditions to keep expressions readable.

When to move logic to SQL
- For complex branching or heavy computation, implement logic in the dataset query or a view for performance and testability.

Troubleshooting
- Divide-by-zero inside an `IIF` branch: use `IIF(denominator = 0, 0, numerator/denominator)` but be aware both branches may be evaluated. Prefer `=IIF(IsNothing(denominator) OR denominator = 0, 0, numerator/denominator)` or use custom code or SQL.

# SSRS Report Builder Part 7.2 - The IIf and Switch Functions

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>