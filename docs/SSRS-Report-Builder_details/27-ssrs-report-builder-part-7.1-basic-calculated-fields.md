# SSRS Report Builder Part 7.1 — Basic Calculated Fields

Back to playlist

Calculated fields (expressions) allow you to compute values in the report using dataset fields, constants, and functions. This guide covers creating simple calculated fields and where to place them (dataset vs report textbox vs calculated field in the dataset designer).

Where to calculate
- **In SQL/dataset**: best for performance; put core calculations in the query or a view.
- **Calculated field in the dataset (Report Builder)**: useful for quick expressions when you can't change the source query.
- **Textbox expression**: good for display-only logic or conditional formatting.

Creating a calculated field in Report Builder
1. Open the Dataset Properties → `Fields` tab.
2. Click `Add` → `Calculated Field`.
3. Give the field a name and enter an expression, e.g., `=Fields!Quantity.Value * Fields!UnitPrice.Value`.

Common expressions
- Currency formatting: `=FormatCurrency(Fields!Total.Value)`
- Conditional display: `=IIF(Fields!Amount.Value > 0, "Credit", "Debit")`
- Date formatting: `=Format(Fields!OrderDate.Value, "yyyy-MM-dd")`

Performance tips
- Prefer dataset-level calculations for large datasets.
- Avoid repeated complex expressions in many rows; instead, create a calculated field once and reuse it.

Troubleshooting
- Type errors: cast fields using `CInt`, `CDbl`, or `CDec` when necessary.
- NULLs: protect expressions using `IsNothing` checks or `IIF(IsNothing(Fields!X.Value), 0, Fields!X.Value)`.

# SSRS Report Builder Part 7.1 - Basic Calculated Fields

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>