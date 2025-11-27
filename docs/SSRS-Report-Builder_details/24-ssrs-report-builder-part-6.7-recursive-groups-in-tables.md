# SSRS Report Builder Part 6.7 — Recursive Groups in Tables

Back to playlist

This page covers recursive (hierarchical) grouping in a tablix — for example, an organizational chart or parent-child relationship where a row may have a parent row in the same dataset.

Dataset requirements
- A recursive group requires a dataset with at least two key columns: the item ID and the parent ID (e.g., `EmployeeID`, `ManagerID`). Root nodes typically have `NULL` or a sentinel value for `ParentID`.

Steps to create a recursive group
1. Use a dataset that contains the hierarchical relationships (ID + ParentID).
2. Insert a table and bind it to the dataset.
3. In the `Row Groups` pane, add a row group and choose `Group on` the hierarchical expression that represents the level (often simply `=Fields!EmployeeID.Value` for detail, then set the group to recursive in the group properties).
4. Open Group Properties → `General` and select `Recursive` (or in some versions look for `Parent group` options) and set the parent group expression to the ParentID field (for example `=Fields!ManagerID.Value`).

Display formatting
- Use padding or nested columns to visually indent each level. For example, set textbox `Padding.Left` with an expression that multiplies by the group depth.
- Use `Level` or `RowNumber` expressions if you need to display depth. SSRS provides `Level` for recursive groups to help with formatting.

Performance and dataset size
- Recursive rendering can be expensive for very large hierarchies. Consider pre-computing hierarchical levels in SQL or using a stored procedure to return a flattened hierarchy with level numbers.

Example expression for indentation
- `=CStr(Repeat(" ", Fields!Level.Value * 4)) & Fields!EmployeeName.Value` (where `Fields!Level` is provided by your SQL or computed via recursive CTE).

Troubleshooting
- Incorrect parent/child matching: ensure ID and ParentID types match and NULL parents are handled.
- Infinite recursion: verify there are no cycles in the dataset (A -> B -> A).

# SSRS Report Builder Part 6.7 - Recursive Groups in Tables

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>