# Field Specification Format (項目定義書フォーマット)

> Reference for reading/creating field specification tables from design documents.
> Load when user provides a field spec image or asks to create field definitions.

## Standard Columns

| Column (JP) | Column (VN) | Description |
|-------------|-------------|-------------|
| No. | STT | Sequential number |
| Item name (項目名) | Tên mục | Field display name (Japanese) |
| Phân loại control | Loại control | UI control type |
| Data type | Kiểu dữ liệu | e.g. yyyy/mm/dd |
| Số chữ số | Độ dài | Max character length |
| In-Out put | I/O | Input or Output or Both |
| Required input | Bắt buộc | ○ = required |
| Giá trị ban đầu | Giá trị mặc định | Default value |
| Thứ tự sort | Thứ tự sắp xếp | Sort priority |
| Giải thích (説明) | Ghi chú | Business logic notes |

## Control Types Mapping

| Spec value | yhFramework class | HTML output |
|-----------|-------------------|-------------|
| Text box | FieldText | `<INPUT TYPE="TEXT">` |
| Pull down | FieldSelect | `<SELECT>` |
| Radio button | FieldRadioButton | `<INPUT TYPE="RADIO">` |
| Label | (display only) | `<SPAN>` or `$$column$$` |
| Button | FieldButton | `<INPUT TYPE="BUTTON">` |
| Check box | FieldCheckBoxList | `<INPUT TYPE="CHECKBOX">` |
| Text area | FieldTextArea | `<TEXTAREA>` |
| Hidden | FieldHidden | `<INPUT TYPE="HIDDEN">` |

## Screen Sections (from spec documents)

| Section marker | Meaning | Scope |
|---------------|---------|-------|
| ＜Điều kiện search＞ | Search conditions area | Filter/search form fields |
| ＜引き合い基本情報 Input item＞ | Basic inquiry info - Input | Editable header fields |
| ＜引き合い詳細情報 Input item＞ | Detail inquiry info - Input | Editable line item fields |
| 処理モード | Processing mode | Radio: 新規(New) / 変更(Edit) |

## Processing Mode Pattern

| Mode (JP) | Mode (VN) | Behavior |
|-----------|-----------|----------|
| 新規 | Tạo mới | Show empty form, enable all inputs |
| 変更 | Chỉnh sửa | Load existing data, some fields readonly |
| 参照 | Xem | All fields readonly |
| 削除 | Xóa | Confirm then soft-delete |

## Data Source Notation (in spec's Giải thích column)

| Pattern | Meaning |
|---------|---------|
| 取引先M | Master table for business partners |
| 品目M / 品目サブM | Item master / Item sub-master |
| システム区分M | System category master |
| 引き合い情報 | Inquiry/Lead transaction table |
| 処理区分 | Processing category (hardcoded list) |
| コードM (CST01) | Code master with category CST01 |
| →品目M | Lookup from Item master |

## Common Field Patterns from Spec

| Field name (JP) | Typical control | Notes |
|----------------|-----------------|-------|
| 中分類 | Pull down | Category from 品目M |
| 中分類名称 | Label | Auto-filled from master |
| 担当者 | Pull down | From 人事組織M (HR org master) |
| 得意先番号 | Text box (60 chars) | Customer code, triggers master lookup |
| 得意先名 | Label | Auto-filled from 取引先M |
| 需要家番号 | Text box (60 chars) | End-user code |
| 需要家名 | Label | Auto-filled |
| 引合ランク | Pull down | From システム区分M, code C32 (A,B,C) |
| 処理区分 | Label | From 引き合い情報, master 処理区分 C31 |
| 引き合いNo | Text box / Label | Inquiry number (auto-generated or manual) |
| 注文番号 | Text box | Order number |
| 登録日 | Label yyyy/mm/dd | Registration date (auto) |
| 最終更新日 | Label yyyy/mm/dd | Last update date (auto) |

## "Khi update thì clear" Pattern

When a field is updated, dependent fields are cleared:
- 得意先番号 updated → clear 外貨単価, 単価 (foreign currency price, unit price)
- 中分類 changed → clear 小分類 (sub-category depends on category)

## Cross-reference Notation

| Notation | Meaning |
|----------|---------|
| →品目M | Lookup value from Item master |
| →取引先番号 | Reference to customer number |
| 音素取組記号組付M →品目M | Component-assembly master → Item master |
