---
title: Xác định module
impact: CRITICAL
impactDescription: Sai module → sai mọi đường dẫn — bước nền, không IO
tags: module, detection, path
---

## 1. Xác định module

**Mục đích:** Từ Screen ID, suy ra MODULE và toàn bộ đường dẫn cần đọc.

**Quy tắc:**

```
MODULE   = SCREEN_ID[:4]              # AB1011 → AB10
FUNC_ID  = MODULE + "." + SCREEN_ID   # AB10.AB1011  (dùng trong các Mst*.xml)
EVENT_0  = SCREEN_ID + "00"           # AB101100     (init event mặc định)
```

**Bảng đường dẫn (relative từ project root):**

| Thành phần | Đường dẫn |
|------------|-----------|
| Java class | `dev/java/src/tvmk/tscrum/{MODULE}/{SCREEN_ID}.java` |
| Helper module | `dev/java/src/tvmk/tscrum/{MODULE}/{MODULE}SB.java` |
| Template dir | `dev/template/tvmk/tscrum/{MODULE}/{SCREEN_ID}/` |
| MstServlet | `dev/master/yh/yhFramework/master/MstServlet.xml` |
| MstWebFlow | `dev/master/yh/yhFramework/master/MstWebFlow.xml` |
| MstMenu | `dev/master/yh/yhFramework/master/MstMenu.xml` |
| Master data module | `dev/master/tvmk/tscrum/{MODULE}/Mst*.xml` |

**Trường hợp đặc biệt:**

| ID prefix | Loại | Ví dụ |
|-----------|------|-------|
| `yhFramework.` | Framework screen | `yhFramework.Login` |
| `menu.` | Menu group | `menu.AB10` |
| 6 ký tự `XX####` | Screen thường | `AB1011` |

**Output bước 1:** chỉ là biến — chưa cần đọc file gì.
