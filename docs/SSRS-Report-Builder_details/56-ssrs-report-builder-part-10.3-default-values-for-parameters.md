# SSRS Report Builder Part 10.3 — Default Values for Parameters

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>

This page explains how to set default values for report parameters, including static defaults, dataset-driven defaults, and expressions (for example, default to today or the first day of the month).

Setting defaults in Report Builder
- Open `Report` → `Report Parameters` and select a parameter.
- Use the `Default Values` tab to choose:
  - `None` — user must select a value.
  - `Specify values` — enter one or more static defaults.
  - `Get values from a query` — bind defaults to a dataset that returns available defaults.

Examples
- Default to Today for a date parameter:
  - Set default value expression: `=Today()`
- Default to first day of current month:
  - `=DateSerial(Year(Today()), Month(Today()), 1)`
- Default multi-value parameter to all values from a dataset:
  - Use `Get values from a query` with a dataset that returns all options.

Using dataset-driven defaults
- Helpful when defaults depend on dynamic data (current financial period, last run date, user-specific options).
- Ensure the dataset returns the correct number and type of values expected by the parameter (single vs multi-value).

Performance considerations
- If default dataset is expensive, it runs when the parameter UI loads; keep default datasets small or cache them as shared datasets.

Security and user defaults
- When default values depend on user identity (e.g., department), use `User!UserID` in the dataset query or parameters to limit results.

Troubleshooting
- Type mismatch errors: ensure the dataset field types match the parameter type (date, integer, string).
- No default appearing: check the dataset executes successfully and returns the expected values.

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>