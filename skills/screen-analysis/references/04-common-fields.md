---
title: Field types
---

## Field types — Form fields trong yhFramework

Các field được khai báo trong `service` method của Servlet để tạo form HTML.

### Danh sách field types

| Class | Ý nghĩa | HTML output |
|-------|---------|-------------|
| `FieldHidden` | Hidden field — không hiển thị | `<INPUT TYPE="HIDDEN">` |
| `FieldText` | Ô nhập text 1 dòng | `<INPUT TYPE="TEXT">` |
| `FieldButton` | Nút bấm | `<INPUT TYPE="BUTTON">` hoặc `<A>` |
| `FieldDate` | Ô chọn ngày tháng | `<INPUT TYPE="TEXT">` + calendar popup |
| `FieldSelect` | Dropdown 1 lựa chọn | `<SELECT>` |
| `FieldCheckBoxList` | Checkbox nhiều lựa chọn | `<INPUT TYPE="CHECKBOX">` |
| `FieldRadioButton` | Radio button | `<INPUT TYPE="RADIO">` |
| `FieldTextArea` | Ô nhập text nhiều dòng | `<TEXTAREA>` |

### Grep nhanh fields

```bash
grep -oP 'new Field\w+\("([^"]+)"' \
  dev/java/src/tvmk/tscrum/{MODULE}/{SCREEN_ID}.java | sort -u
```

### Field naming convention

| Prefix | Loại field | Ví dụ |
|--------|-----------|-------|
| `event` | Hidden — event dispatch | `FieldHidden("event")` |
| `sort*` | Hidden — sort state | `FieldHidden("sortClsN"), FieldHidden("sortNo")` |
| `txt*` | Text input | `FieldText("txtDenNo")` |
| `btn*` | Button | `FieldButton("btnSearch")` |
| `sel*` | Dropdown | `FieldSelect("selStatus")` |
| `chk*` | Checkbox | `FieldCheckBoxList("chkMulti")` |
| `cal*` | Date picker | `FieldDate("calAplDay")` |

### Field attributes

Mỗi field thường có các attribute:
- `field.readOnly = true` — không cho sửa
- `field.required = true` — bắt buộc nhập
- `field.maxlength = 10` — giới hạn ký tự
- `field.imeMode = true` — bật IME tiếng Nhật
