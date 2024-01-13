// import 'package:flutter/cupertino.dart';

// class CheckTruc extends StatelessWidget {
//   const CheckTruc({super.key, required this.nameChi});

//   final String nameChi;
//   String test() {
//     if (nameChi == 'Thân') {
//       return 'Mãn';
//     } else if (nameChi == 'Dậu') {
//       return 'Bình';
//     } else if (nameChi == 'Tuất') {
//       return 'Định';
//     } else if (nameChi == 'Hợi') {
//       return 'Chấp';
//     } else if (nameChi == 'Tý') {
//       return 'Phá';
//     } else if (nameChi == 'Sửu') {
//       return 'Nguy';
//     } else if (nameChi == 'Dần') {
//       return 'Thành';
//     } else if (nameChi == 'Mão') {
//       return 'Thâu';
//     } else if (nameChi == 'Thìn') {
//       return 'Khai';
//     } else if (nameChi == 'Tỵ') {
//       return 'Bế';
//     } else if (nameChi == 'Ngọ') {
//       return 'Kiến';
//     } else {
//       return 'Trừ';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

String getTruc(int month, String chi) {
  List<String> trucs = [
    'Kiến',
    'Trừ',
    'Mãn',
    'Bình',
    'Định',
    'Chấp',
    'Phá',
    'Nguy',
    'Thành',
    'Thâu',
    'Khai',
    'Bế'
  ];

  List<String> chis = [
    'Dần',
    'Mão',
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
  ];

  int chiIndex = chis.indexOf(chi);
  int startTrucIndex = (month - 1) % 12;
  int currentTrucIndex = (chiIndex - startTrucIndex + 12) % 12;

  return trucs[currentTrucIndex];
}
