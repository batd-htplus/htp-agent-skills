---
title: Mã hóa file SQL (Shift-JIS / cp932)
---

## Mã hóa file SQL

Các file `.sql` trong template được lưu bằng encoding **Shift-JIS (cp932)**.

### Cách kiểm tra

```bash
file dev/template/tvmk/tscrum/AB10/AB1011/AB101100.sql
# Output: Non-ISO extended-ASCII text, với CRLF line terminators
```

### Cách đọc đúng

```bash
iconv -f cp932 -t utf-8 dev/template/tvmk/tscrum/AB10/AB1011/AB101100.sql
```

### Pattern thường gặp

| Ký tự Shift-JIS | Ý nghĩa |
|----------------|---------|
| `WHERE FLG_DELETE = '0'` | Xóa mềm (chưa xóa) |
| `WHERE FLG_DELETE = '1'` | Đã xóa |
| `AND ROWNUM <= $$rows$$` | Pagination |
| `ORDER BY $$sortKeyFirst$$ $$sortOrderFirst$$` | Sắp xếp động |
| `AND APL_DAY LIKE $$APL_DAY$$` | Search pattern động |

### Lưu ý

- Một số file có BOM cp932 — iconf vẫn xử lý được
- File không có extension `.sql` cũng là SQL (đọc nội dung để kiểm tra)
