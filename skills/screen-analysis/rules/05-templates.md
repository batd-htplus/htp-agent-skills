---
title: Phân tích templates (HTML + SQL)
impact: CRITICAL
impactDescription: Lấy layout, danh sách bảng DB, tham số query
tags: templates, html, sql, database, tables
---

## 4. Phân tích templates (HTML + SQL)

**Mục đích:** Đọc HTML để dựng layout (mục 4 output) và đọc các file SQL **đã xác định ở bước 3.4** để liệt kê bảng DB, param, business rule (mục 7, 10).

> **Quan trọng:** Chỉ đọc SQL files có trong kết quả grep `getLocalTemplate(...)` ở bước 3 — không scan tất cả `*.sql`.

### 4.1. Liệt kê file template

```bash
ls -1 dev/template/tvmk/tscrum/{MODULE}/{SCREEN_ID}/
```

Cấu trúc điển hình:

| File | Vai trò |
|------|---------|
| `{SCREEN_ID}.html` | Layout chính |
| `listRecord.html` | 1 dòng kết quả (inject vào `$$list$$`) |
| `header.csv` / `record.csv` | Template export CSV |
| `{SCREEN_ID}NN.sql` | Câu SQL số NN |

### 4.2. Đọc HTML

Dùng `Read` cho `{SCREEN_ID}.html` và `listRecord.html`.

**Pattern cần nhận:**

| Pattern | Ý nghĩa |
|---------|---------|
| `<DIV CLASS="title">...</DIV>` | Tiêu đề màn hình |
| `<FORM NAME="form" METHOD="POST">` | Form chính |
| `<INPUT ... NAME="event">` | Hidden điều phối action |
| `$$xxx$$` | Placeholder bind từ Java FieldSet |
| `$$range.xxx$$...$$range.xxx$$` | Block hiển thị có điều kiện |
| `$$list$$` | Vị trí inject `listRecord.html` |
| `$$AB101101$$` | Vị trí inject kết quả SQL `AB101101.sql` |
| `ONCLICK="refInput('AB1012'..."` | Link sang màn hình `AB1012` |
| `setSort(N)` | JS đổi sort key |

> Chi tiết: `references/html-patterns.md`.

### 4.3. Đọc SQL (encoding Shift-JIS)

```bash
iconv -f cp932 -t utf-8 \
  dev/template/tvmk/tscrum/{MODULE}/{SCREEN_ID}/{SCREEN_ID}NN.sql
```

> Chi tiết encoding: `references/01-sql-encoding.md`.

**Pattern cần trích:**

| Pattern | Ghi nhận vào |
|---------|--------------|
| `FROM {TABLE}` / `JOIN {TABLE}` | Mục 7.1 (bảng) |
| `WHERE ... = ?` (có thứ tự) | Mục 7.3 (param) |
| `WHERE FLG_DELETE = '0'` | Mục 10 (BR: chỉ hiện active) |
| `$$rows$$` | Mục 7.2 (pagination) |
| `$$sortKeyFirst$$` | Mục 6 (sort động) |
| `$$range.xxx$$ ... $$range.xxx$$` | Param điều kiện |
| `--comment` đầu file | Mục đích query |
| Hard-code value | Mục 11 (cảnh báo) |

**Quy ước đặt tên bảng:**

| Prefix | Loại | Ví dụ |
|--------|------|-------|
| `TTAxxxxx` | Transaction (data nghiệp vụ) | `TTA00100` — đơn công tác |
| `TMSxxxxx` | Master code system | `TMS00050` — danh mục code chung |
| `TMAxxxxx` | Master HR | `TMA00010` — nhân viên |
| `FWM_*` | Framework system | `FWM_USER` |

### 4.4. listRecord.html

Mỗi `<TR>` dùng `$$COLUMN$$` để bind cột từ ResultSet.

```html
<TR>
  <TD><A ONCLICK="refInput('$$DEN_NO$$');">詳細</A></TD>
  <TD>$$DEN_NO$$</TD>
  <TD>$$APL_DAY$$</TD>
</TR>
```

→ Tên cột này phải khớp với `SELECT` trong file SQL ở 4.3.

**Output bước 4:** layout HTML rút gọn (cho mục 4), bảng tables (mục 7.1), bảng query (mục 7.2), chi tiết SQL chính (mục 7.3).
