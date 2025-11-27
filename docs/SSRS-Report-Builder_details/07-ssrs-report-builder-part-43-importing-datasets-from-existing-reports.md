# SSRS Report Builder Part 4.3 - Importing / Reusing Datasets from Existing Reports

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>

Objective: Guidance on reusing datasets from existing reports — common approaches (shared datasets, copy/paste datasets, creating Report Parts), when to use each, and considerations for parameters and credentials.

1) Tổng quan: các phương pháp chính
- Shared Dataset: phương pháp khuyến nghị trong môi trường production — tạo dataset trên Report Server và tham chiếu nó từ các báo cáo khác.
- Copy/Paste dataset giữa hai RDL: nhanh, tiện khi bạn không có quyền tạo shared resources hoặc làm thử nghiệm.
- Report Parts: tạo thành phần tái sử dụng (bao gồm layout và dataset) và xuất bản lên Report Server để người khác kéo vào báo cáo.

2) Sử dụng Shared Dataset (khuyến nghị)
- Nếu dataset đã có trên Report Server:
  - Mở Report Builder → `Data` → `Add Dataset` → chọn `Use a shared dataset` → chọn dataset từ server.
  - Shared dataset sẽ giữ query, parameter definition và dễ bảo trì từ 1 nơi.

3) Copy / Paste dataset giữa hai báo cáo (Report Builder / SSDT)
- Mở báo cáo nguồn (Report A) trong Report Builder (hoặc SSDT) và báo cáo đích (Report B) trong một cửa sổ/cài đặt khác.
- Trong `Report Data` pane của Report A, chuột phải vào dataset → chọn `Copy`.
- Chuyển sang Report B → `Report Data` pane → chuột phải → `Paste`.
- Lưu ý:
  - Nếu dataset phụ thuộc vào shared data source, dataset khi dán có thể giữ tham chiếu đó; bạn nên kiểm tra `Data Source` trong Dataset Properties.
  - Nếu dataset có parameters, bạn cần tạo corresponding report parameters trong Report B hoặc ánh xạ tham số dataset tới parameters của báo cáo.

4) Tạo và xuất bản Report Part
- Report Part cho phép đóng gói dataset + layout (table, chart) để tái sử dụng.
- Trong Report Builder, thiết kế phần muốn tái sử dụng → `File` → `Save As` → `Save as Report Part` → lưu lên Report Server.
- Người khác có thể dùng `Insert` → `Report Part` để kéo phần này vào báo cáo mới.

5) Parameter dependencies — lưu ý quan trọng
- Khi tái sử dụng dataset từ báo cáo khác, dataset có thể định nghĩa các parameters bắt buộc. Bạn phải đảm bảo báo cáo đích cung cấp các report parameters tương ứng hoặc đặt giá trị mặc định cho các parameter dataset.
- Nếu copy/paste dataset và dataset query dùng named parameters (ví dụ `@StartDate`), tạo report parameters có cùng tên hoặc ánh xạ đúng trong Dataset Properties → Parameters.

6) Credentials & Data Source mapping
- Nếu dataset tham chiếu shared data source, đảm bảo báo cáo đích có quyền truy cập vào shared data source đó, hoặc khi dán dataset hãy kiểm tra Data Source và chỉnh cho phù hợp (embedded or shared reference).

7) Troubleshooting phổ biến
- Dataset dán vào báo cáo không trả dữ liệu: kiểm tra connection string, credentials, và parameter mapping.
- Không thể paste dataset: một số phiên bản hoặc cài đặt bảo mật có thể chặn copy/paste giữa cửa sổ; trong trường hợp này, mở cả hai báo cáo trong SSDT/Report Builder trên cùng máy và thử lại, hoặc dùng shared dataset.
- Report Part không hiển thị trong portal: kiểm tra quyền và thư mục nơi bạn lưu Report Part.

8) Ví dụ nhanh — copy dataset và map parameter

1. Trong Report A dataset `SalesByCustomer` có parameter `@StartDate` và `@EndDate`.
2. Copy dataset từ Report A và Paste vào Report B.
3. Trong Report B tạo 2 report parameters `StartDate` và `EndDate`.
4. Mở Dataset Properties → Parameters và ánh xạ `@StartDate` -> `=Parameters!StartDate.Value`, `@EndDate` -> `=Parameters!EndDate.Value`.

9) Best practices
- Ưu tiên sử dụng Shared Datasets trên server cho báo cáo production.
- Nếu phải copy datasets, đồng bộ tên parameter và documented mapping để tránh nhầm lẫn.
- Tạo Report Parts cho các pattern báo cáo lặp lại (table + dataset) để người dùng nghiệp vụ dễ tái sử dụng.

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>