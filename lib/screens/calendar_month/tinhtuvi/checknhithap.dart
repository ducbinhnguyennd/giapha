String getLunarMansion(DateTime date) {
  List<String> lunarMansions = [
    'Giác',
    'Cang',
    'Đê',
    'Phòng',
    'Tâm',
    'Vĩ',
    'Cơ',
    'Đẩu',
    'Ngưu',
    'Nữ',
    'Hư',
    'Nguy',
    'Thất',
    'Bích',
    'Khuê',
    'Lâu',
    'Vị',
    'Mão',
    'Tất',
    'Chủy',
    'Sâm',
    'Tỉnh',
    'Quỷ',
    'Liễu',
    'Tinh',
    'Trương',
    'Dực',
    'Chẩn',
  ];

  // Ngày bắt đầu của chu kỳ Nhị Thập Bát Tú
  DateTime startDay = DateTime(1995, 1, 1);

  // Số ngày trong chu kỳ Nhị Thập Bát Tú
  int lunarCycleDays = 365;

  // Kiểm tra năm nhuận
  if (isLeapYear(date.year)) {
    lunarCycleDays += 2; // Thêm 2 ngày nếu là năm nhuận
  }

  // Số ngày từ ngày bắt đầu chu kỳ đến ngày được truyền vào
  int diffDays = date.difference(startDay).inDays;

  // Tính ngày tương ứng trong chu kỳ Nhị Thập Bát Tú
  int lunarMansionIndex = (diffDays % lunarCycleDays) % 28;

  return lunarMansions[lunarMansionIndex];
}

bool isLeapYear(int year) {
  return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
}
