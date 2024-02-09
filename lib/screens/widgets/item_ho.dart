import 'package:flutter/material.dart';
import 'package:giapha/constant/asset_path_const.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class ItemHo extends StatelessWidget {
  const ItemHo(
      {super.key,
      required this.tenho,
      required this.diachi,
      required this.members,
      required this.generation,
      required this.creater,
      required this.phone});
  final String tenho;
  final String diachi;
  final String members;
  final String generation;
  final String creater;
  final String phone;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.asset(
            AssetsPathConst.background,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          color: Colors.white.withOpacity(0.5),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text('Tên họ: $tenho'),
              Text('Địa chỉ: $diachi'),
              Text('Số thành viên: $members'),
              Text('$generation đời'),
              Text('Người tạo $creater'),
              Text('Số điện thoại: $phone'),
            ],
          ),
        ),
      ]),
    );
  }
}
