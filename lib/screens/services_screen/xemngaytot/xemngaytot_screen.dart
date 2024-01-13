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
    ItemModelXemNgayTot(id: 0, ten: 'xem_ngay_tot_0', check: 'venhamoi'),
    ItemModelXemNgayTot(id: 1, ten: 'xem_ngay_tot_1', check: 'khaitruong'),
    ItemModelXemNgayTot(id: 2, ten: 'xem_ngay_tot_2', check: 'xuathanh'),
    ItemModelXemNgayTot(id: 3, ten: 'xem_ngay_tot_3', check: 'giaodich'),
    ItemModelXemNgayTot(id: 4, ten: 'xem_ngay_tot_4', check: 'mua'),
    ItemModelXemNgayTot(id: 5, ten: 'xem_ngay_tot_5', check: 'ban'),
    ItemModelXemNgayTot(id: 6, ten: 'xem_ngay_tot_6', check: 'chovay'),
    ItemModelXemNgayTot(id: 7, ten: 'xem_ngay_tot_7', check: 'thuno'),
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
