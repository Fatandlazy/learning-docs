# SSRS Report Builder Part 10.8 - Boolean Query Parameters

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>

[Watch on YouTube](https://youtu.be/H-Wid7wYAVM)

This short guide explains how to create and use Boolean (True/False) parameters in SSRS Report Builder and how to apply them to dataset queries, filters, and item visibility. It includes step-by-step UI instructions and practical examples using SQL Server (T-SQL).

**When to use a Boolean parameter**
- **Simple toggles:** Use Boolean parameters when you need a two-state choice (Yes/No, Show/Hide, Include/Exclude).
- **Visibility and conditional formatting:** Good for controlling item visibility, switching headers or sections on/off, and enabling simple filters.
- **Not for three-state choices:** If you need an "All / Yes / No" option, use a multi-value or text parameter (or allow null) instead of Boolean.

**1) Create a Boolean report parameter**
1. Open the **Report Data** pane (View → Report Data).
2. Right-click `Parameters` → **Add Parameter**.
3. Set **Name** (for example: `IncludeInactive`), **Prompt** (e.g. "Include inactive records?"), and **Data type** → **Boolean**.
4. Optionally set a **Default value** (True or False). Click **OK**.

Note: Boolean parameters present a simple checkbox in the report viewer: checked = True, unchecked = False.

**2) Pass the parameter to a dataset (T-SQL example)**
If your dataset uses a text query with a parameter placeholder, reference the parameter in the SQL and map the dataset parameter to the report parameter.

Example table structure:
- `Employees(Id, Name, IsActive bit)`

Simple query that applies the Boolean value directly:

```sql
SELECT Id, Name, IsActive
FROM Employees
WHERE IsActive = @IncludeInactive
```

Mapping: open the Dataset Properties → Parameters and add a mapping:
- **Name:** `@IncludeInactive` (the parameter name used in the query)
- **Value:** `=Parameters!IncludeInactive.Value`

Behavior:
- If you always want to filter exactly by the parameter (True => show active rows when IsActive = 1), use `WHERE IsActive = @IncludeInactive`.
- If the parameter means "Include inactive rows in addition to active rows" then the query logic differs (see next example).

Example: parameter used as a toggle to include inactive rows as well as active rows:

```sql
-- When IncludeInactive = 1 (True) return all rows; when 0 (False) return only active rows
SELECT Id, Name, IsActive
FROM Employees
WHERE (@IncludeInactive = 1) OR (IsActive = 1)
```

This evaluates as: when the checkbox is checked, the first condition is true and the filter allows all rows; when unchecked, only rows with `IsActive = 1` remain.

**3) Using Boolean parameters in dataset/tablix filters**
- You can apply the Boolean parameter in a dataset or tablix filter (Properties → Filters): choose the field (`IsActive`), operator `=`, and value `=Parameters!IncludeInactive.Value`.

**4) Using Boolean parameters to control visibility**
To hide or show report items (textboxes, tables, images), set the item's **Hidden** property to an expression that references the parameter.

Examples:
- To show the header only when the parameter is True: set Hidden to `=Not Parameters!ShowHeader.Value`.
- To hide a textbox when the parameter is True: set Hidden to `=Parameters!HideDetails.Value`.

**5) Common pitfalls and tips**
- Boolean parameters cannot express a third "All" state. If you need All / Yes / No, use a different parameter type (Text or Integer) with explicit choices or allow null values and adjust your SQL accordingly.
- When mapping a Boolean to a SQL `bit` parameter, SSRS correctly converts the value. If you have issues, ensure dataset parameters are mapped to `=Parameters!MyBoolean.Value`.
- For complex queries prefer explicit conditions rather than relying on implicit conversions. Use `(@Param = 1)` style checks for clarity.
- Always Preview the report after creating parameters to ensure the parameter UI and mapping behave as expected.

**6) Example scenarios**
- Toggle a shipping address block: create `ShowShipping` (Boolean) and set the shipping textbox Hidden expression to `=Not Parameters!ShowShipping.Value`.
- Include archived orders: create `IncludeArchived` (Boolean) and use `WHERE (@IncludeArchived = 1) OR (Archived = 0)` in the orders dataset.

**Quick checklist before publishing**
- Parameter created and Prompt text clear.
- Data type set to `Boolean`.
- Dataset parameter mapping uses `=Parameters!YourParam.Value`.
- Previewed and behavior tested for both True and False states.

Thanks for following along — use Boolean parameters for simple toggles and visibility rules; switch to more flexible parameter types when you need a third state or complex selections.

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>
