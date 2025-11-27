# SSRS Report Builder Part 4.1 - Embedded Data Sources and Datasets

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>

Objective: Explain the difference between Embedded and Shared Data Sources / Datasets, when to use each type, how to create them in Report Builder, and considerations about credentials, performance, and security.

1) Basic concepts
- Embedded Data Source / Dataset: stored directly inside the report's RDL file. Pros: report-specific configuration, fast for quick tests. Cons: harder to maintain when many reports use the same connection/queries (you must update each file individually).
- Shared Data Source / Dataset: stored on the Report Server and referenced by multiple reports. Pros: central management and easier updates that affect all referencing reports. Cons: requires appropriate server permissions to create/share resources.

2) When to use Embedded vs Shared
- Use Embedded when:
    - The report is standalone, for quick testing, or you do not have permissions to create shared resources on the server.
    - You require a report-specific connection string or credentials that should be isolated from shared resources.
- Use Shared when:
    - Multiple reports use the same data source or datasets.
    - You want centralized management of connections and credentials (e.g., changing the DB server only requires updating the shared data source).

3) Create an Embedded Data Source in Report Builder
- `Data` → `Add Data Source` → give it a name → choose `Use a connection embedded in my report` → `Type = Microsoft SQL Server` → enter the connection string.
- Credentials: choose one of the options:
    - `Windows integrated security` (Integrated Security=True): uses the Windows account of the user running the report.
    - `Stored credentials` (username/password): Report Server stores the credentials and uses them for unattended execution (commonly used for scheduled reports).
    - `Prompt` (ask each user): users are prompted for credentials when running the report (rare for production).

4) Create an Embedded Dataset
- `Data` → `Add Dataset` → select the embedded Data Source you created → set Query type to Text or Stored Procedure → paste the SQL or choose the procedure and add parameter mappings as required.

5) Create and use Shared Data Sources / Datasets (summary)
- In Report Builder: if the server already contains Shared Data Sources, you can choose `Use a shared data source reference` when adding a Data Source and select the server resource.
- To create shared resources you typically use the Report Server web portal or SSDT/Report Manager and you need rights to upload/create resources on the server.

6) Credentials and security
- Avoid storing usernames/passwords directly inside RDL files (embedded) when possible — prefer Shared Data Sources with Stored Credentials configured on the server for safer credential management.
- If using Integrated Security, verify the execution context (service account or the user account) used by the server for unattended runs.

7) Performance & caching
- Shared Datasets can be configured with caching or snapshots on the Report Server to speed up repeated queries.
- Embedded datasets do not benefit from centralized caching unless the report is configured with server-side snapshots. If many reports run heavy queries, consider shared datasets or materialized views on the database.

8) Common troubleshooting
- Connection errors: check the connection string, firewall (port 1433), and the user account's database permissions.
- Credential errors for scheduled runs: ensure Stored Credentials are configured for a DB account with access.
- Changing the connection server: embedded sources require updating each report, while shared sources only require updating the shared resource on the server.

9) Short example (embedded dataset with parameters)

```
-- Example query for an embedded dataset
SELECT OrderID, OrderDate, CustomerID, Total
FROM dbo.Orders
WHERE OrderDate BETWEEN @StartDate AND @EndDate
ORDER BY OrderDate DESC;
```

- Create two report parameters `@StartDate` and `@EndDate` and map them in the Dataset → Parameters.

10) Conclusion & Best Practices
- Use Shared Data Sources/Datasets for production environments and when centralized management is required.
- Use Embedded for fast development, testing, or when you lack permissions on the server.
- Always consider credential storage, caching, and the performance implications when choosing the data source/dataset type.

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>
