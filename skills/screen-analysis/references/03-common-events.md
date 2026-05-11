---
title: Event patterns
---

## Event patterns

Event là parameter key `event` dùng để điều phối action trong servlet.

### Cấu trúc event

```
Event = SCREEN_ID (4 ký tự) + sequence (2 ký tự)
VD: AB101100 = screen AB1011, event 00
```

### Danh sách event sequence

| Code | Ý nghĩa | Ghi chú |
|------|---------|---------|
| 00 | Khởi tạo / Tìm kiếm (Init / Search) | Event mặc định khi vào màn hình |
| 01 | Thêm / Lưu (Insert / Save) | |
| 02 | Sắp xếp (Sort) | Cột đầu = sort key |
| 03 | Cập nhật (Update) | |
| 04 | Xóa (Delete) | |
| 05 | Hủy (Cancel) | |
| 06 | Xuất CSV / In (CSV / Print) | Thường gọi `exportCSV()` |
| 07 | Duyệt / Phê duyệt (Approve / Reject) | |
| 08 | Gửi mail (Send mail) | |
| 09 | Đối chiếu (Verify / Check) | |
| 10-49 | Tùy theo màn hình | Các action bổ sung |
| 50-99 | Reserved | |

### Grep nhanh event

```bash
grep -oP 'event\.equals\("[A-Z0-9]{6}"' \
  dev/java/src/tvmk/tscrum/{MODULE}/{SCREEN_ID}.java
```

### Event flow điển hình

```
event=00: validate → build search param → query DB → bind data → render HTML
event=01: validate → get form data → insert/update DB → re-search (event=00)
event=02: get sort params → re-query với ORDER BY → render
event=04: validate → update FLG_DELETE → re-search
event=06: query all → write CSV header + records → download
```
