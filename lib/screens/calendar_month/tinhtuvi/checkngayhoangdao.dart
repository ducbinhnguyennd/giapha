String getNgayHoangDao(int thang, String nameChi) {
  if ((thang == 1 || thang == 7) &&
      (nameChi == 'Tý' ||
          nameChi == 'Tỵ' ||
          nameChi == 'Mùi' ||
          nameChi == 'Sửu')) {
    return 'Hoàng Đạo';
  } else if ((thang == 2 || thang == 8) &&
      (nameChi == 'Dậu' ||
          nameChi == 'Mão' ||
          nameChi == 'Mùi' ||
          nameChi == 'Dần')) {
    return 'Hoàng Đạo';
  } else if ((thang == 3 || thang == 9) &&
      (nameChi == 'Dậu' ||
          nameChi == 'Hợi' ||
          nameChi == 'Thìn' ||
          nameChi == 'Tỵ')) {
    return 'Hoàng Đạo';
  } else if ((thang == 4 || thang == 10) &&
      (nameChi == 'Sửu' ||
          nameChi == 'Mùi' ||
          nameChi == 'Ngọ' ||
          nameChi == 'Dậu')) {
    return 'Hoàng Đạo';
  } else if ((thang == 5 || thang == 11) &&
      (nameChi == 'Thân' ||
          nameChi == 'Mão' ||
          nameChi == 'Dậu' ||
          nameChi == 'Sửu')) {
    return 'Hoàng Đạo';
  } else if ((thang == 6 || thang == 12) &&
      (nameChi == 'Tuất' ||
          nameChi == 'Hợi' ||
          nameChi == 'Mão' ||
          nameChi == 'Tỵ')) {
    return 'Hoàng Đạo';
  } else if ((thang == 1 || thang == 7) &&
      (nameChi == 'Ngọ' ||
          nameChi == 'Mão' ||
          nameChi == 'Hợi' ||
          nameChi == 'Dậu')) {
    return 'Hắc Đạo';
  } else if ((thang == 2 || thang == 8) &&
      (nameChi == 'Thân' ||
          nameChi == 'Tỵ' ||
          nameChi == 'Sửu' ||
          nameChi == 'Hợi')) {
    return 'Hắc Đạo';
  } else if ((thang == 3 || thang == 9) &&
      (nameChi == 'Tuất' || nameChi == 'Mùi' || nameChi == 'Sửu')) {
    return 'Hắc Đạo';
  } else if ((thang == 4 || thang == 10) &&
      (nameChi == 'Tý' || nameChi == 'Tỵ' || nameChi == 'Mão')) {
    return 'Hắc Đạo';
  } else if ((thang == 5 || thang == 11) &&
      (nameChi == 'Dần' ||
          nameChi == 'Hợi' ||
          nameChi == 'Mùi' ||
          nameChi == 'Tỵ')) {
    return 'Hắc Đạo';
  } else if ((thang == 6 || thang == 12) &&
      (nameChi == 'Thìn' ||
          nameChi == 'Sửu' ||
          nameChi == 'Dậu' ||
          nameChi == 'Mùi')) {
    return 'Hắc Đạo';
  } else {
    return 'Bình Thường';
  }
}
