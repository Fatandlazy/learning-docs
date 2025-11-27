# SSRS Report Builder Part 4.4 - Importing Datasets từ file SQL

Back to playlist

Mục tiêu: Hướng dẫn cách sử dụng câu lệnh SQL có sẵn từ file `.sql` để tạo Dataset trong Report Builder, lưu ý về định dạng, câu lệnh không hỗ trợ (`GO`), tạm bảng/biến tạm, tham số và cách xử lý khi file lớn.

1) Các cách import SQL từ file vào Dataset
- Copy/paste: Mở file `.sql` trong editor (Notepad/SSMS/VS Code) → copy toàn bộ câu lệnh → trong Report Builder `Data` → `Add Dataset` → chọn Data Source → dán SQL vào ô Query (Query Designer → Text).
- Open file trực tiếp: Report Builder không luôn cung cấp nút "Open .sql" — copy/paste là cách an toàn và phổ biến.
- Dùng SSDT/Visual Studio: nếu bạn dùng SSDT, bạn có thể lưu SQL trong project rồi copy vào Dataset hoặc tạo Shared Dataset trên server chứa query.

2) Lưu ý về câu lệnh không được hỗ trợ trực tiếp
- `GO` là batch separator cho công cụ client (SSMS) nhưng không phải T-SQL; nếu file `.sql` có `GO`, xóa hoặc tách thành các batch trước khi dán vào Report Builder.
- Câu lệnh tạo / thay đổi cấu trúc (CREATE TABLE, ALTER TABLE) không phù hợp để chạy trong Dataset — Dataset nên chứa chỉ SELECT (hoặc gọi stored procedure).

3) Temp tables và multi-batch logic
- Nếu query dùng `#temp` hoặc logic nhiều batch, tốt nhất là chuyển logic đó thành Stored Procedure trên DB và gọi Stored Procedure từ Dataset.
- Report Builder / SSRS không hỗ trợ gửi nhiều batch có `GO` hoặc logic phụ thuộc vào session state trong một dataset đơn.

4) Handling variables, SET options và non-select statements
- Tránh các `SET` tùy chọn trong query; nếu cần, đặt chúng trong stored procedure hoặc đảm bảo query vẫn trả một resultset hợp lệ.

5) Parameters trong file SQL
- Nếu file SQL dùng placeholders như `@StartDate`, `@EndDate`, Report Builder sẽ tự nhận parameter khi query có named parameters.
- Sau dán query, vào `Dataset Properties` → `Parameters` để ánh xạ parameter dataset với `Report Parameters` hoặc tạo report parameter mới.

6) Encoding và special characters
- Đảm bảo file `.sql` dùng encoding UTF-8 hoặc ANSI phù hợp; copy/paste từ file có BOM có thể gây ký tự lạ. Nếu gặp lỗi, mở file trong Notepad++/VS Code và chuyển encoding sang UTF-8 (no BOM), rồi copy lại.

7) File SQL lớn / query phức tạp
- Nếu file SQL rất lớn, cân nhắc:
  - Tạo stored procedure hoặc view trên DB và gọi từ Dataset.
  - Tạo Shared Dataset trên server để tái sử dụng.

8) Ví dụ thực tế

```markdown
# SSRS Report Builder Part 4.4 - Importing Datasets from SQL Files

Back to playlist

Objective: Guidance on using existing SQL statements from `.sql` files to create a Dataset in Report Builder — notes on formatting, unsupported statements (`GO`), temp tables/session state, parameters, and handling very large files.

1) Ways to import SQL from a file into a Dataset
- Copy/paste: Open the `.sql` file in an editor (Notepad/SSMS/VS Code) → copy the SQL → in Report Builder go to `Data` → `Add Dataset` → choose Data Source → paste the SQL into the Query box (Query Designer → Text).
- Open file directly: Report Builder does not always provide an "Open .sql" button — copy/paste is the safest and most common approach.
- Use SSDT/Visual Studio: If you use SSDT you can keep SQL in the project and then copy it into a Dataset or create a Shared Dataset on the server that contains the query.

2) Notes on statements not directly supported
- `GO` is a batch separator for client tools (SSMS) but not a T-SQL statement; if the `.sql` file contains `GO`, remove it or split the file into batches before pasting into Report Builder.
- DDL statements (CREATE TABLE, ALTER TABLE) are not appropriate to run in a Dataset — a Dataset should contain a SELECT (or call a stored procedure).

3) Temp tables and multi-batch logic
- If the query uses `#temp` tables or multi-batch logic, the best approach is to move that logic into a Stored Procedure on the database and call that stored procedure from the Dataset.
- Report Builder / SSRS does not support submitting multiple batches with `GO` or queries that depend on session state in a single dataset.

4) Handling SET options, variables and non-SELECT statements
- Avoid `SET` statements inside the query; if needed, put them in a stored procedure or ensure the pasted query still returns a valid resultset.

5) Parameters in SQL files
- If the SQL file uses named parameters such as `@StartDate`, `@EndDate`, Report Builder will detect these as dataset parameters when the query contains named parameters.
- After pasting the query, go to `Dataset Properties` → `Parameters` to map dataset parameters to `Report Parameters` or create new report parameters.

6) Encoding and special characters
- Ensure the `.sql` file uses an appropriate encoding (UTF-8 or ANSI); copying from a file with a BOM can introduce stray characters. If you see odd characters, open the file in Notepad++/VS Code and change the encoding to UTF-8 (no BOM), then copy again.

7) Very large SQL files / complex queries
- If the SQL file is very large, consider:
  - Moving the logic into a stored procedure or view on the database and calling that from the Dataset.
  - Creating a Shared Dataset on the Report Server for reuse.

8) Practical example

File `top_customers.sql`:

```
-- top_customers.sql
SELECT TOP (@TopN) CustomerID, CompanyName, SUM(Total) AS TotalSales
FROM dbo.Orders
WHERE OrderDate BETWEEN @StartDate AND @EndDate
GROUP BY CustomerID, CompanyName
ORDER BY TotalSales DESC;
```

Steps:
- Copy/paste the query into the Dataset.
- Create Report Parameters `TopN`, `StartDate`, `EndDate`.
- In Dataset Properties -> Parameters, map `@TopN` -> `=Parameters!TopN.Value`, etc.

9) Common troubleshooting
- Syntax errors after pasting: check and remove `GO`, non-standard comments, or BOM characters.
- Query returns no data with parameters: verify parameter types (Date, Integer) and the mappings.
- Timeout errors: if the query is heavy, increase the timeout on the Data Source or move the logic to a stored procedure and optimize indexes.

10) Best practices
- If the query is complex or requires multiple processing steps, move the logic into a Stored Procedure or View.
- Store shared queries as Shared Datasets on the Report Server for easier management.
- Keep SQL files in source control and document parameter mappings for maintainability.

Would you like me to continue with `09-ssrs-report-builder-part-45-datasets-using-views.md` or add screenshot placeholders to file `08`? Choose one and I'll proceed.

Back to playlist
```