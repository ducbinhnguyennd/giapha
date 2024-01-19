import 'package:flutter/cupertino.dart';
import 'package:giapha/screens/calendar_month/widget/GioHoangDao.dart';

class CheckGioHoangDao extends StatelessWidget {
  const CheckGioHoangDao({super.key, required this.nameDay});

  final String nameDay;

  @override
  Widget build(BuildContext context) {
    if (nameDay == 'Tý' || nameDay == 'Ngọ') {
      return const GioHoangDao(
          text: 'Tý',
          text1: '11h-13h',
          text2: 'Sửu',
          text3: '15h-17h',
          text4: 'Mão',
          text5: '17h-19h',
          text6: '23h-1h',
          text7: 'Ngọ',
          text8: '1h-3h',
          text9: 'Thân',
          text10: '5h-7h',
          text11: 'Dậu');
    } else if (nameDay == 'Tỵ' || nameDay == 'Hợi') {
      return const GioHoangDao(
          text: 'Sửu',
          text1: '13h-15h',
          text2: 'Thìn',
          text3: '19h-21h',
          text4: 'Ngọ',
          text5: '21h-23h',
          text6: '1h-3h',
          text7: 'Mùi',
          text8: '7h-9h',
          text9: 'Tuất',
          text10: '11h-13h',
          text11: 'Hợi');
    } else if (nameDay == 'Thìn' || nameDay == 'Tuất') {
      return const GioHoangDao(
          text: 'Dần',
          text1: '15h-17h',
          text2: 'Thìn',
          text3: '17h-19h',
          text4: 'Tỵ',
          text5: '21h-23h',
          text6: '3h-5h',
          text7: 'Thân',
          text8: '7h-9h',
          text9: 'Dậu',
          text10: '9h-11h',
          text11: 'Hợi');
    } else if (nameDay == 'Mão' || nameDay == 'Dậu') {
      return const GioHoangDao(
          text: 'Tý',
          text1: '11h-13h',
          text2: 'Dần',
          text3: '13h-15h',
          text4: 'Mão',
          text5: '17h-19h',
          text6: '23h-1h',
          text7: 'Ngọ',
          text8: '3h-5h',
          text9: 'Mùi',
          text10: '5h-7h',
          text11: 'Dậu');
    } else if (nameDay == 'Dần' || nameDay == 'Thân') {
      return const GioHoangDao(
          text: 'Tý',
          text1: '9h-11h',
          text2: 'Sửu',
          text3: '13h-15h',
          text4: 'Thìn',
          text5: '19h-21h',
          text6: '23h-1h',
          text7: 'Tỵ',
          text8: '1h-3h',
          text9: 'Mùi',
          text10: '7h-9h',
          text11: 'Tuất');
    } else {
      return const GioHoangDao(
          text: 'Dần',
          text1: '15h-17h',
          text2: 'Mão',
          text3: '19h-21h',
          text4: 'Tỵ',
          text5: '21h-23h',
          text6: '3h-5h',
          text7: 'Thân',
          text8: '5h-7h',
          text9: 'Tuất',
          text10: '9h-11h',
          text11: 'Hợi');
    }
  }
}
