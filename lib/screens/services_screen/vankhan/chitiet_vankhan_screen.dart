import 'package:flutter/material.dart';
import 'package:giapha/api_all/apitrangchu.dart';

import 'package:giapha/model/ReadData/ModelVanKhan.dart';

import 'package:giapha/screens/widgets/item_vankhanchitiet.dart';

class ChiTietVanKhanScreen extends StatefulWidget {
  const ChiTietVanKhanScreen(
      {super.key, required this.id, required this.title});
  final String id;
  final String title;

  @override
  State<ChiTietVanKhanScreen> createState() => _ChiTietVanKhanScreenState();
}

class _ChiTietVanKhanScreenState extends State<ChiTietVanKhanScreen> {
  List<ItemLoai> listVankhanItem = [];
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final List<ItemLoai> apiData =
          await ApiVanKhanItem().fetchVankhanitem(widget.id);
      setState(() {
        listVankhanItem = apiData;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffFBBA95),
        automaticallyImplyLeading: false,
        title: Text(
          widget.title,
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
        child: Container(
          padding: const EdgeInsets.all(20),
          //alignment: Alignment.bottomLeft,
          child: isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: listVankhanItem.length,
                  itemBuilder: (context, index) {
                    return VanKhanChitietItem(
                      id: listVankhanItem[index].id ?? '',
                      ten: listVankhanItem[index].name ?? '',
                    );
                  },
                ),
        ),
      ),
    );
  }
}
