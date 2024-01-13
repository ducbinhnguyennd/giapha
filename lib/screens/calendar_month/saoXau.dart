List<String> getBadStarsOfDay(String month, String day) {
  List<String> saoXau = [
    'Thiên Cương',
    'Thụ Tử',
    'Đại Hao',
    'Tiểu Hao',
    'Sát Chủ',
    'Thiên Hỏa',
    'Địa Hỏa',
    'Hỏa Tai',
    'Nguyệt Phá',
    'Băng Tiêu, Ngọa Giải',
    'Thổ Cấm',
    'Thổ Kỵ, Vãng Vong',
    'Cô Thần',
    'Quả Tú',
    'Trùng Tang',
    'Trùng Phục',
  ];

  List<List<String>> saoXauThang = [
    [
      'Tỵ',
      'Tý',
      'Mùi',
      'Dần',
      'Dậu',
      'Thìn',
      'Hợi',
      'Ngọ',
      'Sửu',
      'Thân',
      'Mão',
      'Tuất'
    ],
    [
      'Tuất',
      'Thìn',
      'Hợi',
      'Tỵ',
      'Tý',
      'Ngọ',
      'Sửu',
      'Mùi',
      'Dần',
      'Thân',
      'Mão',
      'Dậu'
    ],
    [
      'Ngọ',
      'Mùi',
      'Thân',
      'Dậu',
      'Tuất',
      'Hợi',
      'Tý',
      'Sửu',
      'Dần',
      'Mão',
      'Thìn',
      'Tỵ'
    ],
    [
      'Tỵ',
      'Ngọ',
      'Mùi',
      'Thân',
      'Dậu',
      'Tuất',
      'Hợi',
      'Tý',
      'Sửu',
      'Dần',
      'Mão',
      'Thìn'
    ],
    [
      'Tý',
      'Tỵ',
      'Mùi',
      'Mão',
      'Thân',
      'Tuất',
      'Sửu',
      'Hợi',
      'Ngọ',
      'Dậu',
      'Dần',
      'Thìn'
    ],
    [
      'Tý',
      'Mão',
      'Ngọ',
      'Dậu',
      'Tý',
      'Mão',
      'Ngọ',
      'Dậu',
      'Tý',
      'Mão',
      'Ngọ',
      'Dậu'
    ],
    [
      'Tuất',
      'Dậu',
      'Thân',
      'Mùi',
      'Ngọ',
      'Tỵ',
      'Thìn',
      'Mão',
      'Dần',
      'Sửu',
      'Tý',
      'Hợi'
    ],
    [
      'Sửu',
      'Mùi',
      'Dần',
      'Thân',
      'Mão',
      'Dậu',
      'Thìn',
      'Tuất',
      'Tỵ',
      'Hợi',
      'Tý',
      'Ngọ'
    ],
    [
      'Thân',
      'Tuất',
      'Tuất',
      'Hợi',
      'Sửu',
      'Sửu',
      'Dần',
      'Thìn',
      'Thìn',
      'Tỵ',
      'Mùi',
      'Mùi'
    ],
    [
      'Tỵ',
      'Tý',
      'Sửu',
      'Thân',
      'Mão',
      'Tuất',
      'Hợi',
      'Ngọ',
      'Mùi',
      'Dần',
      'Dậu',
      'Thìn'
    ],
    [
      'Hợi',
      'Hợi',
      'Hợi',
      'Dần',
      'Dần',
      'Dần',
      'Tỵ',
      'Tỵ',
      'Tỵ',
      'Thân',
      'Thân',
      'Thân'
    ],
    [
      'Dần',
      'Tỵ',
      'Thân',
      'Hợi',
      'Mão',
      'Ngọ',
      'Dậu',
      'Tý',
      'Thìn',
      'Mùi',
      'Tuất',
      'Sửu'
    ],
    [
      'Tuất',
      'Hợi',
      'Tý',
      'Sửu',
      'Dần',
      'Mão',
      'Thìn',
      'Tỵ',
      'Ngọ',
      'Mùi',
      'Thân',
      'Dậu'
    ],
    [
      'Thìn',
      'Tỵ',
      'Ngọ',
      'Mùi',
      'Thân',
      'Dậu',
      'Tuất',
      'Hợi',
      'Tý',
      'Sửu',
      'Dần',
      'Mão'
    ],
    [
      'Giáp',
      'ất',
      'Mậu',
      'Bính',
      'Đinh',
      'Kỷ',
      'Canh',
      'Tân',
      'Kỷ',
      'Nhâm',
      'Quý',
      'Mậu'
    ],
    [
      'Canh',
      'Tân',
      'Kỷ',
      'Nhâm',
      'Quý',
      'Mậu',
      'Giáp',
      'ất',
      'Kỷ',
      'Bính',
      'Đinh',
      'Mậu'
    ],
  ];

  int monthIndex = int.parse(month) - 1;
  int dayIndex = int.parse(day) - 1;

  List<String> result = [];

  String sao = saoXau[dayIndex];
  String ngayXau = saoXauThang[monthIndex][dayIndex];
  String saoXauInfo = 'Sao $sao chiếu vào ngày $ngayXau';
  result.add(saoXauInfo);

  return result;
}
