// file vankhan.dart
import 'package:flutter/material.dart';
import 'package:giapha/api_all/apitrangchu.dart';
import 'package:giapha/model/ReadData/ModelVanKhan.dart';
import 'package:giapha/screens/widgets/item_vankhan.dart';
import 'chitiet_vankhan_screen.dart';
import 'seach_vankhan.dart';

class VanKhan extends StatefulWidget {
  const VanKhan({Key? key}) : super(key: key);

  @override
  State<VanKhan> createState() => _VanKhanState();
}

class _VanKhanState extends State<VanKhan> {
  List<ItemLoai> itemlist = [];
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final List<ItemLoai> apiData = await ApiService().fetchEvents();
      setState(() {
        itemlist = apiData;
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
        title: const Text(
          'VĂN KHẤN',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SeachVanKhan(
                            id: itemlist[0].id ?? '',
                          )));
            },
          ),
        ],
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
        child: Center(
          child: isLoading
              ? CircularProgressIndicator()
              : ListView.builder(
                  itemCount: itemlist.length,
                  itemBuilder: (context, index) {
                    return VanKhanItem(
                      ten: itemlist[index].name ?? '',
                      id: itemlist[index].id ?? '',
                    );
                  },
                ),
        ),
      ),
    );
  }
}
