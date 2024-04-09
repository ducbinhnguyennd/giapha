import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:giapha/api_all/apitrangchu.dart';
import 'package:giapha/constant/asset_path_const.dart';
import 'package:giapha/constant/colors_const.dart';
import 'package:giapha/model/chitietUser_model.dart';

class ItemChiTiet extends StatefulWidget {
  const ItemChiTiet({super.key, required this.id, required this.avatar});

  final String id;
  final String avatar;

  @override
  State<ItemChiTiet> createState() => _ItemChiTietPhaState();
}

class _ItemChiTietPhaState extends State<ItemChiTiet> {
  late ApiChitietPerson apiChitietPerson;
  late ChitietPerson personData;
  @override
  void initState() {
    super.initState();
    apiChitietPerson = ApiChitietPerson();
    _fetchPersonData();
  }

  Future<void> _fetchPersonData() async {
    try {
      final fetchedData = await apiChitietPerson.fetchPersonData(widget.id);
      setState(() {
        personData = fetchedData;
      });
    } catch (e) {
      print('Error: $e');
      // Xử lý lỗi nếu cần
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              AssetsPathConst.bggiapha,
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  color: Colors.red,
                  boxShadow: const <BoxShadow>[
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.17),
                      blurRadius: 10,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(50),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: widget.avatar == ''
                      ? Center(
                          child: Text(
                            personData.name.substring(0, 1),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: ColorConst.colorBackgroundStory,
                            ),
                          ),
                        )
                      : Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: MemoryImage(base64Decode(widget.avatar)),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  personData.name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  personData.date,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
                Text(
                  personData.academicLevel,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
