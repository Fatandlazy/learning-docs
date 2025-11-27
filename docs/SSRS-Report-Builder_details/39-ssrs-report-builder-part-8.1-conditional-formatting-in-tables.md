# SSRS Report Builder Part 8.1 — Conditional Formatting in Tables

Back to playlist

Conditional formatting uses expressions to set properties like `BackgroundColor`, `Color`, `FontWeight`, or `Format` based on data values.

Basic examples
- Highlight high sales:
  - `BackgroundColor` expression: `=IIF(Fields!Sales.Value > 1000, "#DFF0D8", "Transparent")`
- Red text for negatives:
  - `Color` expression: `=IIF(Fields!Amount.Value < 0, "Red", "Black")`

Using rules vs expressions
- The property expression approach (set `BackgroundColor` to an expression) is flexible and more common in Report Builder. Use custom code for reusable logic.

Complex rules and performance
- Avoid very expensive expressions evaluated per-cell. Move heavy calculations to the dataset when possible.
- For multiple conditions, `Switch` is often clearer:
  `=Switch(
     Fields!Score.Value >= 90, "#00FF00",
     Fields!Score.Value >= 75, "#FFFF00",
     True, "#FFFFFF"
  )`

Formatting numbers and dates conditionally
- Use `Format` or `FormatCurrency` in expressions, or set the `Format` property using an expression.

Accessibility and printing
- Ensure color changes are not the only indicator of important data — include icons or text for users with color vision deficiencies.

Troubleshooting
- Expression errors: check for `Nothing` and guard with `IsNothing` or default values.
- Colors not applied: ensure the expression is set on the correct textbox/cell and not overridden by parent styles.

# SSRS Report Builder Part 8.1 - Conditional Formatting in Tables

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>