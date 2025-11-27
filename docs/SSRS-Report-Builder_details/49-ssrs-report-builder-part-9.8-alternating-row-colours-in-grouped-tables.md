# SSRS Report Builder Part 9.8 — Alternating Row Colours in Grouped Tables

Back to playlist

Alternating row colours that restart within each group improve readability for grouped data. Use `RowNumber("GroupName") Mod 2` to alternate within group scope.

Example
- In the detail row `BackgroundColor` property use:
  `=IIF(RowNumber("CategoryGroup") Mod 2 = 0, "#FFFFFF", "#F7F7F7")`

Notes
- Replace `CategoryGroup` with the actual group name from the Row Groups pane.
- This restarts counting for each group instance so each category alternates from its first row.

Troubleshooting
- If alternation appears to shift across pages, verify scopes and use `KeepTogether` if appropriate.

# SSRS Report Builder Part 9.8 - Alternating Row Colours in Grouped Tables

TODO: Add detail notes for this tutorial.

Back to playlist

Back to playlist