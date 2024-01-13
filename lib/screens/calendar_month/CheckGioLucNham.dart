import 'package:flutter/material.dart';
import 'package:giapha/screens/calendar_month/widget/GioLucNham.dart';

class CheckLucNham extends StatelessWidget {
  const CheckLucNham({super.key, required this.lucnhamngay});

  final String lucnhamngay;
  @override
  Widget build(BuildContext context) {
    if (lucnhamngay == 'daian') {
      return GioLucNham(
        text: 'text_daian',
        text1: 'text1_daian',
        text2: 'text2_daian',
        text3: 'text3_daian',
        text4: 'text4_daian',
        text5: 'text5_daian',
      );
    } else if (lucnhamngay == 'luulien') {
      return GioLucNham(
        text: 'text_luulien',
        text1: 'text1_luulien',
        text2: 'text2_luulien',
        text3: 'text3_luulien',
        text4: 'text4_luulien',
        text5: 'text5_luulien',
      );
    } else if (lucnhamngay == 'tochuy') {
      return GioLucNham(
        text: 'text_tochy',
        text1: 'text1_tochy',
        text2: 'text2_tochy',
        text3: 'text3_tochy',
        text4: 'text4_tochy',
        text5: 'text5_tochy',
      );
    } else if (lucnhamngay == 'xichkhau') {
      return GioLucNham(
        text: 'text_xichkhau',
        text1: 'text1_xichkhau',
        text2: 'text2_xichkhau',
        text3: 'text3_xichkhau',
        text4: 'text4_xichkhau',
        text5: 'text5_xichkhau',
      );
    } else if (lucnhamngay == 'tieucat') {
      return GioLucNham(
        text: 'text_tieucat',
        text1: 'text1_tieucat',
        text2: 'text2_tieucat',
        text3: 'text3_tieucat',
        text4: 'text4_tieucat',
        text5: 'text5_tieucat',
      );
    } else {
      return GioLucNham(
        text: 'text',
        text1: 'text1',
        text2: 'text2',
        text3: 'text3',
        text4: 'text4',
        text5: 'text5',
      );
    }
  }
}
