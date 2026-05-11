# Hướng dẫn biên soạn Detail Design

## Nguyên tắc bắt buộc

- Không chèn nguyên văn SQL/XML vào tài liệu
- Không để section trống
- Không tách section riêng cho Dropdown/Navigation/Appendix (đã được hợp nhất)

## Ánh xạ nội dung trong cấu trúc DD

| Nội dung cần trình bày | Vị trí trong tài liệu | Ý nghĩa |
|------------------------|----------------------|---------|
| Điều hướng màn hình | `§2 Thao tác` + `Tổng quan/Vào từ` | Màn hình vào từ đâu và đi tiếp đến đâu |
| Business Rules | `§4 Quy tắc và kiểm tra / Business Rules` | Quy tắc nghiệp vụ quyết định cho phép/chặn thao tác |
| Đầu ra sau thao tác | `§2 Thao tác / User thấy kết quả` | Kết quả người dùng nhìn thấy sau mỗi thao tác |

## Cấu trúc 5 mục và phạm vi nội dung

| Thông tin | Gộp vào mục |
|-----------|-------------|
| LABEL, quyền, menu, vào từ đâu | A. Tổng quan chức năng |
| Layout + tất cả field + dropdown values | B. Giao diện và trường dữ liệu |
| Events + navigate/popup/CSV + kết quả | C. Luồng xử lý theo thao tác |
| Bảng DB + file SQL (chỉ path) | D. Dữ liệu sử dụng |
| Business rules + validation + cảnh báo | E. Quy tắc nghiệp vụ và kiểm tra |
| Danh sách file path | F. Tài liệu tham chiếu |

## Yêu cầu riêng cho màn hình có bảng dữ liệu (LIST/REPORT)

- Bắt buộc điền bảng `Bảng kết quả hiển thị`.
- Mỗi cột phải nêu đủ 4 ý:
  1) nhãn cột hiển thị (JP),  
  2) key bind trong template (`$$xxx$$`),  
  3) nguồn dữ liệu từ bảng/cột DB,  
  4) ý nghĩa nghiệp vụ của cột.
- Nếu không phải màn hình list/report thì bỏ block này.

## Yêu cầu riêng cho màn hình xuất file (CSV/REPORT)

- Bắt buộc điền block `Cấu trúc file xuất`.
- Mỗi cột file cần mô tả:
  1) tên cột trong file,
  2) dữ liệu lấy từ đâu (bảng/cột DB hoặc field),
  3) định dạng dữ liệu (text/number/date),
  4) ghi chú nghiệp vụ nếu có.
- Nếu có nhiều định dạng file (CSV/XLS/PDF), tách rõ theo từng loại.

## Yêu cầu riêng cho màn hình chạy nền (BATCH/SCHEDULER)

- Bắt buộc điền block `Thông tin chạy nền`.
- Cần nêu rõ:
  1) trigger chạy (user click hay scheduler),
  2) thời điểm chạy (real-time, theo giờ, theo lịch),
  3) chương trình xử lý (FUNC_ID/job name),
  4) đầu ra (progress, log, CSV/XLS/PDF, cập nhật DB).

## Xác định loại màn hình trước khi viết

| Type | Dấu hiệu | Bắt buộc nhấn mạnh |
|------|----------|--------------------|
| LIST | Có search + list table | điều kiện search, cột list, click row |
| FORM | Có nhập + đăng ký | field input, validation, DB write |
| CSV/REPORT | Có xuất file | cột output file, trigger xuất |
| BATCH | Có nút chạy xử lý | kiểm tra trước chạy, progress/kết quả |
| MASTER | Màn hình danh mục | CRUD + rule trùng/sử dụng |

## Yêu cầu mô tả luồng xử lý tại mục §2 Thao tác

| Hành vi | Viết |
|---------|------|
| Trang load lại | Hiển thị lại danh sách |
| Chuyển màn hình | Mở màn hình XX |
| Popup | Popup tra cứu XX |
| Tải file | Tải file CSV |
| Batch nền | Gửi lệnh xử lý XX |
| Ghi DB | Lưu dữ liệu → hiển thị lại |
| Quay lại | Quay về màn hình XX |

Mỗi dòng event cần mô tả theo chuỗi:
`User action -> kiểm tra -> query/update DB -> bind output -> user thấy gì`

## Cột "Giá trị / Dropdown" (§1 Field)

| Trường hợp | Viết |
|------------|------|
| Giá trị cố định | `"1"`, `today` |
| Dropdown master | `MstXxx: A=val1, B=val2` |
| Dropdown DB | `TMS00050 (G79)` |
| Radio | `1=新規, 2=更新, 3=削除` |
| Không có | — |

## Cách nhận biết bắt buộc

- HTML: `<TH CLASS="required">` → ○
- Java: `required = true` trong constructor → ○
- Còn lại → —
