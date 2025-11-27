# SSRS Report Builder — Part 4.7: Entering and Copying Data into a Report

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>

Objective: How to enter data manually, copy/paste from Excel or text, embed temporary data in a report, and best practices for formatting and validation before publishing.

1) When to enter data directly in a report
- Use manual data entry for demos, templates, or when the dataset is small and does not require automatic updates.
- Useful for adding quick reference values (for example mapping lists or dynamic headings) without creating a dedicated data source.

2) Entering data with an embedded dataset (manual entry)
- In Report Builder: `Data` → `Add Dataset` → select `Use a dataset embedded in my report` → set `Type = Text`.
- Some Report Builder versions include an `Enter data manually` or `Embedded Data` option. If the UI does not provide direct entry, you can create an XML dataset or use `VALUES` in a SQL query as a workaround. Example:

```sql
SELECT * FROM (
  SELECT 1 AS ID, 'Alpha' AS Name
  UNION ALL SELECT 2, 'Beta'
  UNION ALL SELECT 3, 'Gamma'
) AS T;
```

3) Copy/paste from Excel or CSV
- Paste directly into a table in Report Builder:
  - Typically copy data from Excel, create a Table in Report Builder, select the first cell in design view and paste. Some versions support pasting into individual cells.
  - If pasting doesn't work, use an intermediate step: copy from Excel → paste into Notepad → save as `.csv` → import or convert, or paste values into a `VALUES`-style query, or load the CSV into a staging table on the DB and create a Dataset from it.

4) Import from Excel using a Shared/Embedded Dataset
- For larger or repeatable imports, load the Excel file into the database (a staging table) and point a Shared/Embedded Dataset at that table. Typical steps:
  - Use SSIS or another import tool to load Excel into a staging table on SQL Server.
  - Create a Shared Data Source / Dataset pointing to the staging table.
  - Publish the dataset/report.

5) Data formatting and data types
- When typing or pasting data, verify the data type (Text/Date/Number). For date fields ensure the format matches and use Date-type Report Parameters when applicable.
- If using `VALUES` to simulate data in SQL, `CAST` or `CONVERT` columns to the correct data types to avoid issues when publishing.

6) Special characters and encoding tips
- When pasting Unicode characters from Excel, make sure the clipboard preserves encoding. If you encounter odd characters, paste via Notepad++ and convert encoding as needed.

7) Use Report Parts or Shared Datasets for reusable sample data
- If you frequently reuse the same sample/mapping table, create a Shared Dataset or a Report Part instead of re-entering data manually.

8) Validate & preview
- After entering data, always `Run` (Preview) the report to check layout, numeric/date formatting, and aggregation logic.

9) Common troubleshooting
- Paste fails or columns misalign: ensure the correct cell is selected before pasting, or paste via Notepad and use a `VALUES` query.
- Dates/numbers display incorrectly: check the machine locale and the Report Parameter types.
- Large manual datasets cause errors: move data into a staging table and use a proper Dataset.

10) Quick example — manual dataset using VALUES

```sql
SELECT * FROM (
  SELECT 'A001' AS Code, 'Product A' AS Name, 12.5 AS Price
  UNION ALL SELECT 'A002','Product B', 9.99
  UNION ALL SELECT 'A003','Product C', 15.00
) AS Data;
```

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>