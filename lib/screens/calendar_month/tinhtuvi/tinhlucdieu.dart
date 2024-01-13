String getNgayLucDieu(int month, int day) {
  List<String> ngayLucDieuList = [
    'Đại An',
    'Lưu Liên',
    'Tộc Hỷ',
    'Xích Khẩu',
    'Tiểu Cát',
    'Không Vọng'
  ];

  int startingNgayLucDieuIndex = 0; // Đại An là ngày mùng 1

  // Chỉnh startingNgayLucDieuIndex tương ứng với tháng
  switch (month) {
    case 1:
    case 7:
      startingNgayLucDieuIndex = 0; // Đại An
      break;
    case 2:
    case 8:
      startingNgayLucDieuIndex = 1; // Lưu Liên
      break;
    case 3:
    case 9:
      startingNgayLucDieuIndex = 2; // Tốc Hỷ
      break;
    case 4:
    case 10:
      startingNgayLucDieuIndex = 3; // Xích Khẩu
      break;
    case 5:
    case 11:
      startingNgayLucDieuIndex = 4; // Tiểu Cát
      break;
    case 6:
    case 12:
      startingNgayLucDieuIndex = 5; // Không Vong
      break;
  }

  int ngayLucDieuIndex = (startingNgayLucDieuIndex + (day - 1)) % 6;

  return ngayLucDieuList[ngayLucDieuIndex];
}
