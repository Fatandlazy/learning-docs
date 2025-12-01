# SSRS Report Builder Part 11.4 - Multi Value Parameters and Null Values

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>

[Watch on YouTube](https://youtu.be/aoJtPPasT6c)

This note explains interactions and limitations between multi-value parameters and null/optional values in SSRS, and offers recommended workarounds.

Key constraint
- SSRS does not allow a parameter to be both multi-value and allow null at the same time. The UI disables the "Allow null value" option when "Allow multiple values" is checked.

Common workarounds

1) Add an explicit "All" choice to the available values
- Include a sentinel value (for example `NULL`, `0`, or `'(All)'`) in the parameter's available values list to represent the "All" case. Handle this sentinel value in your SQL query.

Example SQL handling when NULL represents All:

```sql
SELECT * FROM Orders
WHERE (@CategoryID IS NULL) OR (CategoryID IN (SELECT value FROM STRING_SPLIT(@CategoryList, ',')))
```

2) Use a separate Boolean parameter to indicate All
- Create a Boolean `IncludeAll` parameter. In SQL use `(@IncludeAll = 1) OR (CategoryID IN (...))`.

3) Use filters inside SSRS instead of SQL
- Retrieve the superset of rows from the server and apply a tablix or dataset filter using the `In` operator with the multi-value parameter; this avoids needing NULL values on the parameter itself.

4) Pass a delimited string + parse
- Join the multi-value selections with `Join(Parameters!Param.Value, ',')` and pass the string to the dataset. Parse it in SQL using `STRING_SPLIT` or a custom splitter. Provide an All-case sentinel if needed.

Example mapping and SQL:

Report dataset parameter mapping:
```
@CategoryList = =Join(Parameters!CategoryIDs.Value, ',')
```

SQL:

```sql
IF @CategoryList IS NULL OR @CategoryList = ''
BEGIN
	SELECT * FROM Orders -- no category filter
END
ELSE
BEGIN
	SELECT * FROM Orders
	WHERE CategoryID IN (SELECT value FROM STRING_SPLIT(@CategoryList, ','))
END
```

Tips
- Clearly label the UI so users understand how to select All (e.g., add `(All)` as a visible option).
- Test edge cases: no selection, selecting only All, mixing All with other selections (prevent mixing by design where possible).

Summary
- Because SSRS prohibits multi-value + null on the same parameter, prefer an explicit All sentinel or a separate boolean parameter, or move filtering to the report layer.

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>
