import 'package:flutter/material.dart';
import 'package:giapha/api_all/apitrangchu.dart';
import 'package:giapha/constant/colors_const.dart';

import 'package:giapha/model/danhsachHoModel.dart';
import 'package:giapha/screens/widgets/item_ho.dart';

class DanhsachhoScreen extends StatefulWidget {
  const DanhsachhoScreen({super.key});

  @override
  State<DanhsachhoScreen> createState() => _DanhsachhoScreenState();
}

class _DanhsachhoScreenState extends State<DanhsachhoScreen>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  List<danhsachHoModel> _items = [];

  List<danhsachHoModel> _foundUsers = [];

  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final List<danhsachHoModel> apiData =
          await DanhSachHoService().fetchdsHo();
      setState(() {
        _items = apiData;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching data: $e');
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
    List<danhsachHoModel> results = [];
    if (query.isEmpty) {
      //results = _items.cast<ItemModel>();
    } else {
      results = _items.where((ho) {
        String nameLower = removeAccents(ho.name);
        // String authorLower = removeAccents(book.);
        String category = removeAccents(ho.address);
        String queryLower = removeAccents(query.toLowerCase());

        return nameLower.contains(queryLower) ||
            // authorLower.contains(queryLower) ||
            category.contains(queryLower);
      }).toList();
    }

    setState(() {
      _foundUsers = results.cast<danhsachHoModel>();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Tìm kiếm họ'),
        centerTitle: true,
        backgroundColor: ColorConst.colorPrimary50,
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (value) => _runFilter(value),
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
              hintText: "Tìm theo tên hoặc địa chỉ",
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
                    itemCount: _foundUsers.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                          onTap: () {},
                          child: ItemHo(
                            tenho: _foundUsers[index].name,
                            diachi: _foundUsers[index].address,
                          ));
                    },
                  )
                : isLoading
                    ? Center(child: CircularProgressIndicator())
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // Số cột trong GridView
                            crossAxisSpacing: 8.0, // Khoảng cách giữa các cột
                            mainAxisSpacing: 8.0, // Khoảng cách giữa các dòng
                          ),
                          itemCount: _items.length,
                          itemBuilder: (context, index) {
                            return ItemHo(
                              tenho: _items[index].name,
                              diachi: _items[index].address,
                            );
                          },
                        ),
                      )

            //: const Placeholder()

            ),
      ]),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
