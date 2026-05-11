---
title: Phân tích Java source
impact: CRITICAL
impactDescription: Lấy events, fields, SQL refs, master DAO refs, linked screens
tags: java, source, events, fields, queries
---

## 3. Phân tích Java source

**Mục đích:** Đọc file `{SCREEN_ID}.java` để biết: các event, form fields, SQL nào được dùng (để bước 4 không đọc thừa), master DAO nào được dùng (để bước 6 đọc đúng), màn hình link đi đâu.

**Đọc file:** dùng `Read` với đường dẫn `dev/java/src/tvmk/tscrum/{MODULE}/{SCREEN_ID}.java`. Nếu file > 500 dòng → grep trước, đọc range sau.

### 3.1. Class signature

```bash
grep -n -E "^public class|extends|implements" \
  dev/java/src/tvmk/tscrum/{MODULE}/{SCREEN_ID}.java | head -3
```

Kỳ vọng: `public class {SCREEN_ID} extends AppServlet implements TextTemplateListener`.

### 3.2. Events

```bash
grep -n -oE 'event\.equals\("[^"]+"\)' \
  dev/java/src/tvmk/tscrum/{MODULE}/{SCREEN_ID}.java | sort -u
```

**Quy ước event sequence:**

| Code | Ý nghĩa | Code | Ý nghĩa |
|------|---------|------|---------|
| `00` | Init / Search | `04` | Delete |
| `01` | Insert / Save | `05` | Cancel |
| `02` | Sort | `06` | CSV / Print |
| `03` | Update | `07` | Approve / Reject |

> Chi tiết: `references/03-common-events.md`.

### 3.3. Form fields

```bash
grep -n -oE 'new Field\w+\("[^"]+"' \
  dev/java/src/tvmk/tscrum/{MODULE}/{SCREEN_ID}.java | sort -u
```

**Field types thường gặp:**

| Class | UI | Class | UI |
|-------|-----|-------|-----|
| `FieldHidden` | hidden | `FieldDate` | date picker |
| `FieldText` | text 1 dòng | `FieldSelect` | dropdown |
| `FieldButton` | button | `FieldCheckBoxList` | checkbox list |
| `FieldTextArea` | text nhiều dòng | `FieldRadioButton` | radio |

> Chi tiết: `references/04-common-fields.md`.

### 3.4. SQL references (quan trọng — quyết định bước 4)

```bash
grep -n -oE 'getLocalTemplate\("[^"]+\.sql"\)' \
  dev/java/src/tvmk/tscrum/{MODULE}/{SCREEN_ID}.java | sort -u
```

→ Bước 4 chỉ cần đọc đúng các file SQL trong kết quả này, không scan toàn bộ template dir.

### 3.5. Master DAO references (quyết định bước 6)

```bash
grep -n -oE 'new Mst\w+\(logic\)' \
  dev/java/src/tvmk/tscrum/{MODULE}/{SCREEN_ID}.java | sort -u
```

→ Bước 6 chỉ đọc các master XML tương ứng (VD `MstTMS00050` → `references/02-module-list.md` để map).

### 3.6. Linked screens

```bash
grep -n -oE '(location|href|URL)[^"]*"[^"]*[A-Z]{2}[0-9]{4}' \
  dev/java/src/tvmk/tscrum/{MODULE}/{SCREEN_ID}.java | sort -u
```

### 3.7. Validation / business rule clues

```bash
grep -n -E "validate|required|hasRole|getAppUser|FLG_DELETE" \
  dev/java/src/tvmk/tscrum/{MODULE}/{SCREEN_ID}.java | head -30
```

→ Dùng để điền mục 10 (Business Rules) và mục 11 (Validation) của output.

**Output bước 3:** danh sách events, fields, SQL refs, master DAO refs, linked screens — kèm số dòng.
