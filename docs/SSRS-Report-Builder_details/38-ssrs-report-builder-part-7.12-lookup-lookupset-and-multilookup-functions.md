# SSRS Report Builder Part 7.12 — `Lookup`, `LookupSet` and `MultiLookup` Functions

Back to playlist

These functions let you find values from another dataset inside report expressions. They are useful when you need to enrich a dataset row with lookup values without joining in SQL.

`Lookup(sourceExpression, destinationExpression, resultExpression, dataset)`
- Returns the first matching `resultExpression` from `dataset` where `destinationExpression` equals `sourceExpression`.
- Example: `=Lookup(Fields!ProductID.Value, Fields!ProductID.Value, Fields!ProductName.Value, "Products")`

`LookupSet(sourceExpression, destinationExpression, resultExpression, dataset)`
- Returns an array of all matching `resultExpression` values.
- Example: `=LookupSet(Fields!CustomerID.Value, Fields!CustomerID.Value, Fields!OrderID.Value, "Orders")`
- To display multiple matches: `=Join(LookupSet(...), ", ")` or aggregate with custom code.

`MultiLookup` (extension in some platforms)
- Not available in older SSRS; when present, can return multiple columns or more complex matches. Prefer `LookupSet`+`Join` if `MultiLookup` not available.

Performance and best practices
- Prefer joining in SQL for large datasets — lookups happen per report row and can be slow.
- Cache small lookup datasets using shared datasets where possible.

Handling no match
- `Lookup` returns `Nothing` if no match. Protect with `IsNothing` checks: `=IIF(IsNothing(Lookup(...)), "(not found)", Lookup(...))`

Aggregating `LookupSet` results
- To compute numeric totals from `LookupSet`, use a small helper in Report Properties → Code:
  ```vb
  Public Function SumLookup(items As Object()) As Decimal
    Dim s As Decimal = 0
    If items Is Nothing Then Return 0
    For Each i As Object In items
      s += CDec(i)
    Next
    Return s
  End Function
  ```
  Then call: `=Code.SumLookup(LookupSet(...))`

Troubleshooting
- Different data types: ensure the lookup keys are the same type (string vs numeric). Convert using `CStr`/`CInt` as appropriate.
- Unexpected duplicates: `Lookup` returns the first match, `LookupSet` returns all; choose according to desired behaviour.

# SSRS Report Builder Part 7.12 - Lookup, LookupSet and MultiLookup Functions

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>