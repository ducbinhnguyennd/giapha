import 'package:flutter/material.dart';
import 'package:giapha/api_all/apitrangchu.dart';
import 'package:giapha/model/Data/DataVanKhan.dart';
import 'package:giapha/model/ReadData/ModelVanKhan.dart';
import 'package:giapha/screens/widgets/item_vankhan.dart';

class SeachVanKhan extends StatefulWidget {
  const SeachVanKhan({super.key, required this.id});
  final String id;
  @override
  State<SeachVanKhan> createState() => _SeachVanKhanState();
}

class _SeachVanKhanState extends State<SeachVanKhan> {
  List<ItemLoai> _items = [];

  List<ItemLoai> _foundUsers = [];
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      List<ItemLoai> apiData = await ApiService().fetchEvents();
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
    List<ItemLoai> results = [];
    if (query.isEmpty) {
    } else {
      results = _items.where((storyName) {
        return removeAccents(storyName.name!.toLowerCase())
            .contains(removeAccents(query.toLowerCase()));
      }).toList();
    }

    setState(() {
      _foundUsers = results.cast<ItemLoai>();
    });
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
                          return VanKhanItem(
                            ten: _foundUsers[index].name ?? '',
                            id: widget.id,
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
