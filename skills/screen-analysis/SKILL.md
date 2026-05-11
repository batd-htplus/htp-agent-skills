---
name: screen-analysis
version: 3.1.0
description: Phân tích màn hình ERP theo Screen ID, xuất Detail Design.
triggers: [screen analysis, detail design, 画面分析, 詳細設計, yhFramework, MstServlet]
---

# Phân tích màn hình

Khi user yêu cầu phân tích 1 màn hình (VD: "phân tích EA1011"), chạy 7 bước dưới đây **theo đúng thứ tự**. Mỗi bước có lệnh cụ thể — chạy lệnh, lấy kết quả, ghi vào output.

**KHÔNG đọc thêm file rule/reference nào trừ khi gặp lỗi.** Mọi thứ cần thiết đã ở đây.

## Nguyên tắc bắt buộc

- Không chèn nguyên văn SQL vào tài liệu, chỉ ghi file path tham chiếu.
- Không chèn nguyên văn XML cấu hình (MstServlet, MstWebFlow, MstMenu), chỉ tóm tắt thông tin cần thiết.
- Không để section trống.
- Không tách section Điều hướng riêng; gộp vào bảng thao tác.
- Không tách section Dropdown riêng; gộp vào bảng field.

## Định nghĩa chuẩn (tránh hiểu sai)

- **Điều hướng** = vào từ đâu + đi tới đâu.  
  Trong format mới: gộp vào `Tổng quan/Vào từ` và `§2 Thao tác -> User thấy kết quả`.
- **Business Rules** = luật nghiệp vụ quyết định hành vi hệ thống (cho phép/chặn/ràng buộc).  
  Không phải danh sách SQL hay danh sách bảng.
- **Đầu ra** = user thao tác xong thì thấy gì (re-render, mở màn hình khác, popup, tải file, batch progress, thông báo).  
  Trong format mới: gộp vào `§2 Thao tác`.

---

## BƯỚC 1: Xác định đường dẫn (không cần đọc file)

Từ Screen ID (gọi là `SID`), tính:

```
SID    = DA1100            ← user cung cấp
MODULE = DA11              ← bỏ 2 số cuối (DA1100→DA11, EA1011→EA10, GA1004→GA10)
FUNC   = DA11.DA1100      ← dùng trong XML

JAVA   = dev/java/src/tvmk/tscrum/{MODULE}/{SID}.java
HTML   = dev/template/tvmk/tscrum/{MODULE}/{SID}/{SID}.html
SQLDIR = dev/template/tvmk/tscrum/{MODULE}/{SID}/
MSTSVL = dev/master/yh/yhFramework/master/MstServlet.xml
MSTWF  = dev/master/yh/yhFramework/master/MstWebFlow.xml
MSTMN  = dev/master/yh/yhFramework/master/MstMenu.xml
```

**Nếu không tìm thấy Java file:**
```bash
ls dev/java/src/tvmk/tscrum/ | grep -i {2 ký tự đầu của MODULE}
```

---

## BƯỚC 2: Grep MstServlet.xml — lấy tên + quyền

```bash
grep -n -A 10 "<ID_FUNCTION>{MODULE}.{SID}<" dev/master/yh/yhFramework/master/MstServlet.xml
```

Lấy: LABEL, AUTHENTICATION, PERMISSION, EDIT_PERMISSION, FILE_TYPE, TIMEOUT.

---

## BƯỚC 3: Đọc Java — lấy events, fields, SQL refs

```bash
grep -n 'event.equals(' dev/java/src/tvmk/tscrum/{MODULE}/{SID}.java
grep -n 'new Field' dev/java/src/tvmk/tscrum/{MODULE}/{SID}.java
grep -n 'getLocalTemplate(' dev/java/src/tvmk/tscrum/{MODULE}/{SID}.java
grep -n 'new Mst' dev/java/src/tvmk/tscrum/{MODULE}/{SID}.java
grep -n -E 'location|refInput|sendRedirect|idFunction.*"[A-Z]' dev/java/src/tvmk/tscrum/{MODULE}/{SID}.java
```

Nếu file > 500 dòng: grep trước, đọc range sau.

---

## BƯỚC 4: Đọc HTML + SQL

**HTML:**
```bash
Read: dev/template/tvmk/tscrum/{MODULE}/{SID}/{SID}.html
```
Tìm: `<DIV CLASS="title">`, `<TH CLASS="required/notRequired">label</TH><TD>$$id$$</TD>`, `refInput(`, `$$list$$`

**SQL** (chỉ file từ bước 3 `getLocalTemplate`):
```bash
iconv -f cp932 -t utf-8 dev/template/tvmk/tscrum/{MODULE}/{SID}/{SQL_FILE}
```
Tìm: `FROM/JOIN` → bảng, `WHERE ?` → tham số, `FLG_DELETE`, `$$rows$$`, `$$range.xxx$$`

⚠️ **GHI NHỚ:** Đọc SQL để hiểu logic, nhưng KHÔNG copy nội dung SQL vào output. Chỉ ghi tóm tắt (bảng nào, tham số gì, mục đích gì).

---

## BƯỚC 5: Grep MstWebFlow + MstMenu

```bash
grep -n -B 1 -A 3 "<ID_FUNCTION>{MODULE}.{SID}<" dev/master/yh/yhFramework/master/MstWebFlow.xml
grep -n -A 3 "<ID_FUNCTION>{MODULE}.{SID}<" dev/master/yh/yhFramework/master/MstMenu.xml
```

