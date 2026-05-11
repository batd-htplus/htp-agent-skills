---
title: Phân tích nâng cao
impact: HIGH
impactDescription: Tổng hợp input/output, business rule, validation, anti-pattern
tags: advanced, input, output, group, anti-pattern
---

## 7. Phân tích nâng cao (tổng hợp cuối)

**Mục đích:** Sau khi có dữ liệu thô từ bước 1–6, suy luận để điền các mục 2 (mục đích nghiệp vụ), 10 (business rule), 11 (validation + cảnh báo), 12 (output) của detail design.

### 7.1. Bảng đầu vào (mục 5 + tổng hợp)

| Loại | Cách phát hiện | Vị trí output |
|------|----------------|---------------|
| Form field | `new FieldXxx("name"` (bước 3.3) | Mục 5 |
| URL param | `param.get("name", default)` | Mục 5 (note "URL") |
| Session | `request.getSession().getAttribute(...)` | Mục 5 (note "Session") |
| Master DAO | `new MstXxx(logic).select(...)` | Mục 8 |
| User context | `logic.getAppUser().getXxx()` | Mục 10 (BR phụ thuộc user) |

### 7.2. Bảng đầu ra (mục 12)

| Loại | Cách phát hiện | Trigger event |
|------|----------------|---------------|
| HTML render | `template.writeTo(response.getWriter())` | Hầu hết event |
| CSV download | `header.csv` + `record.csv` trong template dir | event=06 |
| DB INSERT | SQL `INSERT INTO ...` | event=01 |
| DB UPDATE | SQL `UPDATE ... SET` | event=03/04 |
| File download | `response.setHeader("Content-Disposition", ...)` | event=06 hoặc tuỳ |

### 7.3. Suy luận business rule

| Manh mối trong code/SQL | BR suy ra |
|--------------------------|-----------|
| `WHERE FLG_DELETE='0'` | Chỉ hiển thị bản ghi chưa xóa |
| `WHERE APL_PERSON_NO != ?` (param = current user) | Không cho thao tác trên đơn của chính mình |
| `if (!user.hasRole("sys"))` lọc thêm điều kiện | User thường chỉ thấy data của mình |
| `$$range.xxx$$` bao quanh điều kiện | Param tuỳ chọn (chỉ áp dụng nếu user nhập) |
| Hard-code status `WHERE status='10'` | BR cố định trạng thái — note rõ |

### 7.4. Phát hiện anti-pattern (mục 11 — cảnh báo)

| Vấn đề | Dấu hiệu | Mức |
|---------|----------|-----|
| Không khai báo PERMISSION nhưng có UPDATE/DELETE | `<PERMISSION></PERMISSION>` + có event=01/03/04 | 🟡 Cảnh báo |
| Không khai báo EDIT_PERMISSION | `<EDIT_PERMISSION></EDIT_PERMISSION>` | ⚪ Thông tin |
| Hard-code value trong SQL | `WHERE status = '10'` thay vì param | 🟡 Cảnh báo |
| LIKE đầu chuỗi không index | `LIKE '%...%'` hoặc `LIKE '%...'` | 🟡 Hiệu năng |
| Thiếu kiểm tra self-action | Delete/approve không check `user != target_user` | 🔴 Bảo mật |
| SELECT không LIMIT | Không có `$$rows$$` hoặc `ROWNUM` | 🟡 Hiệu năng |
| Concat string thay vì param | `"WHERE id=" + value` | 🔴 SQL injection |

### 7.5. Gom nhóm màn hình cùng business flow (tham khảo)

Khi muốn vẽ flow tổng cho cả module, nhóm theo pattern:

| Pattern | Mô tả | Ví dụ AB10 |
|---------|-------|-------------|
| Menu → List → Detail | Vào menu → list → bấm 1 dòng → detail | 1010 → 1011/1020 → 1012 |
| Search → Result → Detail | Form search → list → detail | 1030/1032 → 1014 |
| Master CRUD | Màn hình quản lý danh mục | 1060 → 1061 |
| Process + History | Thao tác + xem lịch sử | 1056 → 1062 |

**Output bước 7:** điền các mục 2, 10, 11, 12 của detail design + đánh số bằng chứng để verify.
