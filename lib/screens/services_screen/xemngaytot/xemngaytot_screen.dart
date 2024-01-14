import 'package:flutter/material.dart';
import 'package:giapha/model/ReadData/ModelXemNgayTot.dart';
import 'package:giapha/screens/services_screen/xemngaytot/chitietxemngaytot.dart';

class XemNgayTotScreen extends StatefulWidget {
  const XemNgayTotScreen({super.key});

  @override
  State<XemNgayTotScreen> createState() => _XemNgayTotScreenState();
}

class _XemNgayTotScreenState extends State<XemNgayTotScreen> {
  List<ItemModelXemNgayTot> itemListXemNgayTot = [
    ItemModelXemNgayTot(id: 0, ten: 'Về nhà mới', check: 'venhamoi'),
    ItemModelXemNgayTot(id: 1, ten: 'Khai trương', check: 'khaitruong'),
    ItemModelXemNgayTot(id: 2, ten: 'Xuất hành', check: 'xuathanh'),
    ItemModelXemNgayTot(id: 3, ten: 'Giao dịch', check: 'giaodich'),
    ItemModelXemNgayTot(id: 4, ten: 'Mua (Xe, nhà, đất)', check: 'mua'),
    ItemModelXemNgayTot(id: 5, ten: 'Bán (Xe, nhà, đất)', check: 'ban'),
    ItemModelXemNgayTot(id: 6, ten: 'Cho vay, cho mượn', check: 'chovay'),
    ItemModelXemNgayTot(id: 7, ten: 'Thu nợ', check: 'thuno'),
  ];
  Widget listChiTiet(String ten, String check) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChiTietXemNgayTot(
                      ten: ten,
                      check: check,
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
              border: Border.all(color: Colors.black, width: 0.4),
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
          backgroundColor: const Color(0xffFCCDB3),
          automaticallyImplyLeading: false,
          title: const Text(
            'Xem ngày tốt',
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
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment(0.8, 1),
              colors: <Color>[
                Color(0xffF7E3D7),
                Color(0xffFFA877),
                Color(0xffFBBA95),
                Color(0xffEF6518),
              ],
              tileMode: TileMode.mirror,
            ),
          ),
          child: ListView.builder(
            padding: const EdgeInsets.only(left: 20, right: 20),
            itemCount: itemListXemNgayTot.length,
            itemBuilder: (context, index) {
              return listChiTiet(
                itemListXemNgayTot[index].ten,
                itemListXemNgayTot[index].check,
              );
            },
          ),
        ));
  }
}
