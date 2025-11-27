# SSRS Report Builder Part 4.6 - Datasets sử dụng Stored Procedures

Back to playlist

Mục tiêu: Hướng dẫn cách dùng Stored Procedures (SP) làm nguồn dữ liệu cho Dataset trong Report Builder / SSRS — lợi ích, cách cấu hình parameter, credential & security, và những giới hạn cần lưu ý.

1) Tại sao dùng Stored Procedure?
- Stored Procedures phù hợp cho logic truy vấn phức tạp, nhiều bước xử lý và khi cần parameter hoá phức tạp.
- Chuyển logic nặng sang DB giúp giảm thiểu lượng xử lý ở phía báo cáo và có thể cải thiện hiệu năng khi SP được tối ưu hóa.

2) Cách tạo Dataset gọi Stored Procedure trong Report Builder
- `Data` → `Add Dataset` → đặt tên dataset → `Query type` chọn `Stored Procedure` (hoặc trong một số phiên bản chọn `Text` và nhập `EXEC dbo.MyStoredProcedure @Param1 = @Param1`).
- Chọn Data Source (embedded hoặc shared) — Data Source cần có quyền execute trên SP.

3) Mapping Parameters
- Khi dataset dùng SP và SP có parameters, Report Builder sẽ tạo corresponding dataset parameters. Bạn cần:
  - Tạo `Report Parameters` tương ứng (ví dụ `StartDate`, `EndDate`).
  - Trong `Dataset Properties` → `Parameters`, ánh xạ mỗi parameter của SP tới `=Parameters!ParameterName.Value`.
- Lưu ý với parameter output vs input: SSRS hỗ trợ input parameters cho SP; output parameters không trực tiếp biến thành dataset columns — để trả dữ liệu, SP phải SELECT resultset.

4) Trả nhiều resultsets
- SSRS chỉ sử dụng resultset đầu tiên trả về từ Stored Procedure cho Dataset. Nếu SP trả nhiều resultset, chỉ resultset đầu tiên sẽ được dùng — tránh trả nhiều resultset nếu report cần chỉ 1 bảng dữ liệu.

5) Temp tables & session-scoped logic
- Nếu SP dùng temp tables (`#temp`) trong scope của SP, hoạt động bình thường vì SP và dataset chạy trong cùng session. Tuy nhiên, nếu SP yêu cầu `GO` hoặc multi-batch logic chia session, nên sửa SP để chạy trong một batch.

6) Thời gian chờ và performance
- Nếu SP chạy lâu, bạn có thể cần tăng timeout trên Data Source hoặc tối ưu SP (thêm chỉ mục, rewrite query, dùng pre-aggregated tables).

7) Quyền (Security)
- Người chạy report phải có quyền `Execute` trên Stored Procedure hoặc Data Source phải dùng Stored Credentials có quyền thực thi SP (nếu dùng stored credentials trên shared data source).
- Best practice: dùng least-privilege account cho Stored Credentials — chỉ quyền cần thiết (SELECT, EXECUTE) trên DB.

8) Đăng nhập / Stored Credentials vs Integrated Security
- Nếu dùng `Integrated Security`, SP sẽ chạy under the user's Windows account — cần đảm bảo account có quyền DB.
- Nếu dùng `Stored Credentials` trên shared data source, SP sẽ chạy under that stored account — phù hợp cho scheduled reports.

9) Troubleshooting phổ biến
- SP không trả dữ liệu: chạy SP trong SSMS với cùng parameters để kiểm tra.
- Lỗi permission EXECUTE: kiểm tra quyền của account (user hoặc stored credentials) và grant EXECUTE trên SP.
- Parameter type mismatch: đảm bảo Report Parameter type (Date, Integer) phù hợp kiểu parameter của SP.
- Timeouts: kiểm tra execution plan và tối ưu SP.

10) Ví dụ

Stored Procedure:

```
CREATE PROCEDURE dbo.GetSales
  @StartDate DATE,
  @EndDate DATE,
  @TopN INT = 10
AS
BEGIN
  SET NOCOUNT ON;
  SELECT TOP (@TopN) CustomerID, SUM(Total) AS SalesTotal
  FROM dbo.Orders
  WHERE OrderDate BETWEEN @StartDate AND @EndDate
  GROUP BY CustomerID
  ORDER BY SalesTotal DESC;
END
```

Trong Report Builder: tạo Dataset, chọn Stored Procedure `dbo.GetSales` → tạo Report Parameters `StartDate`, `EndDate`, `TopN` → ánh xạ parameter.

11) Best practices
- Trả một resultset duy nhất cho báo cáo.
- Sử dụng Stored Procedures cho logic nặng/complex và để tận dụng khả năng tối ưu của DB.
- Đặt parameter default values hợp lý để tránh trả quá nhiều dữ liệu khi người dùng bỏ trống parameter.

Muốn tôi tiếp tục với file `11-ssrs-report-builder-part-47-entering-and-copying-data-into-a-report.md` hay thêm screenshot placeholders cho file 10? Chọn 1 và tôi tiếp tục.

Back to playlist
