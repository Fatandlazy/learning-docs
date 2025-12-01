# SSRS Report Builder Part 12.1 - Drill Through Reports using Tables

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>

[Watch on YouTube](https://youtu.be/7Qk8BWLwGPI)

This note explains how to configure drill-through actions from table cells in SSRS Report Builder. Drill-through reports let users click on a value in the parent report and open a related (target) report filtered to that context.

When to use drill-through
- Use drill-through to allow users to explore details for a specific row, ID, or group without overloading the main report.

Basic steps
1. Create or identify the target report that accepts parameters (for example, `OrderDetails.rdl` that accepts `OrderID`).
2. In the parent report insert a table (or use an existing table) and identify the field or cell you want to make clickable (for example, the OrderID or OrderNumber cell).
3. Right-click the textbox (or cell) → **Text Box Properties** → **Action**.
4. Choose **Go to report**, then choose the target report from the list (or enter the report path on the server).
5. Add parameter mappings: for each target report parameter provide the expression or field value to pass. Example: set target `OrderID` = `=Fields!OrderID.Value`.
6. (Optional) Choose to open in a new window by setting the Jump to report action's target to a new browser window (usually done via the report server link or target parameter in the web portal; in Report Builder you can set the action but opening behavior is typically handled by the web viewer).

Examples
- Drill to order details by passing the order identifier:

Parent report cell action mapping:
- Target report: `OrderDetails`
- Parameters: `OrderID` = `=Fields!OrderID.Value`

Notes and tips
- Parameter names and types must match those expected by the target report. If the target parameter is of type Integer, ensure you pass a numeric value or cast in an expression.
- If the target report is on a different folder on the report server, provide the full path or ensure the folder is browsable from the parent report.
- For multiple parameters, pass each explicitly: `CustomerID = =Fields!CustomerID.Value`, `OrderDate = =Fields!OrderDate.Value`.
- For group-level drill-through (drills from a group header), pass the group key so the target shows all details for that key.
- Preview and test the drill-through in Report Builder's preview and after deployment on the report server — behavior may differ between the designer preview and the deployed web viewer.

Troubleshooting
- Target report not listed: ensure the target is deployed to the report server, and you have correct path/permissions.
- Parameter mismatch error: confirm parameter names and data types; use `CInt()` or `CStr()` in expressions if necessary.

Advanced
- Use expressions to pass calculated values or combine fields (for example `=Fields!Country.Value & "," & Fields!Region.Value`) and have the target report split/parse as required.

Security
- Users need permission to run the target report; ensure roles and permissions are configured on the report server.

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>
