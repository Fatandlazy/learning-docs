# SSRS Report Builder Part 7.3 — Handling Divide-By-Zero Errors

Back to playlist

Divide-by-zero errors commonly occur in report expressions when a denominator may be zero or NULL. This page outlines defensive expression patterns and alternatives.

Simple defensive expression
- Use `IIF` with an `IsNothing` and zero-check:
  `=IIF(IsNothing(Fields!Denominator.Value) OR Fields!Denominator.Value = 0, 0, Fields!Numerator.Value / Fields!Denominator.Value)`

Note about `IIF` evaluation
- `IIF` evaluates both the true and false parts, so the numerator/denominator expression may still be evaluated even when denominator is zero. To avoid this, prefer one of the alternatives below.

Safe alternatives
- Use `Switch` or nested `IIF` carefully when the evaluated expressions are safe, but `Switch` short-circuits conditions in order and avoids evaluating later expressions when an earlier condition is true.
- Use custom code (Report Properties → Code) to create a helper function:
  ```vb
  Public Function SafeDivide(ByVal numer As Decimal, ByVal denom As Decimal) As Decimal
    If denom = 0 Then
      Return 0
    Else
      Return numer / denom
    End If
  End Function
  ```
  Then call `=Code.SafeDivide(Fields!Numerator.Value, Fields!Denominator.Value)` in your textbox expression.
- Calculate in SQL: perform `CASE WHEN Denominator = 0 OR Denominator IS NULL THEN 0 ELSE Numerator / Denominator END` in the dataset query.

Formatting and nulls
- Use `COALESCE` or `ISNULL` in SQL to replace NULLs before dividing: `COALESCE(Denominator, 0)`.

Best practices
- Prefer dataset-level handling for large datasets.
- Use functions in `Code` when you want a central, reusable safe-divide helper in the report.

# SSRS Report Builder Part 7.3 - Divide by Zero Errors

TODO: Add detail notes for this tutorial.

Back to playlist

Back to playlist