---
title: Danh sách module
---

## Danh sách module

| Module | Mô tả |
|--------|-------|
| AB10 | 出張 (Công tác) |
| AB20 | 車両 (Xe cộ) |
| AC10 | 会計 (Kế toán) |
| AC20 | 売掛金 (Khoản phải thu) |
| AC30 | 買掛金 (Khoản phải trả) |
| AC40 | 資産 (Tài sản) |
| AC50 | 資金 (Vốn) |
| AC60 | 固定資産 (Tài sản cố định) |
| AC70 | グループ会計 (Kế toán tập đoàn) |
| AG10 | 工事進行 (Dự án thi công) |
| AR10 | 売上 (Doanh thu) |
| AR20 | 仕入 (Mua hàng) |
| AR30 | 在庫 (Tồn kho) |
| AR40 | 発注 (Đặt hàng) |
| AR50 | 外注 (Gia công ngoài) |
| AR60 | 製造 (Sản xuất) |
| AR70 | 原価計算 (Tính giá thành) |
| AR80 | 設備 (Thiết bị) |
| AR90 | 販売管理 (Quản lý bán hàng) |
| BA10 | 申請承認 (Duyệt/Phê duyệt) |
| BG10 | 予算 (Ngân sách) |
| CA10 | 顧客 (Khách hàng) |
| CO10 | 共通 (Chung/Hệ thống) |
| DE10 | 納期 (Giao hàng) |
| EC10 | 電子取引 (Giao dịch điện tử) |
| EG10 | 環境 (Môi trường) |
| FA10 | 設備管理 (Quản lý thiết bị) |
| HR10 | 人事 (Nhân sự) |
| HR20 | 給与 (Lương) |
| HR30 | 勤怠 (Chấm công) |
| HR40 | 福利厚生 (Phúc lợi) |
| HR50 | 人材育成 (Đào tạo) |
| HR60 | 採用 (Tuyển dụng) |
| HR70 | 労務 (Quan hệ lao động) |
| HR80 | 健康 (Sức khỏe) |
| HR90 | 退職 (Nghỉ việc) |
| IB10 | 取引先 (Đối tác) |
| IT10 | 情報システム (Hệ thống thông tin) |
| MC10 | 経営管理 (Quản lý điều hành) |
| MS10 | 販売計画 (Kế hoạch bán hàng) |
| OA10 | オフィス (Văn phòng) |
| PD10 | 生産管理 (Quản lý sản xuất) |
| PR10 | 購買 (Thu mua) |
| QC10 | 品質 (Chất lượng) |
| SA10 | 販売 (Bán hàng) |
| SR10 | サービス (Dịch vụ) |
| ST10 | 在庫管理 (Quản lý tồn kho) |
| TR10 | 貿易 (Thương mại) |
| XX10 | サンプル (Mẫu) |

### Cách xác định mô tả module

```bash
grep -r '<ID_FUNCTION>menu\.AB10' dev/master/yh/yhFramework/master/MstMenu.xml | head -5
```
