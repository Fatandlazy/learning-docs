# SSRS Report Builder Part 10.6 — Cascading (Parent–Child) Parameters

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>

Cascading parameters (also called dependent parameters) let you filter parameter value lists based on the selection of another parameter. Common example: choose Country → filtered list of States → filtered list of Cities.

1) Implementation steps
- Create the parent parameter first (e.g., `Country`). Provide an `Available Values` dataset for it.
- Create the child parameter (e.g., `State`) and set its `Available Values` dataset to query based on the parent parameter, passing `@Country` into the child dataset query.

2) Example SQL
- Parent dataset (Countries):

  SELECT CountryID, CountryName FROM dbo.Countries ORDER BY CountryName

- Child dataset (States) using the parent parameter:

  SELECT StateID, StateName
  FROM dbo.States
  WHERE CountryID = @CountryID
  ORDER BY StateName

3) Important notes
- Parameter evaluation order: Report Builder evaluates parameters in creation order. Create the parent parameter before the child, or set a `Default Value` that resolves independently.
- If you change parameter order later, re-open the parameter dialog to validate evaluation order.

4) Performance tips
- Keep child datasets small: return only the columns required for parameter display and value.
- Avoid querying extremely large lookup tables on each parameter refresh; consider caching strategies or search-as-you-type UI.

5) Cascading with multi-value parents
- When the parent is multi-value, adapt the child dataset SQL to handle multiple values. Using a table-valued parameter in stored procedures is preferred. If that's not available, you can accept a delimited string and split it server-side.

6) Client-side (report) filtering alternative
- Instead of chaining datasets, you can load a moderately sized dataset and use report filters on the child parameter's available values dataset. This keeps fewer round trips to the database but may load more data initially.

7) Troubleshooting
- Child parameter shows empty list: confirm that the parent parameter has a default or selected value and that the child dataset uses the correct parameter name.
- Values not updating: check that the dataset query parameter is correctly mapped to the report parameter in the dataset properties UI.

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>