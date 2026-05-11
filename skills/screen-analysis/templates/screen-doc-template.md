# Detail Design — {SID}

## A. Tổng quan chức năng

| Mục | Giá trị |
|-----|---------|
| Screen ID | |
| Module | |
| Tên màn hình (JP) | |
| Tên màn hình (VN) | |
| Loại màn hình | |
| Quyền xem | |
| Quyền sửa | |
| Hiển thị trên menu | |
| Điểm vào chính | |
| Nhóm phân loại chính | LIST / FORM / DETAIL / CSV-REPORT / BATCH / MASTER |
| Nhóm phân loại phụ | (nếu có) |

**Mục tiêu nghiệp vụ:** (2-3 câu)

**Đối tượng sử dụng:** (xác định từ PERMISSION)

---

## B. Giao diện và trường dữ liệu

**Bố cục màn hình:**

```
(wireframe)
```

**Danh sách trường dữ liệu:**

| # | 項目名 (JP) | Field ID | Loại control | Bắt buộc | Giá trị mặc định / Nguồn chọn | Mô tả nghiệp vụ |
|---|------------|----------|--------------|----------|-------------------------------|-----------------|
| | | | | | | |

**Bảng kết quả hiển thị (áp dụng cho màn hình LIST/REPORT):**

| # | Tên cột hiển thị (JP) | Key dữ liệu/placeholder | Nguồn dữ liệu (bảng/cột) | Ý nghĩa nghiệp vụ |
|---|------------------------|-------------------------|--------------------------|-------------------|
| | | | | |

**Cấu trúc file xuất (áp dụng cho màn hình CSV/REPORT):**

| # | Tên cột trong file | Nguồn dữ liệu (bảng/cột hoặc field) | Định dạng dữ liệu | Ghi chú |
|---|---------------------|--------------------------------------|-------------------|---------|
| | | | (text/number/date) | |

---

## C. Luồng xử lý theo thao tác

| Mã event | Tên thao tác | Người dùng thực hiện | Hệ thống xử lý | Tác động dữ liệu | Kết quả hiển thị |
|---------|-------------|----------------------|----------------|------------------|------------------|
| | | | | (SELECT/INSERT/UPDATE bảng nào) | |

> Trình bày theo chuỗi: thao tác người dùng -> kiểm tra điều kiện -> đọc/ghi dữ liệu -> phản hồi trên màn hình.
> Tránh mô tả chung chung như "xử lý nghiệp vụ".

**Thông tin chạy nền (áp dụng cho BATCH/SCHEDULER):**

| Loại chạy | Trigger | Thời điểm chạy | Chương trình xử lý | Đầu ra |
|-----------|---------|----------------|--------------------|--------|
| Batch online / Scheduler | click nút / lịch định kỳ | ngay lúc click / hh:mm / hằng ngày-tháng | `{FUNC_ID}` hoặc job name | màn hình progress / file CSV/XLS/PDF / log |

---

## D. Dữ liệu sử dụng

| Bảng dữ liệu | Nội dung chính | Mục đích sử dụng | Liên quan thao tác |
|-------------|----------------|------------------|-------------------|
| | | | |

| File SQL (tham chiếu) | Mục đích truy vấn/cập nhật | Tham số đầu vào |
|-----------------------|----------------------------|-----------------|
| `path` | | |

---

## E. Quy tắc nghiệp vụ và kiểm tra

**Business Rules:**

| # | Quy tắc nghiệp vụ | Bằng chứng |
|---|---------|-----------|
| | | |

> "Business Rule" là luật quyết định hành vi hệ thống, ví dụ:
> - điều kiện nào được lưu, điều kiện nào bị chặn
> - điều kiện nào được in/xuất, điều kiện nào chỉ xem
> - dữ liệu nào bắt buộc phải có trước khi chạy event

**Validation đầu vào:**

| 項目名 (JP) | Quy tắc kiểm tra | Mã lỗi | Thông báo |
|------------|------------------|--------|-----------|
| | | | |

**Điểm cần lưu ý (nếu có):**

| Mức | Vấn đề | Ghi chú |
|-----|--------|---------|
| | | |

---

## F. Tài liệu tham chiếu

| File tham chiếu | Vai trò |
|---------------|---------|
| | |
