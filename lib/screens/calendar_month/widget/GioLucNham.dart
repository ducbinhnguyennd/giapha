import 'package:flutter/material.dart';
import 'package:giapha/model/Data/DataLucNham.dart';
import 'package:giapha/model/ReadData/ModelLucNham.dart';

class GioLucNham extends StatelessWidget {
  const GioLucNham(
      {super.key,
      required this.text,
      required this.text1,
      required this.text2,
      required this.text3,
      required this.text4,
      required this.text5});

  final String text;
  final String text1;
  final String text2;
  final String text3;
  final String text4;
  final String text5;

  String getTextAfterSpace(String t) {
    String words = t.split(" ")[0];
    String words1 = t.split(" ")[1];
    return '$words $words1';
  }

  @override
  Widget build(BuildContext context) {
    //print(getTextAfterSpace(text));
    List<ItemModelLucNham> list = itemListLucNham
        .where((element) =>

            // ignore: unrelated_type_equality_checks
            element.check == getTextAfterSpace(text))
        .toList();
    // print('tan vlog1: ${getTextAfterSpace(text)}');
    List<ItemModelLucNham> list1 = itemListLucNham
        .where((element) =>
            // ignore: unrelated_type_equality_checks
            element.check == getTextAfterSpace(text1))
        .toList();
    List<ItemModelLucNham> list2 = itemListLucNham
        .where((element) =>
            // ignore: unrelated_type_equality_checks
            element.check == getTextAfterSpace(text2))
        .toList();
    List<ItemModelLucNham> list3 = itemListLucNham
        .where((element) =>
            // ignore: unrelated_type_equality_checks
            element.check == getTextAfterSpace(text3))
        .toList();
    List<ItemModelLucNham> list4 = itemListLucNham
        .where((element) =>
            // ignore: unrelated_type_equality_checks
            element.check == getTextAfterSpace(text4))
        .toList();
    List<ItemModelLucNham> list5 = itemListLucNham
        .where((element) =>
            // ignore: unrelated_type_equality_checks
            element.check == getTextAfterSpace(text5))
        .toList();
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: list.length,
              itemBuilder: (context, index) {
                return Text(
                  list[index].noidung,
                  style: const TextStyle(fontSize: 16),
                );
              },
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text1,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: list1.length,
              itemBuilder: (context, index) {
                return Text(
                  list1[index].noidung,
                  style: const TextStyle(fontSize: 16),
                );
              },
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text2,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: list2.length,
              itemBuilder: (context, index) {
                return Text(
                  list2[index].noidung,
                  style: const TextStyle(fontSize: 16),
                );
              },
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text3,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: list3.length,
              itemBuilder: (context, index) {
                return Text(
                  list3[index].noidung,
                  style: const TextStyle(fontSize: 16),
                );
              },
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text4,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: list4.length,
              itemBuilder: (context, index) {
                return Text(
                  list4[index].noidung,
                  style: const TextStyle(fontSize: 16),
                );
              },
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text5,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: list5.length,
              itemBuilder: (context, index) {
                return Text(
                  list5[index].noidung,
                  style: const TextStyle(fontSize: 16),
                );
              },
            ),
          ],
        ),
      ]),
    );
  }
}
