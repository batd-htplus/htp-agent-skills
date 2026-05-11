# Tham chiếu pattern HTML

## Template engine

Dùng custom engine với placeholder `$$...$$`:

| Placeholder | Loại | Nguồn |
|------------|------|-------|
| `$$text://xxx$$` | Text resource | i18n bundle |
| `$$yhFramework.xxx$$` | Framework injection | CSS, JS, header, menu |
| `$$columnName$$` | Data binding | Java FieldSet |
| `$$range.xxx$$` | Conditional block | Java range |
| `$$list$$` | List injection | listRecord.html |
| `$$AB101101$$` | Kết quả SQL | AB101101.sql |
| `$$sortClsN$$` | Sort CSS | sort state |
| `$$message$$` | System message | AppMessageSet |

## Cấu trúc form

```html
<FORM NAME="form" METHOD="POST" ENCTYPE="multipart/form-data">
  <INPUT TYPE="hidden" NAME="event">
  <INPUT TYPE="hidden" NAME="sortKeySws" VALUE="$$sortKeySws$$">
  <INPUT TYPE="hidden" NAME="sortNo" VALUE="$$sortNo$$">
  ... fields ...
</FORM>
```

## Navigation patterns

```javascript
// Link sang màn hình khác
window.top.location = "AB1012?from=AB1011&denNo=" + denNo;

// Sort
function setSort(no) {
  document.form.event.value = 'AB101102';
  document.form.sortNo.value = no;
  document.form.submit();
}
```
