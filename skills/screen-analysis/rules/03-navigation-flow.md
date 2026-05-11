---
title: Luồng điều hướng
impact: HIGH
impactDescription: Xác định màn hình nguồn, màn hình đích, vị trí menu
tags: navigation, webflow, menu, mermaid
---

## 5. Luồng điều hướng

**Mục đích:** Lập sơ đồ "đi từ đâu vào màn hình này — đi tiếp đến đâu" cho mục 9 của output.

### 5.1. Màn hình nguồn (MstWebFlow.xml)

```bash
grep -n -B 1 -A 3 "<ID_FUNCTION>{MODULE}.{SCREEN_ID}<" \
  dev/master/yh/yhFramework/master/MstWebFlow.xml
```

**Mẫu:**

```xml
<record>
  <ID_FUNCTION>AB10.AB1011</ID_FUNCTION>
  <ID_FUNCTION_PREV>AB10.AB1010</ID_FUNCTION_PREV>
</record>
```

**Diễn giải:**

| Tình huống | Ý nghĩa |
|------------|---------|
| `ID_FUNCTION_PREV` rỗng | Entry point (vào trực tiếp từ menu/URL) |
| 1 record | Vào từ 1 nguồn duy nhất |
| Nhiều record | Vào được từ nhiều màn hình (mỗi record = 1 nguồn) |

### 5.2. Màn hình đích (từ Java + HTML)

Dùng kết quả grep `linked screens` ở bước 3.6 + grep HTML:

```bash
grep -n -oE 'HREF="[A-Z0-9]+|refInput\(.[A-Z0-9]+|location[^"]*"[A-Z0-9]+' \
  dev/template/tvmk/tscrum/{MODULE}/{SCREEN_ID}/*.html | sort -u
```

→ Lọc các Screen ID dạng `[A-Z]{2}[0-9]{4}`.

### 5.3. Vị trí trong menu (MstMenu.xml)

```bash
# Màn hình có nằm trong menu trực tiếp không?
grep -n -A 3 "<ID_FUNCTION>{MODULE}.{SCREEN_ID}<" \
  dev/master/yh/yhFramework/master/MstMenu.xml

# Toàn bộ menu group cùng module
grep -n -B 1 -A 60 "<ID_FUNCTION>menu.{MODULE}<" \
  dev/master/yh/yhFramework/master/MstMenu.xml | head -80
```

| Tình huống | Kết luận |
|------------|----------|
| Có record | Màn hình hiển thị trên menu — note label |
| Không có | Màn hình ẩn (pop-up / con của màn hình khác) |

### 5.4. Sinh sơ đồ Mermaid

```mermaid
flowchart LR
  PREV1 --> SCREEN[{SCREEN_ID}]
  PREV2 --> SCREEN
  SCREEN --> DEST1
  SCREEN --> DEST2
```

> Nếu màn hình có > 5 nguồn hoặc > 5 đích → gom lại bằng nhãn (VD "Tất cả màn hình search trong module").

**Output bước 5:** danh sách prev (kèm tham số truyền nếu thấy được trong code), danh sách dest, ghi chú menu — điền vào mục 9.
