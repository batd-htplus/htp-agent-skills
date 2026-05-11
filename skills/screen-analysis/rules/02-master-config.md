---
title: Cấu hình master (MstServlet.xml)
impact: CRITICAL
impactDescription: Xác nhận màn hình tồn tại + lấy LABEL, PERMISSION, AUTHENTICATION
tags: mstservlet, config, permission, authentication
---

## 2. Cấu hình master (MstServlet.xml)

**Mục đích:** Lấy chức năng (LABEL), quyền (PERMISSION/EDIT_PERMISSION), xác thực (AUTHENTICATION) cho điền vào mục 1, 3 của output.

**Lệnh chính:**

```bash
grep -n -A 10 "<ID_FUNCTION>{MODULE}.{SCREEN_ID}<" \
  dev/master/yh/yhFramework/master/MstServlet.xml
```

> Bao luôn `<` cuối để tránh khớp prefix dài hơn (VD `AB1011` khớp nhầm `AB10110`).

**Mẫu kết quả:**

```xml
<record>
  <ID_FUNCTION>AB10.AB1011</ID_FUNCTION>
  <LABEL>出張申請一覧（申請対象）</LABEL>
  <FILE_TYPE>.html</FILE_TYPE>
  <AUTHENTICATION>required</AUTHENTICATION>
  <PERMISSION></PERMISSION>
  <EDIT_PERMISSION></EDIT_PERMISSION>
  <TIMEOUT>0</TIMEOUT>
</record>
```

**Bảng giải nghĩa:**

| Trường | Giá trị có thể | Ý nghĩa |
|--------|----------------|---------|
| `LABEL` | Text JP | Chức năng — cần dịch sang VN |
| `FILE_TYPE` | `.html` / `.ajax` / `.csv` | Loại response render |
| `AUTHENTICATION` | `required` / `reject` / rỗng | `required` = phải login; `reject` = chặn truy cập trực tiếp |
| `PERMISSION` | code (VD `A3,sys`) / rỗng | Rỗng = mọi user đã login đều xem được |
| `EDIT_PERMISSION` | code / rỗng | Rỗng = fallback về `PERMISSION` |
| `TIMEOUT` | số giây | `0` = mặc định framework |

**Khi không tìm thấy:**

```bash
# Thử grep ngắn hơn để xem có phải sai screen ID
grep -n "<ID_FUNCTION>{MODULE}\." \
  dev/master/yh/yhFramework/master/MstServlet.xml | head -20
```

**Output bước 2:** dòng dữ liệu để điền mục 1 (LABEL, FILE_TYPE) và mục 3 (AUTH, PERMISSION) của detail design + lưu lại số dòng để trích nguồn.
