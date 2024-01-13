import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:giapha/model/Data/DataXinXam.dart';
import 'package:giapha/model/ReadData/ModelXinXam.dart';
import 'package:giapha/screens/services_screen/xinxam/queboi.dart';

import 'package:shake/shake.dart';

class LacXinXam extends StatefulWidget {
  const LacXinXam({super.key, required this.check, required this.ten});
  final String check;
  final String ten;

  @override
  State<LacXinXam> createState() => _LacXinXamState();
}

class _LacXinXamState extends State<LacXinXam> {
  bool isShakeDetected = false;
  bool _isShaking = false;
  List<ItemModelXinXam> listXinXam = [];
  @override
  void initState() {
    super.initState();
    listXinXam = itemListXinXam
        .where((element) => element.loai == widget.check)
        .toList();

    ShakeDetector.autoStart(
      onPhoneShake: () {
        if (!isShakeDetected) {
          setState(() {
            isShakeDetected = true;
            _isShaking = true;
          });
          Timer(const Duration(milliseconds: 4800), () {
            setState(() {
              _isShaking = false;
              //_isAnimating = false;
            });
          });
          final random = Random();
          final randomIndex = random.nextInt(listXinXam.length);
          Future.delayed(const Duration(milliseconds: 4800), () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => QueBoi(
                  ten2: listXinXam[randomIndex].ten1,
                  ten1: widget.ten,
                  ten: listXinXam[randomIndex].ten,
                  noidung: listXinXam[randomIndex].noidung,
                ),
              ),
            );
          });

          // showDialog(
          //   context: context,
          //   builder: (context) {
          //     return dialogBox(
          //       listXinXam[randomIndex].ten,
          //       listXinXam[randomIndex].noidung,
          //     );
          //   },
          // );
        }
      },
      minimumShakeCount: 1,
      shakeSlopTimeMS: 500,
      shakeCountResetTime: 300,
      shakeThresholdGravity: 2.7,
    );
  }

  // Widget dialogBox(String ten, String noidung) {
  //   return AlertDialog(
  //     title: Text(ten),
  //     content: const Text(
  //       'vui lòng nhấn "Chi tiết" để xem lời giải',
  //     ),
  //     actions: [
  //       Center(
  //         child: GestureDetector(
  //           onTap: () {
  //             Navigator.pushReplacement(
  //                 context,
  //                 MaterialPageRoute(
  //                     builder: (context) => ChiTietXinXam(
  //                           ten: ten,
  //                           noidung: noidung,
  //                         )));
  //           },
  //           child: Container(
  //             width: 150,
  //             padding: const EdgeInsets.all(20),
  //             decoration: BoxDecoration(
  //               color: Colors.deepPurple,
  //               borderRadius: BorderRadius.circular(20),
  //             ),
  //             child: const Center(
  //               child: Text(
  //                 'Chi tiết',
  //                 style: TextStyle(
  //                   color: Colors.white,
  //                   fontSize: 18,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  bool showVanKhan = true; // Biến cờ để điều khiển hiển thị 'Đọc văn khấn'
  List<ItemModelXinXam> list = [];

  @override
  Widget build(BuildContext context) {
    final random = Random();
    final randomIndex = random.nextInt(listXinXam.length);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffFBBA95),
        automaticallyImplyLeading: false,
        title: Text(
          widget.ten,
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
              const Text(
                'Lắc để xin xăm',
                style: TextStyle(
                    color: Color(0xffFF5C00),
                    fontSize: 28,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'CCGabrielBautistaLito'),
              ),
              Container(
                  child: _isShaking
                      ? const Image(image: AssetImage('assets/images/ong.gif'))
                      : const Image(
                          image: AssetImage('assets/images/xinxam.png'))),
              if (showVanKhan) // Hiển thị 'Đọc văn khấn' chỉ khi biến cờ là true
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          backgroundColor: const Color(0xffFCCDB3),
                          title: Center(child: Text('VĂN KHẤN')),
                          content: const Text(
                            '''lac_xin_xam1''',
                          ),
                          actions: [
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  // Navigator.of(context).pop();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => QueBoi(
                                        ten2: listXinXam[randomIndex].ten1,
                                        ten1: widget.ten,
                                        ten: listXinXam[randomIndex].ten,
                                        noidung:
                                            listXinXam[randomIndex].noidung,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: 150,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: const Color(0xffFF6209),
                                    borderRadius: BorderRadius.circular(13),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Lắc để xin xăm',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                    setState(() {
                      showVanKhan = false;
                    });
                  },
                  child: Container(
                    width: 180,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: const Color(0xffFCCDB3),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        'doc_khan',
                        style: TextStyle(
                          color: Color(0xffFF6209),
                          fontSize: 15,
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
