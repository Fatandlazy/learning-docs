# SSRS Report Builder Part 4.5 - Datasets sử dụng Views

Back to playlist

Mục tiêu: Giải thích khi nào nên dùng SQL Views làm nguồn dữ liệu cho Dataset trong SSRS/Report Builder, ưu/nhược điểm so với Stored Procedures và trực tiếp dùng SELECT, cùng các lưu ý về performance, parameters và bảo trì.

1) Tại sao dùng Views?
- Views giúp đóng gói logic SELECT phức tạp thành một đối tượng DB có thể tái sử dụng.
- Giúp giữ báo cáo gọn nhẹ — báo cáo tham chiếu `SELECT * FROM dbo.vSalesSummary` thay vì chứa query phức tạp.

2) Lợi ích
- Tái sử dụng: nhiều báo cáo có thể dùng chung một view.
- Bảo trì: sửa logic ở một nơi (view) sẽ ảnh hưởng cho tất cả báo cáo dùng view đó.
- Quyền: bạn có thể cấp quyền SELECT lên view mà không cần cấp quyền trực tiếp lên underlying tables.

3) Hạn chế và lưu ý performance
- Views không tự động tối ưu nếu chúng chứa nhiều join/phức tạp — optimizer vẫn xử lý query trên underlying tables.
- View dạng `SELECT *` trên một query rất phức tạp có thể gây chậm; cân nhắc tạo indexed view (nếu khả thi) hoặc tối ưu hóa view logic.
- Nếu view dùng functions, scalar subqueries hoặc CROSS APPLY phức tạp, có thể ảnh hưởng performance.

4) Views vs Stored Procedures
- Views trả về resultset dùng trong Dataset; không thể truyền tham số trực tiếp vào view (trừ khi dùng inline table-valued functions).
- Stored Procedures hỗ trợ parameter và logic xử lý phức tạp; nếu bạn cần parameterized logic, ưu tiên Stored Procedure hoặc Table-Valued Function (TVF).

5) Cách sử dụng Views trong Report Builder
- Tạo Dataset với query đơn giản: `SELECT * FROM dbo.vSalesSummary`.
- Hoặc tạo Shared Dataset trên Report Server dựa trên view và tham chiếu từ các báo cáo.

6) Parameterising view logic
- Vì view không nhận parameters, nếu bạn cần filter động theo parameter, có 3 option chính:
  - Filter trong report: lấy full resultset từ view rồi dùng report-level filter (không hiệu quả nếu view trả nhiều rows).
  - Sử dụng Table-Valued Function (inline TVF): TVF cho phép truyền parameter giống như view nhưng với parameterisation.
  - Dùng Stored Procedure: đặt logic parameter trong SP và gọi từ Dataset.

7) Best practices
- Nếu logic có thể được parameterize, dùng TVF hoặc Stored Procedure thay vì cố gắng filter lớn trên client.
- Dùng Shared Dataset dựa trên view nếu nhiều báo cáo cần cùng resultset tĩnh hoặc ít biến động.
- Giữ view đơn giản, tránh SELECT * khi không cần tất cả cột.

8) Ví dụ

View `vSalesSummary`:

```
CREATE VIEW dbo.vSalesSummary AS
SELECT s.CustomerID, c.CompanyName, YEAR(s.OrderDate) AS [Year], MONTH(s.OrderDate) AS [Month], SUM(s.Total) AS SalesTotal
FROM dbo.Orders s
JOIN dbo.Customers c ON s.CustomerID = c.CustomerID
GROUP BY s.CustomerID, c.CompanyName, YEAR(s.OrderDate), MONTH(s.OrderDate);
```

Dataset trong Report Builder:

```
SELECT CustomerID, CompanyName, [Year], [Month], SalesTotal
FROM dbo.vSalesSummary
WHERE [Year] = @Year; -- dùng report parameter @Year
```

Lưu ý: vì view không accept parameters, filter `WHERE [Year] = @Year` sẽ được áp dụng ở Dataset level; SQL Server sẽ tối ưu hóa biểu thức này khi có chỉ mục phù hợp trên underlying tables.

9) Troubleshooting
- Dữ liệu từ view chậm: kiểm tra execution plan, chỉ mục trên underlying tables, và xem có thể chuyển một phần logic sang indexed view hoặc pre-aggregated table.
- Thay đổi cấu trúc underlying tables: cập nhật view và kiểm tra các báo cáo tham chiếu để đảm bảo không phá vỡ tên cột.

10) Kết luận
- Views rất phù hợp để đóng gói logic SELECT tái sử dụng và cho phép quản trị quyền dễ dàng.
- Khi cần parameterized queries hoặc logic phức tạp, cân nhắc TVF hoặc Stored Procedure để tối ưu performance và khả năng mở rộng.

Bạn muốn tôi tiếp tục với file `10-ssrs-report-builder-part-46-datasets-using-stored-procedures.md` hay thêm screenshot placeholders cho file 09? Chọn 1 và tôi tiếp tục.

Back to playlist
