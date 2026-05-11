# Cấu trúc thư mục hệ thống

```
project-root/
│
├── dev/
   ├── java/src/tvmk/tscrum/     ← 47 modules
   │   ├── AB10/                 ← Công tác (32 screens)
   │   │   ├── AB1010.java
   │   │   ├── AB1011.java
   │   │   ├── AB10SB.java       ← helper chung
   │   ├── CA30/                 ← Đơn hàng (18 screens)
   │   ├── DA10/                 ← Giao hàng (25 screens)
   │   ├── EA10/                 ← Doanh thu (16 screens)
   │   └── ...
   │
   ├── template/tvmk/tscrum/     ← Templates cho từng màn hình
   │   ├── AB10/AB1011/
   │   │   ├── AB1011.html
   │   │   ├── AB101101.sql
   │   │   └── listRecord.html
   │   └── ...
   │
   └── master/
       ├── yh/yhFramework/master/ ← Framework config
       │   ├── MstServlet.xml     ← Màn hình ↔ quyền
       │   ├── MstWebFlow.xml     ← Luồng điều hướng
       │   ├── MstMenu.xml        ← Cấu trúc menu
       │   └── ...
       └── tvmk/tscrum/{MODULE}/  ← Master data module
           └── Mst*.xml           ← Dropdown lists
```

## Quy ước đặt tên

| Thành phần | Định dạng | Ví dụ |
|-----------|-----------|-------|
| Screen ID | `{MODULE}{NN}` | AB1011, CA3020 |
| Module | `{AA}{NN}` | AB10, CA30 |
| Func ID (XML) | `{MODULE}.{SCREEN_ID}` | AB10.AB1011 |
| URL path | `/{MODULE}/{SCREEN_ID}` | /AB10/AB1011 |
| Java class | `{SCREEN_ID}.java` | AB1011.java |
| Init event | `{SCREEN_ID}00` | AB101100 |
| Sort event | `{SCREEN_ID}02` | AB101102 |
| SQL file | `{SCREEN_ID}NN.sql` | AB101101.sql |
