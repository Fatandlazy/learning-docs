# SSRS Report Builder Part 4.2 - Shared Data Sources và Shared Datasets (Trên Report Server)

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>

Mục tiêu: Hướng dẫn bước-by-bước để tạo và quản lý Shared Data Source và Shared Dataset trên Report Server, cách tham chiếu chúng từ Report Builder, cấu hình credentials, cache/snapshots và quyền truy cập.

1) Tổng quan
- Shared Data Source: resource lưu trên Report Server (portal) chứa connection string và tùy chọn credential. Nhiều báo cáo có thể tham chiếu nó bằng reference.
- Shared Dataset: resource chứa query hoặc stored procedure được lưu trên server; báo cáo có thể tham chiếu shared dataset để tái sử dụng logic truy vấn.

2) Quyền cần thiết
- Để tạo shared resources, bạn cần có quyền `Publisher` hoặc `Content Manager` trên thư mục destination trong Report Server portal.

3) Tạo Shared Data Source trên Report Server (bước-by-bước)
- Mở Report Server web portal: `http://<report-server>/reports`.
- Chọn thư mục nơi bạn muốn lưu Shared Data Source → `New` → `Data Source`.
- Điền thông tin:
	- **Name**: ví dụ `DS_Sales_DB`.
	- **Connection Type**: `Microsoft SQL Server`.
	- **Connection String**: `Data Source=YOUR_SQL_SERVER;Initial Catalog=YOUR_DATABASE;`
	- **Credentials stored securely in the report server**: nhập `User name` và `Password` nếu muốn server dùng credential này để truy vấn (thích hợp cho scheduled reports/unattended execution).
	- Hoặc chọn `Windows integrated security` nếu server và DB dùng integrated authentication phù hợp.
- Nhấn `Test Connection` (nếu có) và `Create`.

4) Tạo Shared Dataset trên Report Server (bước-by-bước)
- Trong thư mục đích → `New` → `Dataset`.
- Chọn `Use a shared dataset` và điền:
	- **Name**: ví dụ `DSD_SalesByMonth`.
	- **Data source**: chọn `DS_Sales_DB` (shared data source bạn vừa tạo).
	- **Query**: dán SQL hoặc chọn stored procedure, thêm parameters nếu cần.
	- **Description**: mô tả ngắn để người dùng hiểu mục đích dataset.
- Lưu dataset. Bạn có thể kiểm tra kết quả bằng chức năng preview (nếu portal hỗ trợ) hoặc dùng Report Builder để tham chiếu dataset.

5) Cấu hình cache và snapshots cho shared dataset
- Trên dataset hoặc data source trong portal, bạn có thể cấu hình caching hoặc snapshots (tùy thuộc vào phiên bản SSRS):
	- Cache: giữ kết quả query tạm thời để giảm tải DB cho truy vấn lặp.
	- Snapshot: tạo snapshot định kỳ cho báo cáo/dataset để có dữ liệu nhất quán cho lịch chạy.

6) Sử dụng Shared Data Source / Dataset trong Report Builder
- Mở Report Builder → `Data` → `Add Data Source` → chọn `Use a shared data source reference` → chọn resource từ server (bạn cần kết nối tới server và có quyền xem resource).
- Với Shared Dataset: `Data` → `Add Dataset` → chọn `Use a shared dataset` → chọn dataset trên server.

```markdown
# SSRS Report Builder Part 4.2 - Shared Data Sources and Shared Datasets (On Report Server)

Back to playlist

Objective: Step-by-step guidance for creating and managing Shared Data Sources and Shared Datasets on the Report Server, how to reference them from Report Builder, configuring credentials, cache/snapshots and access permissions.

1) Overview
- Shared Data Source: a resource stored on the Report Server (portal) that contains the connection string and credential options. Multiple reports can reference it by reference.
- Shared Dataset: a resource stored on the server that contains a query or stored procedure; reports can reference a shared dataset to reuse query logic.

2) Required permissions
- To create shared resources you need `Publisher` or `Content Manager` permissions on the destination folder in the Report Server portal.

3) Create a Shared Data Source on the Report Server (step-by-step)
- Open the Report Server web portal: `http://<report-server>/reports`.
- Choose the folder where you want to save the Shared Data Source → `New` → `Data Source`.
- Fill in the information:
    - **Name**: e.g. `DS_Sales_DB`.
    - **Connection Type**: `Microsoft SQL Server`.
    - **Connection String**: `Data Source=YOUR_SQL_SERVER;Initial Catalog=YOUR_DATABASE;`
    - **Credentials stored securely in the report server**: enter `User name` and `Password` if you want the server to use these credentials to query the database (appropriate for scheduled reports/unattended execution).
    - Or choose `Windows integrated security` if the server and DB use integrated authentication.
- Click `Test Connection` (if available) and then `Create`.

4) Create a Shared Dataset on the Report Server (step-by-step)
- In the destination folder → `New` → `Dataset`.
- Choose `Use a shared dataset` and fill in:
    - **Name**: e.g. `DSD_SalesByMonth`.
    - **Data source**: select `DS_Sales_DB` (the shared data source you just created).
    - **Query**: paste SQL or select a stored procedure, add parameters if needed.
    - **Description**: a short description to help users understand the dataset purpose.
- Save the dataset. You can verify results via preview (if the portal supports it) or by referencing the dataset from Report Builder.

5) Configure caching and snapshots for shared datasets
- On a dataset or data source in the portal, you can configure caching or snapshots (depending on SSRS version):
    - Cache: stores query results temporarily to reduce load on the DB for repeated queries.
    - Snapshot: create periodic snapshots for reports/datasets to provide consistent data for scheduled runs.

6) Using Shared Data Sources / Datasets in Report Builder
- Open Report Builder → `Data` → `Add Data Source` → choose `Use a shared data source reference` → select the resource from the server (you must be connected to the server and have permission to view the resource).
- For Shared Dataset: `Data` → `Add Dataset` → choose `Use a shared dataset` → select the dataset on the server.

7) Benefits & best practices
- Centralized management: changing the connection string in one place applies to all reports that reference it.
- Security: store credentials securely on the server (Stored Credentials) rather than inside individual RDL files.
- Reuse: shared datasets help avoid duplicate queries and are easier to maintain.
- Naming convention: prefix `DS_` for data sources, `DSD_` or `SD_` for shared datasets to make them easy to identify.

8) Permission & security notes
- Permissions: give read/view permission to report viewers; give publish/create permission to development teams.
- Stored Credentials: use an account with the minimum necessary DB privileges.

9) Common troubleshooting
- Cannot see shared resources in Report Builder: check that the user has permission to view the folder/resource; verify the server URL is correct.
- Errors running reports after switching shared data source: check the stored credential permissions or authentication configuration.
- Shared dataset returns no data: open the dataset on the portal and validate the query/parameters; if the query depends on parameters, ensure the dataset has defaults or the report passes parameters correctly.

10) Example Query for a Shared Dataset (Sales by Month)

```
SELECT DATEPART(YEAR, OrderDate) AS [Year], DATEPART(MONTH, OrderDate) AS [Month],
             SUM(Total) AS SalesTotal
FROM dbo.Orders
WHERE OrderDate BETWEEN @StartDate AND @EndDate
GROUP BY DATEPART(YEAR, OrderDate), DATEPART(MONTH, OrderDate)
ORDER BY [Year], [Month];
```

11) Conclusion
- Shared Data Sources and Shared Datasets are key components to manage and optimize an SSRS reporting system in production.
- Use shared resources together with naming conventions, secure stored credentials, and caching to achieve performance and maintainability.

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>