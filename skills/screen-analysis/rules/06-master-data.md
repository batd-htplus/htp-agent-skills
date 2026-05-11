---
title: Danh mục master (dropdown)
impact: MEDIUM
impactDescription: Lấy danh sách giá trị cho các dropdown của form
tags: master, dropdown, xml
---

## 6. Danh mục master (dropdown)

**Mục đích:** Liệt kê các nguồn dropdown của form cho mục 8 của output.

> **Quan trọng:** Chỉ đọc các master XML thực sự được tham chiếu — lấy từ kết quả bước 3.5 (`new MstXxx(logic)`) và pattern `selXxx` trong fields.

### 6.1. Master XML trong module (file riêng)

```bash
ls -1 dev/master/tvmk/tscrum/{MODULE}/*.xml
```

Đọc các file XML có liên quan:

```xml
<table>
  <tableName>出張ステータスリスト</tableName>
  <header>
    <field><idField>ID</idField><fieldName>コード</fieldName></field>
    <field><idField>LABEL</idField><fieldName>名称</fieldName></field>
  </header>
  <record><ID>0</ID><LABEL>未申請</LABEL></record>
  <record><ID>10</ID><LABEL>申請中</LABEL></record>
</table>
```

**Cần trích:**

| Mục | Lấy từ |
|------|--------|
| Tên danh mục | `<tableName>` (cần dịch) |
| Số mục | đếm `<record>` |
| Mẫu giá trị | 2–3 record đầu để minh hoạ |

### 6.2. Master code dùng chung (TMS00050)

Khi Java có `new MstTMS00050(logic).select("XX", key)` → dropdown lấy từ DB bảng `TMS00050` filter theo `CTRL_CL = 'XX'`. Trường hợp này không có file XML — note "Tra qua DB `TMS00050 (CTRL_CL='XX')`".

**Output bước 6:** bảng nguồn dropdown gồm: Field UI ↔ Nguồn (XML hoặc DB) ↔ Số mục — điền vào mục 8.
