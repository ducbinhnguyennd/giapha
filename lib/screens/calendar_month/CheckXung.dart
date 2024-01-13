// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';
import 'package:giapha/screens/calendar_month/widget/TuoiXung.dart';

class CheckXung extends StatelessWidget {
  const CheckXung({super.key, required this.nameDay});

  final String nameDay;

  @override
  Widget build(BuildContext context) {
    if (nameDay == 'Giáp Tý') {
      return const TuoiXung(
        a1: 'Mậu Ngọ',
        a2: 'Nhâm Ngọ',
        a3: 'Canh Dần',
        a4: 'Canh Thân',
      );
    } else if (nameDay == 'Ât Sửu') {
      return const TuoiXung(
        a1: 'Kỷ Mùi',
        a2: 'Quý Mùi',
        a3: 'Tân Mão',
        a4: 'Tân Dậu',
      );
    } else if (nameDay == 'Bính Dần') {
      return const TuoiXung(
        a1: 'Nhâm Thân',
        a2: 'Giáp Thân',
        a3: 'Nhâm Tuất',
        a4: 'Nhâm Thìn',
      );
    } else if (nameDay == 'Đinh Mão') {
      return const TuoiXung(
        a1: 'Ất Dậu',
        a2: 'Quý Dậu',
        a3: 'Quý Tỵ',
        a4: 'Quý Hợi',
      );
    } else if (nameDay == 'Mậu Thìn') {
      return const TuoiXung(
        a1: '',
        a2: 'Bính Tuất',
        a3: 'Canh Tuất',
        a4: '',
      );
    } else if (nameDay == 'Canh Dần') {
      return const TuoiXung(
        a1: 'Nhâm Thân',
        a2: 'Giáp Tý',
        a3: 'Mậu Thân',
        a4: 'Giáp Ngọ',
      );
    } else if (nameDay == 'Đinh Tỵ') {
      return const TuoiXung(
        a1: 'Kỷ Hợi',
        a2: 'Quý Hợi',
        a3: 'Quý Sửu',
        a4: 'Quý Mùi',
      );
    } else if (nameDay == 'Kỷ Tỵ') {
      return const TuoiXung(
        a1: '',
        a2: 'Đinh Hợi',
        a3: 'Tân Hợi',
        a4: '',
      );
    } else if (nameDay == 'Canh Ngọ') {
      return const TuoiXung(
        a1: 'Nhâm Tý',
        a2: 'Bính Tý',
        a3: 'Giáp Thân',
        a4: 'Giáp Dần',
      );
    } else if (nameDay == 'Tân Mùi') {
      return const TuoiXung(
        a1: 'Đinh Sửu',
        a2: 'Ất Dậu',
        a3: 'Quý Sửu',
        a4: 'Ất Mão',
      );
    } else if (nameDay == 'Nhâm Thân') {
      return const TuoiXung(
        a1: 'Bính Dần',
        a2: 'Canh Dần',
        a3: 'Bính Thân',
        a4: '',
      );
    } else if (nameDay == 'Quý Dậu') {
      return const TuoiXung(
        a1: 'Đinh Mão',
        a2: 'Tân Mão',
        a3: 'Đinh Dậu',
        a4: '',
      );
    } else if (nameDay == 'Giáp Tuất') {
      return const TuoiXung(
        a1: 'Nhâm Thìn',
        a2: 'Canh Thìn',
        a3: 'Canh Tuất',
        a4: '',
      );
    } else if (nameDay == 'Ất Hợi') {
      return const TuoiXung(
        a1: 'Quý Tỵ',
        a2: 'Tân Hợi',
        a3: 'Tân Tỵ',
        a4: '',
      );
    } else if (nameDay == 'Bính Tý') {
      return const TuoiXung(
        a1: '',
        a2: 'Canh Ngọ',
        a3: 'Mậu Ngọ',
        a4: '',
      );
    } else if (nameDay == 'Đinh Sửu') {
      return const TuoiXung(
        a1: '',
        a2: 'Kỷ Mùi',
        a3: 'Tân Mùi',
        a4: '',
      );
    } else if (nameDay == 'Mậu Dần') {
      return const TuoiXung(
        a1: '',
        a2: 'Canh Thân',
        a3: 'Giáp Thân',
        a4: '',
      );
    } else if (nameDay == 'Kỷ Mão') {
      return const TuoiXung(
        a1: '',
        a2: 'Tân Dậu',
        a3: 'Ất Dậu',
        a4: '',
      );
    } else if (nameDay == 'Canh Thìn') {
      return const TuoiXung(
        a1: 'Giáp Tuất',
        a2: 'Mậu Tuất',
        a3: 'Giáp Thìn',
        a4: '',
      );
    } else if (nameDay == 'Tân Tỵ') {
      return const TuoiXung(
        a1: 'Kỷ Hợi',
        a2: 'Ất Hợi',
        a3: 'Ất Tỵ',
        a4: '',
      );
    } else if (nameDay == 'Nhâm Ngọ') {
      return const TuoiXung(
        a1: 'Giáp Tý',
        a2: 'Canh Tý',
        a3: 'BÍnh Tuất',
        a4: 'Bính Thìn',
      );
    } else if (nameDay == 'Quý Mùi') {
      return const TuoiXung(
        a1: 'Ất Sửu',
        a2: 'Tân Sửu',
        a3: 'Đinh Hợi',
        a4: 'Đinh Tỵ',
      );
    } else if (nameDay == 'Giáp Thân') {
      return const TuoiXung(
        a1: 'Mậu Dần',
        a2: 'Bính Dần ',
        a3: 'Canh Ngọ',
        a4: 'Canh Tỵ',
      );
    } else if (nameDay == 'Ất Dậu') {
      return const TuoiXung(
        a1: 'Kỷ Mão',
        a2: 'Đinh Mão',
        a3: 'Tân Sửu',
        a4: 'Tân Mùi',
      );
    } else if (nameDay == 'Bính Tuất') {
      return const TuoiXung(
        a1: 'Mậu Thìn',
        a2: 'Nhâm Thìn',
        a3: 'Nhâm Ngọ',
        a4: 'Nhâm Tý',
      );
    } else if (nameDay == 'Đinh Hợi') {
      return const TuoiXung(
        a1: 'Kỷ Tỵ',
        a2: 'Quý Mùi',
        a3: 'Quý Sửu',
        a4: 'Quý Tỵ',
      );
    } else if (nameDay == 'Mậu Tý') {
      return const TuoiXung(
        a1: '',
        a2: 'Bính Ngọ',
        a3: 'Giáp Ngọ',
        a4: '',
      );
    } else if (nameDay == 'Kỷ Sửu') {
      return const TuoiXung(
        a1: '',
        a2: 'Đinh Mùi',
        a3: 'Ất Mùi',
        a4: '',
      );
    } else if (nameDay == 'Tân Mão') {
      return const TuoiXung(
        a1: 'Kỷ Dậu',
        a2: 'Quý Dậu',
        a3: 'Ất Sửu',
        a4: 'Ất Mùi',
      );
    } else if (nameDay == 'Nhâm Thìn') {
      return const TuoiXung(
        a1: 'Bính Tuất',
        a2: 'GIáp Tuất',
        a3: 'Bính Dần',
        a4: '',
      );
    } else if (nameDay == 'Quý Tỵ') {
      return const TuoiXung(
        a1: 'Đinh Hợi',
        a2: 'Ất Hợi',
        a3: 'Đinh Mão',
        a4: '',
      );
    } else if (nameDay == 'Giáp Ngọ') {
      return const TuoiXung(
        a1: 'Mậu Tý',
        a2: 'Nhâm Tý',
        a3: 'Canh Dần',
        a4: 'Nhâm Dần',
      );
    } else if (nameDay == 'Ất Mùi') {
      return const TuoiXung(
        a1: 'Kỷ Sửu',
        a2: 'Quý Sửu',
        a3: 'Tân Mão',
        a4: 'Tân Dậu',
      );
    } else if (nameDay == 'Bính Thân') {
      return const TuoiXung(
        a1: 'Giáp Dần',
        a2: 'Nhâm Thân',
        a3: 'Nhâm Tuất',
        a4: 'Nhâm Thìn',
      );
    } else if (nameDay == 'Đinh Dậu') {
      return const TuoiXung(
        a1: 'Ất Mão',
        a2: 'Quý Mão',
        a3: 'Quý Tỵ',
        a4: 'Quý Hợi',
      );
    } else if (nameDay == 'Mậu Tuất') {
      return const TuoiXung(
        a1: '',
        a2: 'Canh Thìn',
        a3: 'Bính Thìn',
        a4: '',
      );
    } else if (nameDay == 'Kỷ Hợi') {
      return const TuoiXung(
        a1: '',
        a2: 'Tân Tỵ',
        a3: 'Đinh Tỵ',
        a4: '',
      );
    } else if (nameDay == 'Canh Tý') {
      return const TuoiXung(
        a1: 'Nhâm Ngọ',
        a2: 'Bính Ngọ',
        a3: 'Giáp Thân',
        a4: 'GIáp Dần',
      );
    } else if (nameDay == 'Tân Sửu') {
      return const TuoiXung(
        a1: 'Quý Mùi',
        a2: 'Đinh Mùi',
        a3: 'Ất Mão',
        a4: 'Ất Dậu',
      );
    } else if (nameDay == 'Nhâm Dần') {
      return const TuoiXung(
        a1: 'Canh Thân',
        a2: 'Bính Thân',
        a3: 'Bính Dần',
        a4: '',
      );
    } else if (nameDay == 'Quý Mão') {
      return const TuoiXung(
        a1: 'Đinh Dậu',
        a2: 'Tân Dậu',
        a3: 'Đinh Mão',
        a4: '',
      );
    } else if (nameDay == 'Giáp Thìn') {
      return const TuoiXung(
        a1: 'Nhâm Tuất',
        a2: 'Canh Tuất',
        a3: 'Canh Thìn',
        a4: '',
      );
    } else if (nameDay == 'Ất Tỵ') {
      return const TuoiXung(
        a1: 'Quý Hợi',
        a2: 'Tân Hợi',
        a3: 'Tân Tỵ',
        a4: '',
      );
    } else if (nameDay == 'Bính Ngọ') {
      return const TuoiXung(
        a1: '',
        a2: 'Mậu Tý',
        a3: 'Canh Tý',
        a4: '',
      );
    } else if (nameDay == 'Đinh Mùi') {
      return const TuoiXung(
        a1: '',
        a2: 'Kỷ Sửu',
        a3: 'Tân Sửu',
        a4: '',
      );
    } else if (nameDay == 'Mậu Thân') {
      return const TuoiXung(
        a1: '',
        a2: 'Canh Dần',
        a3: 'Giáp Dần',
        a4: '',
      );
    } else if (nameDay == 'Kỷ Dậu') {
      return const TuoiXung(
        a1: '',
        a2: 'Tân Mão',
        a3: 'Ất Mão',
        a4: '',
      );
    } else if (nameDay == 'Canh Tuất') {
      return const TuoiXung(
        a1: 'Giáp Thìn',
        a2: 'Mậu Thìn',
        a3: 'Giáp Tuất',
        a4: '',
      );
    } else if (nameDay == 'Tân Hợi') {
      return const TuoiXung(
        a1: 'Ất Tỵ',
        a2: 'Kỷ Tỵ',
        a3: 'Ất Hợi',
        a4: '',
      );
    } else if (nameDay == 'Nhâm Tý') {
      return const TuoiXung(
        a1: 'Giáp Ngọ',
        a2: 'Canh Ngọ',
        a3: 'Bính Tuất',
        a4: 'Bính Thìn',
      );
    } else if (nameDay == 'Quý Sửu') {
      return const TuoiXung(
        a1: 'Ất Mùi',
        a2: 'Tân Mùi',
        a3: 'Đinh Hợi',
        a4: 'Đinh Tỵ',
      );
    } else if (nameDay == 'Giáp Dần') {
      return const TuoiXung(
        a1: 'Mậu Thân',
        a2: 'Bính Thân',
        a3: 'Canh Ngọ',
        a4: 'Canh Tý',
      );
    } else if (nameDay == 'Ất Mão') {
      return const TuoiXung(
        a1: 'Kỷ Dậu',
        a2: 'Đinh Dậu',
        a3: 'Tân Mùi',
        a4: 'Tân Sửu',
      );
    } else if (nameDay == 'Bính Thìn') {
      return const TuoiXung(
        a1: 'Mậu Tuất',
        a2: 'Nhâm Tuất',
        a3: 'Nhâm Ngọ',
        a4: 'Nhâm Tý',
      );
    } else if (nameDay == 'Mậu Ngọ') {
      return const TuoiXung(
        a1: '',
        a2: 'Bính Tý',
        a3: 'GIáp Tý',
        a4: '',
      );
    } else if (nameDay == 'Kỷ Mùi') {
      return const TuoiXung(
        a1: '',
        a2: 'Đinh Sửu',
        a3: 'Ất Sửu',
        a4: '',
      );
    } else if (nameDay == 'Canh Thân') {
      return const TuoiXung(
        a1: 'Nhâm Dần',
        a2: 'Mậu Dần',
        a3: 'Giáp Tý',
        a4: 'Giáp Ngọ',
      );
    } else if (nameDay == 'Tân Dậu') {
      return const TuoiXung(
        a1: 'Quý Mão',
        a2: 'Kỷ Mão',
        a3: 'Ất Sửu',
        a4: 'Ất Mùi',
      );
    } else if (nameDay == 'Nhâm Tuất') {
      return const TuoiXung(
        a1: 'Bính Thìn',
        a2: 'Giáp Thìn',
        a3: 'Bính Thân',
        a4: 'BÍnh Dần',
      );
    } else {
      return const TuoiXung(
        a1: 'Đinh Tỵ',
        a2: 'Ất Tỵ',
        a3: 'Đinh Mão',
        a4: 'Đinh Dậu',
      );
    }
  }
}
