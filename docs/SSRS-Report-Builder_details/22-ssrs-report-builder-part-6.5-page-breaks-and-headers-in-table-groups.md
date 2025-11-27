# SSRS Report Builder Part 6.5 — Page Breaks and Headers in Table Groups

Back to playlist

This page explains options for controlling page breaks and repeating headers for grouped tablix data. These settings are important for printable reports and readable PDF/Excel exports.

Group page break options
- Open Group Properties → `Page Breaks`.
- Options include:
  - `Between each instance of a group` (page break between each group)
  - `At the start of a group` (page break before the group)
  - `At the end of a group` (page break after the group)

Repeating headers on each page
- To repeat column headers for table groups on every printed page:
  - Select the tablix, open `Tablix Properties` → `Row Headers` and check `Repeat header rows on each page`.
  - Also set the row properties: in the Row Groups pane, right-click the static header row → `Advanced Mode` might be required to expose static rows, then set `RepeatOnNewPage = True` and `KeepWithGroup` as needed.

KeepWithGroup and KeepTogether
- `KeepWithGroup` ensures the header stays together with the following rows.
- `KeepTogether` tries to avoid splitting the group across pages when possible.

Export considerations (Excel / PDF)
- Excel: repeated headers translate to frozen panes if the export supports it; page breaks become XLSX page breaks which users can adjust.
- PDF: page breaks are enforced; avoid `Between each instance of a group` for many small groups to prevent many tiny pages.

Practical examples
- Print each parent group on a new page (use `Page break at start` on parent group) for department-level reports.
- Keep headings on each page for long tables (enable `Repeat header rows on each page`).

Troubleshooting
- Header not repeating: verify the header row is a static row (use Advanced Mode) and `RepeatOnNewPage` is set.
- Unexpected blank pages: check page break settings on groups and the overall report page size + margins.

# SSRS Report Builder Part 6.5 - Page Breaks and Headers in Table Groups

TODO: Add detail notes for this tutorial.

Back to playlist

Back to playlist