# SSRS Report Builder Part 9.6 — Report Variables and Group Variables

Back to playlist

SSRS supports `Report` variables (global to the report) and `Group` variables (scoped to a group). Use variables to store intermediate results, computed values, or configuration you want to reuse.

Report variables
- Define in `Report` → `Report Properties` → `Variables`.
- Refer to a report variable with `=Variables!MyVar.Value`.
- Report variables are evaluated once per report (or per instance depending on evaluation settings) and are useful for constants, lookups or computed values that should be reused.

Group variables
- In Group Properties (right-click a group in the Row Groups pane → `Group Properties`), open `Variables` to add a group variable.
- A group variable can be an expression that is evaluated for each group instance and referenced inside that group using `=Variables!MyGroupVar.Value`.

Common uses
- Store a computed subtotal or preformatted label to reuse multiple times inside the same group.
- Cache a lookup or concatenated value for display in header/footer without recomputing.

Examples
- Report variable for report title suffix:
  - Define `ReportTitleSuffix` = `="as at " & Format(Today(), "yyyy-MM-dd")`
  - Use: `=ReportItems!TextboxTitle.Value & " " & Variables!ReportTitleSuffix.Value`

- Group variable for count of items in group:
  - Add group variable `GroupCount` = `=CountRows("MyGroup")`
  - Use in footer: `=Variables!GroupCount.Value`

Evaluation order & tips
- Be aware of evaluation order when variables depend on report items or other aggregates — avoid circular dependencies.
- If you need a variable that accumulates across groups, prefer `RunningValue` or compute in SQL.

Troubleshooting
- `#Error` when referencing a variable: ensure the variable name is correct and that it doesn't reference a report item or expression that isn't available at that evaluation phase.

# SSRS Report Builder Part 9.6 - Report Variables and Group Variables

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>