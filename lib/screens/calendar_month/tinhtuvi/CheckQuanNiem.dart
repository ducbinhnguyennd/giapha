String getQuanNIem(int ngay) {
  if (ngay == 5 || ngay == 14 || ngay == 23) {
    return 'Nguyệt Kỵ';
  } else if (ngay == 3 ||
      ngay == 7 ||
      ngay == 13 ||
      ngay == 18 ||
      ngay == 22 ||
      ngay == 27) {
    return 'Tam Nương';
  } else {
    return 'Ngày Thường';
  }
}
