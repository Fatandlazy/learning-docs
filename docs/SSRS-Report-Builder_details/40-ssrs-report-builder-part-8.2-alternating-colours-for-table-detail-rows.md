# SSRS Report Builder Part 8.2 — Alternating Colours for Table Detail Rows

Back to playlist

Alternating row colours improve readability. Use `RowNumber()` with modulo to alternate backgrounds.

Simple alternating rows across the whole table
- Set the `BackgroundColor` property on the detail row to:
  `=IIF(RowNumber(Nothing) Mod 2 = 0, "#FFFFFF", "#F7F7F7")`

Alternating within a group
- To restart alternating per group, use the group name as the scope:
  `=IIF(RowNumber("CategoryGroup") Mod 2 = 0, "#FFFFFF", "#F7F7F7")`

Alternating while ignoring header rows
- Use `RowNumber` on the dataset or group scope to ensure header/static rows don't affect alternation.

Performance and styling tips
- Use subtle contrast colours to avoid printing issues.
- For high-row-count tables consider simpler visuals to reduce render time.

Troubleshooting
- Alternation breaks at page breaks: use `KeepTogether`/`KeepWithGroup` if you need continuity but be mindful of pagination.

# SSRS Report Builder Part 8.2 - Alternating Colours for Table Detail Rows

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>