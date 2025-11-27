# SSRS Report Builder — Part 4.2: Shared Data Sources and Shared Datasets (Report Server)

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>

Objective: Step-by-step guidance for creating and managing Shared Data Sources and Shared Datasets on the Report Server. This document covers referencing resources from Report Builder, configuring credentials, caching/snapshots, permissions, and troubleshooting.

1) Overview
- Shared Data Source: a resource stored on the Report Server that contains the connection string and credential options. Multiple reports can reference the same shared data source.
- Shared Dataset: a resource stored on the Report Server that contains a query or stored procedure. Reports can reference a shared dataset to reuse query logic and centralize maintenance.

2) Required permissions
- To create shared resources you need `Publisher` or `Content Manager` permissions on the destination folder in the Report Server portal.

3) Create a Shared Data Source on the Report Server (step-by-step)
- Open the Report Server web portal: `http://<report-server>/reports`.
- Navigate to the folder where you want to save the Shared Data Source → `New` → `Data Source`.
- Fill in the required fields:
    - **Name**: e.g. `DS_Sales_DB`.
    - **Connection Type**: `Microsoft SQL Server`.
    - **Connection String**: `Data Source=YOUR_SQL_SERVER;Initial Catalog=YOUR_DATABASE;`
    - **Credentials stored securely in the report server**: enter the `User name` and `Password` if you want the server to use these credentials for database queries (recommended for scheduled reports/unattended execution).
    - Or choose `Windows integrated security` if your environment supports integrated authentication.
- Click `Test Connection` (if available) and then `Create`.

4) Create a Shared Dataset on the Report Server (step-by-step)
- In the destination folder → `New` → `Dataset`.
- Choose `Use a shared dataset` and provide:
    - **Name**: e.g. `DSD_SalesByMonth`.
    - **Data source**: select `DS_Sales_DB` (the shared data source you created earlier).
    - **Query**: paste the SQL query or select a stored procedure; add parameters if required.
    - **Description**: a short description to help users understand the dataset's purpose.
- Save the dataset. You can preview results in the portal (if supported) or reference the dataset from Report Builder to validate it.

5) Configure caching and snapshots
- On a dataset or data source in the portal you can configure caching and snapshots (availability depends on the SSRS version):
    - Cache: temporarily store query results to reduce database load for repeated queries.
    - Snapshot: create periodic snapshots to provide consistent data for scheduled runs.

6) Use Shared Data Sources and Shared Datasets in Report Builder
- Open Report Builder → `Data` → `Add Data Source` → choose `Use a shared data source reference` → select the resource from the server. You must be connected to the server and have permission to view the resource.
- For a Shared Dataset: `Data` → `Add Dataset` → choose `Use a shared dataset` → select the dataset hosted on the server.

7) Benefits & best practices
- Centralized management: changing a connection string in one place applies to all reports referencing it.
- Security: store credentials on the server (Stored Credentials) rather than embedding them in individual RDL files.
- Reuse: shared datasets reduce duplicated queries and simplify maintenance.
- Naming conventions: use predictable prefixes (e.g. `DS_` for data sources, `DSD_` or `SD_` for shared datasets) to make resources easy to identify.

8) Permissions & security notes
- Assign read/view permission to report consumers and publish/create permission to developers or report authors.
- For stored credentials, use an account with the minimum required database privileges.

9) Common troubleshooting
- Cannot see shared resources in Report Builder: verify the server URL and that the user has permission to view the folder/resource.
- Errors running reports after switching a shared data source: check stored credential permissions and the authentication configuration.
- Shared dataset returns no data: open the dataset on the portal and validate the query and parameters. Ensure defaults exist or that the report passes parameters correctly.

10) Example query for a Shared Dataset (Sales by Month)

```sql
SELECT
    DATEPART(YEAR, OrderDate) AS [Year],
    DATEPART(MONTH, OrderDate) AS [Month],
    SUM(Total) AS SalesTotal
FROM dbo.Orders
WHERE OrderDate BETWEEN @StartDate AND @EndDate
GROUP BY DATEPART(YEAR, OrderDate), DATEPART(MONTH, OrderDate)
ORDER BY [Year], [Month];
```

11) Conclusion
- Shared Data Sources and Shared Datasets are essential for managing and optimizing SSRS reporting in production. Use shared resources alongside clear naming conventions, secure stored credentials, and caching to improve performance and maintainability.

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>