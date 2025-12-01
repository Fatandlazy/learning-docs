# Wise Owl Answers - How do I show a value on only the first page of group in SSRS?

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>

[Watch on YouTube](https://youtu.be/S_GQZ24HCwU)

This note explains methods to show a value only on the first page of a group in SSRS (for example: a group header value that should appear only on the group's first printed page).

Problem
- When groups span multiple pages, you may want a summary value or title to appear on the first page of the group only, not repeated on subsequent pages.

Approaches

1) Use the `RunningValue` function with page breaks (limited)
- `RunningValue` can be used to detect the first occurrence of a group but it does not have awareness of pagination. It is not reliable to detect physical pages.

2) Use group header and set `RepeatOnNewPage` appropriately
- Place the value in the group header and set the header's **RepeatOnNewPage** property to `False` so it appears when the group starts but does not repeat on subsequent pages. This is the simplest and most robust approach.

Steps:
1. Select the group header row → Row Group Properties → **Page Breaks** and ensure page breaks are set where needed.
2. Select the textbox in the header → Properties → set `RepeatOnNewPage` = `False` (or uncheck "Repeat header rows on each page").

3) Use visibility expressions for print layout (advanced)
- In some cases you can set the text box visibility using an expression that checks the row number within the group: `=IIF(RowNumber("GroupName") = 1, False, True)` to hide for non-first rows. This hides by logical row, not physical page.

4) Use page header with conditional visibility (not reliable for group-first-only)
- Page headers are global to the page and cannot easily be made specific to a group's first page only without complex expressions and careful layout.

Recommendations
- Use a group header and disable repeating headers on subsequent pages — this matches the requirement to show the value only at the start of a group.
- If you need more complex behavior tied to the physical printed page, consider rendering to PDF and post-processing, or redesigning the report layout to place the value within content that naturally appears once.

Tips
- Test with multi-page groups and exported formats (PDF) to confirm behavior.
- For interactive viewers, pagination may differ from printed/PDF output; always test the target output format.

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>
