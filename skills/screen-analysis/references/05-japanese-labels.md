# Japanese Labels Dictionary (日本語ラベル辞典)

> Load this file when encountering Japanese text in LABEL, column names, or UI elements.

## Screen Type Suffixes (画面種別)

| Japanese | Reading | Vietnamese | English | Example LABEL |
|----------|---------|-----------|---------|---------------|
| 一覧 | いちらん | Danh sách | List/Index | 出張申請一覧 |
| 登録 | とうろく | Đăng ký/Nhập liệu | Registration | 出張登録 |
| 詳細 | しょうさい | Chi tiết | Detail | 出張詳細 |
| 検索 | けんさく | Tìm kiếm | Search | 社員検索 |
| 承認 | しょうにん | Phê duyệt | Approval | 出張承認 |
| 申請 | しんせい | Đơn xin/Yêu cầu | Application | 出張申請 |
| 照会 | しょうかい | Tra cứu | Inquiry | 経費照会 |
| 集計 | しゅうけい | Tổng hợp | Summary | 月次集計 |
| 出力 | しゅつりょく | Xuất/In | Export/Print | 帳票出力 |
| 管理 | かんり | Quản lý | Management | マスタ管理 |
| 履歴 | りれき | Lịch sử | History | 変更履歴 |
| 入力 | にゅうりょく | Nhập liệu | Input | データ入力 |
| 確認 | かくにん | Xác nhận | Confirmation | 申請確認 |
| 処理 | しょり | Xử lý | Processing | 月次処理 |
| 設定 | せってい | Thiết lập | Settings | 初期設定 |

## Business Domain Terms (業務用語)

| Japanese | Vietnamese | Context in T-SCRUM |
|----------|-----------|-------------------|
| 出張 (しゅっちょう) | Công tác | Module AB10 |
| 車両 (しゃりょう) | Xe cộ | Module AB20 |
| 会計 (かいけい) | Kế toán | Module AC10 |
| 売掛金 (うりかけきん) | Phải thu | Module AC20 |
| 買掛金 (かいかけきん) | Phải trả | Module AC30 |
| 資産 (しさん) | Tài sản | Module AC40 |
| 人事 (じんじ) | Nhân sự | Module HR10 |
| 給与 (きゅうよ) | Lương | Module HR20 |
| 勤怠 (きんたい) | Chấm công | Module HR30 |
| 顧客 (こきゃく) | Khách hàng | Module CA10 |
| 取引先 (とりひきさき) | Đối tác/NCC | Module IB10 |
| 購買 (こうばい) | Thu mua | Module PR10 |
| 販売 (はんばい) | Bán hàng | Module SA10 |
| 在庫 (ざいこ) | Tồn kho | Module AR30/ST10 |
| 製造 (せいぞう) | Sản xuất | Module AR60 |
| 品質 (ひんしつ) | Chất lượng | Module QC10 |
| 予算 (よさん) | Ngân sách | Module BG10 |

## Common DB Column Labels (DB項目名)

| Column name | Japanese label | Vietnamese | Data type hint |
|-------------|---------------|-----------|----------------|
| DEN_NO | 伝票番号 | Số chứng từ | VARCHAR, PK part |
| PSON_CD | 社員番号 | Mã NV | VARCHAR(10) |
| PSON_NM | 氏名 | Họ tên | NVARCHAR |
| BUSHO_CD | 部門コード | Mã phòng ban | VARCHAR |
| BUSHO_NM | 部門名 | Tên phòng ban | NVARCHAR |
| APL_DAY | 申請日 | Ngày đăng ký | VARCHAR(8) YYYYMMDD |
| APR_DAY | 承認日 | Ngày duyệt | VARCHAR(8) |
| START_DAY | 開始日 | Ngày bắt đầu | VARCHAR(8) |
| END_DAY | 終了日 | Ngày kết thúc | VARCHAR(8) |
| STATUS | 状態 | Trạng thái | VARCHAR(2) |
| KBN | 区分 | Phân loại | VARCHAR(2) |
| FLG_DELETE | 削除フラグ | Cờ xóa | CHAR(1): 0=active, 1=deleted |
| INS_DAY | 登録日 | Ngày tạo | VARCHAR(8) |
| INS_PSON | 登録者 | Người tạo | VARCHAR(10) |
| UPD_DAY | 更新日 | Ngày sửa | VARCHAR(8) |
| UPD_PSON | 更新者 | Người sửa | VARCHAR(10) |
| KINGAKU | 金額 | Số tiền | DECIMAL |
| BIKO | 備考 | Ghi chú | NVARCHAR |
| SEQ_NO | 連番 | Số thứ tự | INT |
| NENDO | 年度 | Năm tài chính | VARCHAR(4) |

## UI Button/Action Labels (ボタン名)

| Japanese | Vietnamese | Typical event |
|----------|-----------|---------------|
| 検索 | Tìm kiếm | XX00 |
| 登録 | Đăng ký | XX01 |
| 更新 | Cập nhật | XX03 |
| 削除 | Xóa | XX04 |
| キャンセル | Hủy | XX05 |
| CSV出力 | Xuất CSV | XX06 |
| 承認 | Duyệt | XX07 |
| 却下 | Từ chối | XX07 |
| 戻る | Quay lại | (navigation) |
| 新規 | Tạo mới | (navigation to form) |
| 印刷 | In | XX06 |
| コピー | Sao chép | XX10+ |

## Status Code Patterns (ステータス)

| Code | Japanese | Vietnamese | Common usage |
|------|----------|-----------|--------------|
| 00 | 未申請 | Chưa gửi | Draft |
| 10 | 申請中 | Đang chờ duyệt | Pending |
| 20 | 承認済 | Đã duyệt | Approved |
| 30 | 却下 | Bị từ chối | Rejected |
| 40 | 取消 | Đã hủy | Cancelled |
| 50 | 完了 | Hoàn thành | Completed |
| 90 | 差戻 | Trả lại | Returned |

## MstServlet Field Labels (設定項目)

| XML tag | Japanese meaning | Vietnamese |
|---------|-----------------|-----------|
| LABEL | 画面名称 | Tên màn hình |
| AUTHENTICATION | 認証設定 | Cài đặt xác thực |
| PERMISSION | 参照権限 | Quyền xem |
| EDIT_PERMISSION | 編集権限 | Quyền sửa |
| FILE_TYPE | ファイル種別 | Loại file output |
| TIMEOUT | タイムアウト | Thời gian chờ |
