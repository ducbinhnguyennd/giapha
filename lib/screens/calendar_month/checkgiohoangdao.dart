import 'package:flutter/cupertino.dart';
import 'package:giapha/screens/calendar_month/widget/GioHoangDao.dart';

class CheckGioHoangDao extends StatelessWidget {
  const CheckGioHoangDao({super.key, required this.nameDay});

  final String nameDay;

  @override
  Widget build(BuildContext context) {
    if (nameDay == 'chuot' || nameDay == 'ngua') {
      return const GioHoangDao(
          text: 'chuot',
          text1: '11h-13h',
          text2: 'trau',
          text3: '15h-17h',
          text4: 'mao',
          text5: '17h-19h',
          text6: '23h-1h',
          text7: 'ngua',
          text8: '1h-3h',
          text9: 'khi',
          text10: '5h-7h',
          text11: 'ga');
    } else if (nameDay == 'ran' || nameDay == 'lon') {
      return const GioHoangDao(
          text: 'trau',
          text1: '13h-15h',
          text2: 'rong',
          text3: '19h-21h',
          text4: 'ngua',
          text5: '21h-23h',
          text6: '1h-3h',
          text7: 'de',
          text8: '7h-9h',
          text9: 'cho',
          text10: '11h-13h',
          text11: 'lon');
    } else if (nameDay == 'rong' || nameDay == 'cho') {
      return const GioHoangDao(
          text: 'cop',
          text1: '15h-17h',
          text2: 'rong',
          text3: '17h-19h',
          text4: 'Tỵ',
          text5: '21h-23h',
          text6: '3h-5h',
          text7: 'khi',
          text8: '7h-9h',
          text9: 'ga',
          text10: '9h-11h',
          text11: 'lon');
    } else if (nameDay == 'mao' || nameDay == 'ga') {
      return const GioHoangDao(
          text: 'chuot',
          text1: '11h-13h',
          text2: 'cop',
          text3: '13h-15h',
          text4: 'mao',
          text5: '17h-19h',
          text6: '23h-1h',
          text7: 'ngua',
          text8: '3h-5h',
          text9: 'de',
          text10: '5h-7h',
          text11: 'ga');
    } else if (nameDay == 'cop' || nameDay == 'khi') {
      return const GioHoangDao(
          text: 'chuot',
          text1: '9h-11h',
          text2: 'trau',
          text3: '13h-15h',
          text4: 'rong',
          text5: '19h-21h',
          text6: '23h-1h',
          text7: 'ran',
          text8: '1h-3h',
          text9: 'de',
          text10: '7h-9h',
          text11: 'cho');
    } else {
      return const GioHoangDao(
          text: 'cop',
          text1: '15h-17h',
          text2: 'mao',
          text3: '19h-21h',
          text4: 'ran',
          text5: '21h-23h',
          text6: '3h-5h',
          text7: 'khi',
          text8: '5h-7h',
          text9: 'cho',
          text10: '9h-11h',
          text11: 'lon');
    }
  }
}
