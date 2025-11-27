# SSRS Report Builder Part 7.4 — Logical Operators: AND / OR / ANDALSO / ORELSE / XOR / NOT

Back to playlist

This guide explains the logical operators available in SSRS expressions, their differences (especially between `And`/`Or` and `AndAlso`/`OrElse`) and when to prefer one over another.

Common logical operators
- `And`, `Or` — evaluate both operands. Use when both sides are safe to evaluate.
- `AndAlso`, `OrElse` — short-circuiting operators: the second operand is only evaluated if needed. Use to avoid evaluating expressions that could cause errors (e.g., divide-by-zero) or are expensive.
- `Not` — logical negation: `=Not(Fields!IsActive.Value)`
- `Xor` — exclusive OR: true when exactly one operand is true.

Examples
- Safe check using `AndAlso`:
  `=Fields!Denominator.Value <> 0 AndAlso Fields!Numerator.Value / Fields!Denominator.Value > 1`
  This prevents division when Denominator is zero because `AndAlso` short-circuits.
- Using `OrElse` for null checks:
  `=IsNothing(Fields!Value.Value) OrElse Fields!Value.Value = ""`

Performance and safety
- Prefer `AndAlso`/`OrElse` when the second operand may be expensive or unsafe to evaluate.
- Use `And`/`Or` when you explicitly want both sides evaluated (rare in report expressions).

Troubleshooting
- Unexpected evaluation: if you see errors from expressions inside `IIF` or `And`/`Or`, switch to `AndAlso`/`OrElse` or move risky logic into helper functions or SQL.

# SSRS Report Builder Part 7.4 - And, Or, AndAlso, OrElse, Xor and Not

TODO: Add detail notes for this tutorial.

Back to playlist

Back to playlist