Gộp kết quả vào bảng "Tổng quan" (có menu hay không, vào từ đâu).

---

## BƯỚC 6: Master data (dropdown) — chỉ khi bước 3 có `new Mst`

```bash
ls dev/master/tvmk/tscrum/{MODULE}/*.xml
```
Gộp kết quả vào cột "Default/Dropdown" của bảng field.

---

## BƯỚC 7: Tổng hợp

- Business Rules: chỉ ghi có bằng chứng code
- Validation: gồm cả label JP của field
- Cảnh báo: chỉ ghi nếu THẤY trong code

---

## SCREEN TYPE PROFILE (bắt buộc chọn 1)

Trước khi viết DD, phải phân loại màn hình để chọn cách diễn giải:

| Type | Dấu hiệu nhận biết | Trọng tâm mô tả |
|------|-------------------|-----------------|
| `LIST` | Có điều kiện tìm kiếm + bảng kết quả + sort/page | Điều kiện tìm kiếm, cột list, hành vi khi click dòng |
| `FORM` | Có field nhập/sửa + nút đăng ký/cập nhật/xóa | Field input, validation, ghi DB, trạng thái sau lưu |
| `DETAIL` | Chủ yếu hiển thị, ít/không chỉnh sửa | Nguồn dữ liệu hiển thị, điều kiện khóa/chỉ đọc |
| `CSV/REPORT` | Có event xuất file, header/record template | Cấu trúc file output, trigger xuất, điều kiện lọc |
| `BATCH/PROCESS` | Nút thực thi xử lý nền, progress/message | Điều kiện chạy, kiểm tra trước chạy, kết quả sau chạy |
| `MASTER` | Màn hình quản trị danh mục/mã hệ thống | CRUD rule, kiểm tra trùng, ảnh hưởng màn hình khác |

Nếu màn hình có nhiều tính chất, chọn `Primary type` và thêm `Secondary type`.

---

## FORMAT OUTPUT — cấu trúc tài liệu đề xuất

```markdown
# Detail Design — {SID}

## Tổng quan
(bảng tóm tắt + 2-3 câu chức năng + ai dùng)

## B. Giao diện và trường dữ liệu
(wireframe + bảng field — gộp cả dropdown values vào cột "Giá trị / Dropdown")
← Nếu là LIST/REPORT: bắt buộc thêm bảng mô tả cột kết quả (column label, bind key, nguồn DB, ý nghĩa)
← Nếu là CSV/REPORT: bắt buộc thêm bảng cấu trúc cột file xuất (CSV/XLS/PDF)

## C. Luồng xử lý theo thao tác
(bảng: Mã, Tên, User làm gì, Hệ thống xử lý, User thấy kết quả)
← Viết dễ hiểu: "mở màn hình X", "popup tra cứu", "tải CSV", "lưu dữ liệu"
← Navigate/popup/batch GỘP VÀO ĐÂY, không tách section riêng
← **Bắt buộc nêu data-flow theo event:** query bảng nào, ghi bảng nào, lấy dữ liệu gì để hiển thị gì
← Nếu là BATCH/SCHEDULER: nêu rõ trigger chạy, thời điểm chạy, chương trình xử lý, và đầu ra

## D. Dữ liệu sử dụng
(bảng bảng DB + bảng file SQL — CHỈ path + mô tả, KHÔNG copy nội dung)
← Không mô tả SQL chung chung; phải map sang event cụ thể (event nào dùng SQL nào để lấy/ghi dữ liệu gì)
← Trả lời được câu hỏi: "event init/search/save lấy bảng nào, lấy cột gì, để hiển thị gì?"

## E. Quy tắc nghiệp vụ và kiểm tra
(Business Rules + Validation + Cảnh báo — GỘP vào 1 section)

## F. Tài liệu tham chiếu
(danh sách path + vai trò)
```

**Quy định chất lượng đầu ra:**
1. Không chèn SQL/XML nguyên văn
2. Không tách section Dropdown/Navigation/Appendix riêng
3. Không để section trống
4. Giữ cấu trúc tối đa 5 mục chính (Tổng quan + §1-§5)
5. Validation phải có `項目名` tiếng Nhật
6. Field phải có `項目名` tiếng Nhật

---

## QUY TẮC DIỄN GIẢI EVENT (rất quan trọng)

Mỗi dòng trong mục `## 2. Thao tác` phải theo format:

`[Event] User action → System check/transform → Query/Update DB (table) → Bind output (field/list/file) → User-visible result`

Ví dụ viết tốt:
- `EA301001 Init → đọc TTE00060 lấy closing month → bind vào I_CLOSING_MNTH → user thấy tháng hiện tại trên form`
- `BB101002 Search → validate điều kiện ngày + loại rate → query TM_KWSRT_URG_* → bind listRecord → user thấy danh sách tỷ giá`
- `DA110004 Print → gom param form + user context → gọi batch DA11.DA1102 → user thấy progress xử lý in`

Viết kém (cấm):
- `Search dữ liệu`
- `Query DB và hiển thị`
- `Xử lý theo logic nghiệp vụ`

---

## PHỤ LỤC: Tra cứu khi cần

| Vấn đề | File |
|--------|------|
| SQL lỗi encoding | `references/01-sql-encoding.md` |
| Module name | `references/02-module-list.md` |
| Event code lạ | `references/03-common-events.md` |
| Field type lạ | `references/04-common-fields.md` |
| Dịch label JP | `references/05-japanese-labels.md` |
