# Wise Owl Answers - How do I hide columns using parameters in SSRS?

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>

[Watch on YouTube](https://youtu.be/tgWn6hLIEsw)

This note explains how to hide/show columns in SSRS using report parameters. You can control column visibility at design time with expressions that reference parameters, enabling user-customisable column layouts.

Scenarios
- Hide optional detail columns based on a Boolean parameter.
- Allow users to select which columns to show using a multi-value parameter.

1) Hiding a column with a Boolean parameter
1. Create a Boolean parameter (for example `ShowDetails`).
2. Select the column (or column header textbox) → Column Visibility → **Show or hide based on an expression**.
3. Use an expression that references the parameter; to hide when `ShowDetails` is False use:

```
=Not Parameters!ShowDetails.Value
```

2) Hiding columns using a multi-value parameter (select which columns to show)
- Create a multi-value parameter `VisibleColumns` whose available values are the column keys or names.
- For the column visibility expression, test whether the column's key is in the selected values using `In` with `Join` or `IndexOf` pattern. Example expression:

```vb
=Not (Fields!ColumnKey.Value IN Parameters!VisibleColumns.Value)
```

If `IN` is not supported directly in the expression context, use `IndexOf` on a joined string:

```vb
=InStr(
	"," & Join(Parameters!VisibleColumns.Value, ",") & ",",
	"," & Fields!ColumnKey.Value & ","
) = 0
```

3) Alternative: set column width to zero (not recommended)
- Some developers prefer setting the column width to `0cm` to hide; visibility is cleaner and more semantically correct.

Tips
- Ensure the column key used in expressions matches the available values supplied to the parameter.
- For grouped columns or matrix columns, place visibility on the appropriate textbox or member so the whole column hides correctly.
- Test exported formats (Excel) — hidden columns may behave differently depending on the renderer.

Preview and test: try toggling the parameter values and exporting to different formats to ensure the column visibility behaves as expected.

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>
