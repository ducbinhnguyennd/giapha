import 'package:flutter/material.dart';
import 'package:giapha/model/ReadData/ModelVanKhan.dart';
import 'package:giapha/screens/services_screen/vankhan/chitiet_vankhan_screen.dart';
import 'package:giapha/screens/services_screen/vankhan/seach_vankhan.dart';

class VanKhan extends StatefulWidget {
  const VanKhan({super.key});

  @override
  State<VanKhan> createState() => _VanKhanState();
}

class _VanKhanState extends State<VanKhan> {
  List<ItemLoai> itemlist = [
    ItemLoai(
        icon: 'assets/icons/danhgia.png',
        ten: 'VĂN KHẤN',
        loai: 'lunar_new_year',
        check: 'tetnguyendan'),
    ItemLoai(
        icon: 'assets/icons/danhgia.png',
        ten: 'VĂN KHẤN',
        loai: 'festivals_of_year',
        check: 'tettrongnam'),
    ItemLoai(
        icon: 'assets/icons/danhgia.png',
        ten: 'VĂN KHẤN',
        loai: 'tangle_giochap',
        check: 'tangle'),
    ItemLoai(
        icon: 'assets/icons/danhgia.png',
        ten: 'VĂN KHẤN',
        loai: 'dinh_mieu_phu',
        check: 'dinhdenmieuphu'),
    ItemLoai(
        icon: 'assets/icons/danhgia.png',
        ten: 'VĂN KHẤN',
        loai: 'nha_congty_shop',
        check: 'nhao'),
    ItemLoai(
        icon: 'assets/icons/danhgia.png',
        ten: 'VĂN KHẤN',
        loai: 'dangsao_giaihan',
        check: 'dangsao'),
    ItemLoai(
        icon: 'assets/icons/danhgia.png',
        ten: 'VĂN KHẤN',
        loai: 'mung1ngayram',
        check: 'mongmotngayram'),
    ItemLoai(
        icon: 'assets/icons/danhgia.png',
        ten: 'nghi_le_khac',
        loai: '',
        check: 'khac')
  ];

  Widget listVanKhan(Widget Image, String ten, String loai, String check) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChiTietVanKhanScreen(
                loai: loai,
                check: check,
              ),
            ));
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
                Image,
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
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        ten,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(loai),
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
              return listVanKhan(
                Image(
                  height: 45,
                  width: 45,
                  image: AssetImage(itemlist[index].icon),
                ),
                itemlist[index].ten,
                itemlist[index].loai,
                itemlist[index].check,
              );
            },
          ),
        ),
      ),
    );
  }
}
