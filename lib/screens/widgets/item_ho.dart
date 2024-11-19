import 'package:flutter/material.dart';
import 'package:giapha/constant/asset_path_const.dart';
import 'package:giapha/constant/colors_const.dart';

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
            AssetsPathConst.khungdonghonew,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        // Container(
        //   color: Colors.white.withOpacity(0.5),
        // ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tenho,
                  style: TextStyle(color: ColorConst.colorTextVip),
                  //textAlign: TextAlign.center,
                  softWrap: true,
                  //style: TextStyle(color: ColorConst.colorPrimaryText),
                ),
                SizedBox(height: 10),
                Text('Địa chỉ: $diachi',
                    style: TextStyle(color: ColorConst.colorPrimaryText)),
                Text('Số thành viên: $members',
                    style: TextStyle(color: ColorConst.colorPrimaryText)),
                Text('$generation đời',
                    style: TextStyle(color: ColorConst.colorPrimaryText)),
                Text('Người tạo: $creater',
                    style: TextStyle(color: ColorConst.colorPrimaryText)),
                Text('Số điện thoại: $phone',
                    style: TextStyle(color: ColorConst.colorPrimaryText)),
              ],
            ),
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Column(
        //     children: [

        //       Text('Địa chỉ: $diachi'),
        //       Text('Số thành viên: $members'),
        //       Text('$generation đời'),
        //       Text('Người tạo $creater'),
        //       Text('Số điện thoại: $phone'),
        //     ],
        //   ),
        // ),
      ]),
    );
  }
}
