# Dungeon01 cho Windows

Mã nguồn lấy từ nhánh `origin/dungeon01`, commit `1e1ba50`.

## Chạy game

Giải nén `Dungeon01-Windows.zip`, mở thư mục `Dungeon01`, nhấp đúp
`Dungeon01.exe`. Giữ nguyên thư mục `app` và `runtime` cạnh EXE.
Không cần cài Java. Đây là bản portable cho Windows x64.

Menu dùng W/S và Enter. Trong game: WASD di chuyển, Enter tương tác/tấn công,
F bắn, C xem nhân vật, Esc mở tùy chọn.

## Tài nguyên thiếu trong repo gốc

Nhánh gốc thiếu `stairdown.png`, `stairup.png`, `earth01.png`, `000.png`,
`maps/dungeon01.txt`, `sound/Dungeon.wav`, `sound/Merchant.wav`.
Thiếu ảnh làm game lỗi ngay khi khởi động.

Bản này dùng ảnh cầu làm dấu cầu thang, ảnh floor01 làm nền, wall làm tường,
và nhạc BlueBoyAdventure thay cho hai bài nhạc thiếu. Bản đồ dungeon thay thế
là phòng trống 50x50 có tường bao và lối ra tại (9, 41). Đây chỉ là tài nguyên
tạm để chạy được game, không phải dungeon thiết kế gốc. Cần thay lại các file
này khi có tài nguyên gốc.

## Đóng gói lại

Cài JDK 21 hoặc mới hơn, thêm thư mục bin vào PATH, chạy:

```powershell
.\build-windows.ps1
```

Script biên dịch mã Java 17, nhúng toàn bộ `res`, tạo EXE cùng Java runtime
và ZIP trong `dist/<thời điểm build>/`. Không cần Maven, Gradle hay IDE.
