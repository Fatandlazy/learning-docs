# SSRS Report Builder Part 2 - Creating Your First Report

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>

Objective: Step-by-step guide to build a simple report in Report Builder — from creating a Data Source and Dataset, to dragging a table onto the report, adding a simple parameter, previewing, and saving/publishing.

1) Create a new report
- Open Report Builder → `File` → `New` → `Blank Report`.

2) Create a Data Source (connect to the database)
- Open the `Data` pane → `Add Data Source` → give it a name (for example `DS_Contoso`) → choose `Use a connection embedded in my report` (or `Use a shared data source` if available) → set `Type = Microsoft SQL Server`.
- Example connection string (Integrated Security):

```
Data Source=YOUR_SQL_SERVER;Initial Catalog=YOUR_DATABASE;Integrated Security=True;
```

- Example connection string (SQL Authentication):

```
Data Source=YOUR_SQL_SERVER;Initial Catalog=YOUR_DATABASE;User ID=your_user;Password=your_password;
```

3) Create a Dataset
- In the `Data` pane → `Add Dataset` → give it a name (for example `DS_TopProducts`) → choose `Use a dataset embedded in my report` → select the Data Source you created.
- Set `Query type = Text` and paste a sample SQL query to test:

```
SELECT TOP 20 ProductID, ProductName, QuantityPerUnit, UnitPrice
FROM dbo.Products
ORDER BY UnitPrice DESC;
```

4) Drag a Table onto the canvas
- From `Insert` → choose `Table` → add 4 columns to the report.
- Drag fields from the Dataset (`DS_TopProducts`) into the table cells (ProductID, ProductName, QuantityPerUnit, UnitPrice).

5) Add a simple parameter (example: limit rows returned)
- Create a parameter: `Report` → `Report Parameters` → `Add` → name it `@TopN` → Data type `Integer` → Default value `10`.
- Modify the Dataset query to use the parameter:

```
SELECT TOP (@TopN) ProductID, ProductName, QuantityPerUnit, UnitPrice
FROM dbo.Products
ORDER BY UnitPrice DESC;
```

- In the Dataset properties → Parameters, map `@TopN` to `=Parameters!TopN.Value`.

6) Preview the report
- Click `Run` (Preview) to check data and layout. Change the parameter value to test different results.

7) Quick formatting
- Format the `UnitPrice` column as currency: right-click the cell → `Text Box Properties` → `Number` → `Currency`.
- Add a header/footer: `Insert` → `Header` or `Footer` and add a title or print date.

8) Save or publish to the Report Server
- `File` → `Save As` → choose `Save to Report Server` → enter the server URL and target folder (requires an account with Deploy/Manage permissions).

9) Tips & quick troubleshooting
- If a query fails when using `TOP(@TopN)`: some SQL Server contexts require CAST or alternative approaches — ensure the parameter is an integer or use `ROW_NUMBER()` in a CTE as a robust alternative.
- If you don't see the Data pane: `View` → `Report Data`.
- If you cannot save to the server: check your publish permissions/roles on SSRS.

10) Suggestions for extension
- Add grouping in the table to aggregate by category.
- Add interactive sorting on column headers.
- Use shared datasets if queries will be reused across multiple reports.

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>
