# SSRS Report Builder Part 4.7 - Nhập và Copy Data vào báo cáo

Back to playlist

Mục tiêu: Hướng dẫn cách nhập dữ liệu thủ công, copy/paste từ Excel hoặc text, chèn dữ liệu tạm (embedded data) vào báo cáo, và mẹo định dạng/kiểm tra dữ liệu trước khi publish.

1) Khi nào nên nhập dữ liệu trực tiếp vào báo cáo?
- Cho các báo cáo demo, mẫu, hoặc khi dữ liệu nhỏ và không cần cập nhật tự động.
- Khi cần thêm các giá trị tham chiếu nhanh (ví dụ danh sách mapping, tiêu đề động) mà không muốn tạo nguồn dữ liệu riêng.

2) Nhập dữ liệu bằng cách dùng embedded dataset (Manual entry)
- Trong Report Builder: `Data` → `Add Dataset` → chọn `Use a dataset embedded in my report` → `Type = Text`.
- Thay vì viết SQL, chọn `Embedded Data` hoặc `Enter data manually` (tuỳ phiên bản). Nếu không có UI nhập trực tiếp, bạn có thể tạo dataset dạng XML hoặc dùng `VALUES` trong SQL (ví dụ cho SQL Server):

```
SELECT * FROM (
  SELECT 1 AS ID, 'Alpha' AS Name
  UNION ALL SELECT 2, 'Beta'
  UNION ALL SELECT 3, 'Gamma'
) AS T
```

3) Copy/paste từ Excel hoặc CSV
- Copy/paste trực tiếp vào table trong Report Builder:
  - Thông thường bạn copy dữ liệu từ Excel, trong Report Builder tạo một Table rồi trong design view chọn cell đầu tiên và paste. Một số phiên bản hỗ trợ paste từng cell vào table.
  - Nếu paste không hoạt động, dùng phương pháp intermediate: copy từ Excel → dán vào Notepad → lưu thành `.csv` → import/convert hoặc paste vào query dạng `VALUES` hoặc chuyển sang dataset bằng cách tạo temporary table trên DB và load CSV vào đó.

4) Import từ Excel bằng cách tạo Shared/Embedded Dataset
- Tốt nhất là load file Excel vào database (staging table) rồi tạo Data Source/ Dataset trỏ tới bảng đó. Quy trình:
  - Dùng SSIS hoặc công cụ import để tải Excel vào staging table trên SQL Server.
  - Tạo Shared Data Source/ Dataset trỏ tới table staging.
  - Publish dataset/report.

5) Định dạng dữ liệu và kiểu dữ liệu
- Khi nhập tay hoặc paste, kiểm tra kiểu dữ liệu (Text/Date/Number). Nếu field là ngày, đảm bảo format phù hợp và Report Parameter dùng kiểu Date.
- Nếu dùng `VALUES` trong SQL để mô phỏng dữ liệu, CAST các cột về kiểu dữ liệu chính xác để tránh lỗi khi publish.

6) Mẹo xử lý ký tự đặc biệt và encoding
- Khi paste từ Excel chứa ký tự Unicode, đảm bảo file/clipboard giữ định dạng UTF-8; nếu gặp ký tự lạ, chuyển dữ liệu qua Notepad++ và chuyển encoding.

7) Sử dụng Report Parts hoặc Shared Dataset cho mẫu dữ liệu
- Nếu bạn thường xuyên dùng cùng bảng mẫu (ví dụ mapping table), tạo Shared Dataset hoặc Report Part để tái sử dụng thay vì nhập lại thủ công.

8) Kiểm tra & preview
- Sau nhập dữ liệu, luôn `Run` (Preview) để kiểm tra layout, định dạng số/ngày, và xem liệu data mapping/aggregate có đúng.

9) Troubleshooting phổ biến
- Paste không dính/không đúng cột: kiểm tra selection cell trước khi paste hoặc paste vào Notepad và dán lại theo bước `VALUES`.
- Dữ liệu ngày/number không đúng: kiểm tra locale/format của máy và kiểu Report Parameter.
- Dữ liệu lớn nhập thủ công gây lỗi: chuyển sang staging table trên DB.

10) Ví dụ nhanh — tạo dataset thủ công bằng VALUES

```
SELECT * FROM (
  SELECT 'A001' AS Code, 'Product A' AS Name, 12.5 AS Price
  UNION ALL SELECT 'A002','Product B', 9.99
  UNION ALL SELECT 'A003','Product C', 15.00
) AS Data;
```

Muốn tôi tiếp tục với file `12-ssrs-report-builder-part-51-basic-tables.md` hay chèn screenshot placeholders cho file 11? Chọn 1 và tôi tiếp tục.

Back to playlist