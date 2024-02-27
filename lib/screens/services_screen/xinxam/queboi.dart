import 'package:flutter/material.dart';
import 'package:giapha/screens/services_screen/xinxam/chitietxinxam.dart';

class QueBoi extends StatelessWidget {
  const QueBoi(
      {super.key,
      required this.noidung,
      required this.ten,
      required this.ten1,
      required this.ten2});

  final String noidung;
  final String ten;
  final String ten1;
  final String ten2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffFBBA95),
        automaticallyImplyLeading: false,
        title: Text(
          ten1,
          style: const TextStyle(color: Colors.black, fontSize: 20),
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                ten,
                style: const TextStyle(
                    color: Color(0xffFF5C00),
                    fontSize: 28,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'CCGabrielBautistaLito'),
              ),
              const Image(image: AssetImage('assets/images/queboi.png')),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChiTietXinXam(
                        ten1: ten1,
                        ten: ten,
                        noidung: noidung,
                      ),
                    ),
                  );
                },
                child: Container(
                  width: 180,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xffFCCDB3),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      'XEM CHI TIẾT',
                      style: TextStyle(
                        color: Color(0xffFF6209),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
