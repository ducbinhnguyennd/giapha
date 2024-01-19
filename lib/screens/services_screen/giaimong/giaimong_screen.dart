import 'package:flutter/material.dart';
import 'package:giapha/api_all/apitrangchu.dart';
import 'package:giapha/model/ReadData/ModelGiaiMong.dart';
import 'package:giapha/screens/services_screen/giaimong/chititetgiaimong.dart';

class GiaiMongScreen extends StatefulWidget {
  const GiaiMongScreen({super.key});

  @override
  State<GiaiMongScreen> createState() => _GiaiMongScreenState();
}

class _GiaiMongScreenState extends State<GiaiMongScreen> {
  List<ItemModelGiaiMong> _items = [];
  List<ItemModelGiaiMong> _foundUsers = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final List<ItemModelGiaiMong> apiData = await ApiGiaiMong().fetchDreams();
      setState(() {
        _items = apiData;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

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
    List<ItemModelGiaiMong> results = [];
    if (query.isEmpty) {
    } else {
      results = _items.where((storyName) {
        return removeAccents(storyName.ten.toLowerCase())
            .contains(removeAccents(query.toLowerCase()));
      }).toList();
    }

    setState(() {
      _foundUsers = results.cast<ItemModelGiaiMong>();
    });
  }

  Widget listChiTiet(
    String ten,
    String gioithieu,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChiTietGiaiMong(
                      ten: ten,
                      gioithieu: gioithieu,
                    )));
      },
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: const Offset(0, 3),
                  blurRadius: 7,
                  spreadRadius: 5,
                ),
              ],
              color: const Color(0xffFCCDB3),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.black),
            ),
            height: 50,
            child: Center(child: Text(ten)),
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
          'Giải mộng',
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
                  hintText: "Tìm kiếm giấc mộng",
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
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      itemCount: _foundUsers.length,
                      itemBuilder: (context, index) {
                        return listChiTiet(
                          _foundUsers[index].ten,
                          _foundUsers[index].gioithieu,
                        );
                      },
                    )
                  : isLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          itemCount: _items.length < 5 ? _items.length : 5,
                          itemBuilder: (context, index) {
                            return listChiTiet(
                              _items[index].ten,
                              _items[index].gioithieu,
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
