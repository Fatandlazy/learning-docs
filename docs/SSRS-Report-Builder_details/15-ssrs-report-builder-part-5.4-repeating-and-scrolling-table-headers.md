# SSRS Report Builder — Part 5.4: Repeating and Scrolling Table Headers

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>

Objective: Explain how to make table/tablix headers repeat on each printed page and remain visible while scrolling in the Report Builder preview (and in the web portal). This guide covers the difference between page headers and tablix headers, the required tablix/member properties, step-by-step UI instructions, common pitfalls and troubleshooting tips.

Overview
- Repeating headers and fixed (scrolling) headers are two related behaviors:
	- Repeating headers: the header rows of a tablix (table/matrix/list) are printed at the top of each page in a paginated (print/PDF) render.
	- Fixed (scrolling) headers: the header rows remain visible at the top of the data region when you scroll the report in the Report Builder preview or the web portal.

Important differences
- Page header (Report → Page Header) appears on every page but is part of the page, not the tablix. It is suitable for titles, logos and page-level information.
- Tablix header rows are part of the data region and can be repeated per page or fixed during interactive scrolling. Use tablix headers when the column headings must align with the data columns and repeat for each page or scroll.

Quick checklist (what to set)
- For repeating header rows on every page (paginated output): set the corresponding tablix row member property `RepeatOnNewPage = True`.
- To keep the header row with the group when a group breaks across pages, set `KeepWithGroup = After` (or `Before` for different layout needs).
- For interactive scrolling (fixed header in preview/portal), set the tablix row member property `FixedData = True`.

Step-by-step: make a table header repeat on every page
1. Select the Table (click inside the tablix so handles appear).
2. In the Grouping pane (usually at the bottom), click the small arrow on the right and choose `Advanced Mode` to reveal static row/group members.
3. In the Row Groups area, identify the `Static` member that corresponds to the header row (usually the top-most `Static`).
4. Select that `Static` member. In the Properties pane (press F4 if hidden):
	 - Set `RepeatOnNewPage` = `True`.
	 - Set `KeepWithGroup` = `After` (so the header stays attached to the following group rows).
5. Preview or export to verify the header repeats on each page.

Step-by-step: keep header visible when scrolling (interactive/fixed header)
1. Follow steps 1–3 above to expose the `Static` header member in Advanced Mode.
2. With the header's `Static` member selected in the Grouping pane, set `FixedData` = `True` in the Properties pane.
3. Preview the report in Report Builder or open it in the Report Server web portal. When you scroll the data region vertically, the header row should remain visible at the top of the region.

Notes about groups and multiple header rows
- If your tablix has multiple header rows (for example, multi-row column headings or grouped column headers), set `RepeatOnNewPage` and `FixedData` on each relevant `Static` header member.
- For grouped tablix, you may need to set `KeepWithGroup` appropriately on the header static row and the group static rows to avoid orphaned headers or missing headers at page breaks.

Common pitfalls and troubleshooting
- Nothing repeats on new page: ensure you set `RepeatOnNewPage` on the `Static` row member (not on the tablix control itself). Use Advanced Mode to find the correct static member.
- Header repeats but columns misalign on pages: check that the header cells are in the tablix header rows (not in a separate rectangle) and that no overlapping items exist that change column widths.
- Fixed headers don't stick while scrolling: confirm `FixedData` = `True` on the header static member; note that `FixedData` works in interactive HTML preview and the web portal, but not in exported PDF/print (for PDF you get repeated headers via `RepeatOnNewPage`).
- Merged cells and repeating headers: merged cells may complicate which static member is the header. If a header row is not marked as a `Static` member, try unmerging temporally to identify the proper member, then re-merge carefully.
- Page header vs tablix header confusion: if you put column headings in the Page Header the headings will not scroll with the tablix and may not align with columns if the tablix layout changes. Prefer tablix header rows for column headings.

Performance and rendering considerations
- Repeating many large header groups can increase page generation work for large reports — keep headers concise.
- `FixedData` adds client-side behavior in the HTML viewer; it has no effect on paginated renderers (PDF/Word). Use `RepeatOnNewPage` for paginated outputs.

Example: typical settings for a simple table
- Table has one header row. In Advanced Mode select the top-most `Static` row member and set:
	- `RepeatOnNewPage = True`
	- `KeepWithGroup = After`
	- `FixedData = True` (if you want the header to stay visible while scrolling)

Example: grouped table where header should repeat per group
- If your table groups by `Region`, and you want the column headings to repeat at each page and remain fixed while scrolling:
	- Apply `RepeatOnNewPage` and `FixedData` to the header static member(s).
	- For the Region group member, set `PageBreak` options if you require page breaks between regions, and use `KeepWithGroup` on the headers to control adjacency.

Suggested checks before publishing
- Preview in Report Builder (interactive) and confirm fixed-scrolling behavior.
- Export to PDF to confirm headers repeat on each printed page.
- Test with realistic data sizes and a variety of page sizes (A4/Letter) to ensure expected behavior.

Further reading / troubleshooting
- If headers still behave unexpectedly, enable `Advanced Mode` and inspect every `Static` member’s properties; occasionally adjustments are needed for nested groups.
- Consider using Shared Datasets and a simplified tablix layout when reports become complex and slow to render.

Would you like me to add annotated screenshots showing the Grouping pane in Advanced Mode and the Properties pane settings? I can add placeholders or real screenshots if you provide sample images.

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>