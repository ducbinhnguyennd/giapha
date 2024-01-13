import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:giapha/model/Data/DataVanKhan.dart';
import 'package:giapha/model/ReadData/ModelVanKhan.dart';
import 'package:giapha/screens/services_screen/vankhan/chitiet.dart';

class SeachVanKhan extends StatefulWidget {
  const SeachVanKhan({super.key});

  @override
  State<SeachVanKhan> createState() => _SeachVanKhanState();
}

class _SeachVanKhanState extends State<SeachVanKhan> {
  final List<ItemModel> _items = itemList;
  List<ItemModel> _foundUsers = [];

  String removeAccents(String input) {
    var str = input.toLowerCase();
    str = str.replaceAll(RegExp(r'[àáạảãâầấậẩẫăằắặẳẵ]'), 'a');
    str = str.replaceAll(RegExp(r'[èéẹẻẽêềếệểễ]'), 'e');
    str = str.replaceAll(RegExp(r'[ìíịỉĩ]'), 'i');
    str = str.replaceAll(RegExp(r'[òóọỏõôồốộổỗơờớợởỡ]'), 'o');
    str = str.replaceAll(RegExp(r'[ùúụủũưừứựửữ]'), 'u');
    str = str.replaceAll(RegExp(r'[ỳýỵỷỹ]'), 'y');
    str = str.replaceAll(RegExp(r'[đ]'), 'd');
    return str;
  }

  void _runFilter(String query) {
    List<ItemModel> results = [];
    if (query.isEmpty) {
    } else {
      results = _items.where((storyName) {
        return removeAccents(storyName.ten.toLowerCase())
            .contains(removeAccents(query.toLowerCase()));
      }).toList();
    }

    setState(() {
      _foundUsers = results.cast<ItemModel>();
    });
  }

  Widget listChiTiet(
      String ten, String gioithieu, String samle, String vankhan) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChiTiet(
                      ten: ten,
                      gioithieu: gioithieu,
                      samle: samle,
                      vankhan: vankhan,
                    )));
      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color(0xffFBBA95),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.black),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.black),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(ten),
                        Text(
                          gioithieu,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffFBBA95),
        automaticallyImplyLeading: false,
        title: const Text(
          'VĂN KHẤN',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_outlined,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/backgroud.jpg'),
              fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) => _runFilter(value),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 15),
                  // hintText: "Tìm truyện",
                  suffixIcon: const Icon(Icons.search),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(),
                  ),
                ),
              ),
            ),
            Expanded(
                child: _foundUsers.isNotEmpty
                    ? ListView.builder(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        itemCount: _foundUsers.length,
                        itemBuilder: (context, index) {
                          return listChiTiet(
                            _foundUsers[index].ten,
                            _foundUsers[index].gioithieu,
                            _foundUsers[index].samle,
                            _foundUsers[index].vankhan,
                          );
                        },
                      )
                    : const Text(
                        'Không thấy kết quả',
                        style: TextStyle(fontSize: 20),
                      )),
          ],
        ),
      ),
    );
  }
}
