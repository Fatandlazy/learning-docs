# SSRS Report Builder Part 6.6 — Collapsible and Expandable Table Groups

Back to playlist

This guide shows how to create collapsible (expand/collapse) groups in a tablix so users can show or hide detail rows interactively.

Steps to make groups collapsible
1. Add row groups (parent/child) as required.
2. Put a label or indicator in the group header (for example the group name or a +/- icon).
3. Right-click the row you want to hide/show (typically the detail row or the child group) → `Row Visibility`.
4. Choose `Hide` (to hide by default) and then check `Display can be toggled by this report item` and select the textbox in the parent header that will act as the toggle.

Design tips
- Use icons or conditional text to indicate collapsed vs expanded states. You can use an expression to show a Unicode triangle: `=IIF(Parameters!ShowDetails.Value, "▼", "►")` (where `ShowDetails` is a parameter you control), or style a static +/−.
- Ensure the toggle control is in the parent scope and not in a nested static area.

Accessibility and UX
- Make the toggle item large enough to be clickable and include clear labels for screen readers by setting `Alt Text` on the textbox.

Common issues
- Toggle doesn't affect rows: confirm the toggle item and the target rows are in the correct scopes (parent header textbox toggles child rows).
- Performance: collapsing large numbers of rows on render can still require the server to process them; consider filtering at dataset level if necessary.

Example: hide detail rows by default
- Set detail row `Visibility` to Hidden and configure toggle to the parent header textbox.

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>