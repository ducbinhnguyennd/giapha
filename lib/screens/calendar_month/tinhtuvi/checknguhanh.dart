String getNguHanhCheck(String nameCan, String nameChi) {
  if (nameChi == 'Thân' ||
      nameChi == 'Dậu' ||
      nameCan == 'Canh' ||
      nameCan == 'Tân') {
    return 'Kim';
  } else if (nameChi == 'Hợi' ||
      nameChi == 'Tý' ||
      nameCan == 'Nhâm' ||
      nameCan == 'Quý') {
    return 'Thủy';
  } else if (nameChi == 'Dần' ||
      nameChi == 'Mão' ||
      nameCan == 'Giáp' ||
      nameCan == 'Ất') {
    return 'Mộc';
  } else if (nameChi == 'Tỵ' ||
      nameChi == 'Ngọ' ||
      nameCan == 'Bính' ||
      nameCan == 'Đinh') {
    return 'Hỏa';
  } else {
    return 'Thổ';
  }
}
