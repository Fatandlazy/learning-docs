# SSRS Report Builder — Part 4.4: Importing Datasets from SQL Files

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>

Objective: How to use existing SQL statements from `.sql` files to create a Dataset in Report Builder. Notes cover formatting, unsupported statements (for example `GO`), temp tables/session state, parameters, encoding, and recommended alternatives for very large or complex scripts.

1) Ways to import SQL from a file into a Dataset
- Copy & paste: open the `.sql` file in an editor (Notepad, SSMS, VS Code), copy the SQL text, then in Report Builder choose `Data` → `Add Dataset` → select a Data Source → paste the SQL into the Query box (Query Designer → Text).
- Open file directly: Report Builder does not always provide an "Open .sql" option — copying and pasting is the most reliable approach.
- Use SSDT / Visual Studio: store SQL in your project and copy into the Dataset, or create a Shared Dataset on the Report Server that contains the query.

2) Statements that are not supported in a Dataset
- `GO` is a batch separator used by client tools (e.g., SSMS) but is not a T‑SQL statement. Remove `GO` or split the script into separate batches before pasting into Report Builder.
- DDL statements (CREATE/ALTER TABLE, etc.) should not be executed in a Dataset. A Dataset should return a resultset (SELECT) or call a stored procedure.

3) Temp tables and multi-batch logic
- Queries that rely on `#temp` tables or multiple batches are better implemented as a Stored Procedure. Move the multi-step logic to the database and call the procedure from the Dataset.
- Report Builder / SSRS does not support submitting multiple `GO` batches or maintaining session-scoped state across batches in a single dataset call.

4) SET options, variables and non-SELECT statements
- Avoid `SET` statements and other non-resultset statements inside the dataset query. If required, wrap them in a Stored Procedure so the Dataset receives a single resultset.

5) Parameters in SQL files
- Named parameters (for example `@StartDate`, `@EndDate`) in your SQL will be detected by Report Builder as dataset parameters. After pasting the query, use `Dataset Properties` → `Parameters` to map dataset parameters to Report Parameters or create new report parameters.

6) Encoding and special characters
- Ensure the `.sql` file uses an appropriate text encoding (UTF-8 or ANSI). Copying from files with a BOM or from different encodings can introduce invisible/stray characters. If you see odd characters, open the file in VS Code or Notepad++ and convert to UTF-8 (no BOM), then copy again.

7) Very large SQL files / complex queries
- For very large or complex scripts consider these options:
  - Move the logic into a Stored Procedure or view on the database and call that from the Dataset.
  - Create a Shared Dataset on the Report Server for reuse across reports.

8) Quick checklist
- Remove `GO` batch separators before pasting.
- Do not include DDL statements in dataset queries.
- Prefer Stored Procedures for multi-step or session-dependent logic.
- Map named SQL parameters to Report Parameters after pasting.
- Convert file encoding to UTF-8 (no BOM) if you encounter strange characters.

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>