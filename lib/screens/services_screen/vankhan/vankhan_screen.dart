// file vankhan.dart
import 'package:flutter/material.dart';
import 'package:giapha/api_all/apitrangchu.dart';
import 'package:giapha/model/ReadData/ModelVanKhan.dart';
import 'chitiet_vankhan_screen.dart';
import 'seach_vankhan.dart';

class VanKhan extends StatefulWidget {
  const VanKhan({Key? key}) : super(key: key);

  @override
  State<VanKhan> createState() => _VanKhanState();
}

class _VanKhanState extends State<VanKhan> {
  List<ItemLoai> itemlist = [];

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
      });
    } catch (e) {
      // Xử lý lỗi nếu cần
      print('Error fetching data: $e');
    }
  }

  Widget listVanKhan(String ten) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => ChiTietVanKhanScreen(
        //       loai: loai,
        //       check: check,
        //     ),
        //   ),
        // );
      },
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 50,
            width: 339,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.black),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const VerticalDivider(
                  width: 20,
                  thickness: 2,
                  indent: 0,
                  endIndent: 0,
                  color: Colors.black,
                ),
                SizedBox(
                  width: 200,
                  child: Column(
                    children: [
                      Text(
                        ten,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const VerticalDivider(
                  width: 20,
                  thickness: 2,
                  indent: 0,
                  endIndent: 0,
                  color: Colors.black,
                ),
                const Icon(Icons.arrow_forward_ios),
              ],
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
                      builder: (context) => const SeachVanKhan()));
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
          child: ListView.builder(
            itemCount: itemlist.length,
            itemBuilder: (context, index) {
              return listVanKhan(itemlist[index].name);
            },
          ),
        ),
      ),
    );
  }
}
