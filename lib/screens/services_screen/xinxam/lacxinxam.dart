import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:giapha/api_all/apitrangchu.dart';
import 'package:giapha/model/Data/DataXinXam.dart';
import 'package:giapha/model/ReadData/ModelXinXam.dart';
import 'package:giapha/screens/services_screen/xinxam/queboi.dart';

import 'package:shake/shake.dart';

class LacXinXam extends StatefulWidget {
  const LacXinXam({super.key, required this.id, required this.ten});
  final String id;
  final String ten;

  @override
  State<LacXinXam> createState() => _LacXinXamState();
}

class _LacXinXamState extends State<LacXinXam> {
  bool isShakeDetected = false;
  bool _isShaking = false;
  List<ItemModelXinXam> listXinXam = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchDataQueBoi();

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
          final randomIndex = listXinXam.isNotEmpty
              ? random.nextInt(listXinXam.length)
              : 0; // Ensure listXinXam is not empty
          Future.delayed(const Duration(milliseconds: 4800), () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => QueBoi(
                  ten2: listXinXam[randomIndex].tenque,
                  ten1: widget.ten,
                  ten: listXinXam[randomIndex].tenxam,
                  noidung: listXinXam[randomIndex].noidung,
                ),
              ),
            );
          });
        }
      },
      minimumShakeCount: 1,
      shakeSlopTimeMS: 500,
      shakeCountResetTime: 300,
      shakeThresholdGravity: 2.7,
    );
  }

  ApiChiTietXinXam apiChiTietXinXam = ApiChiTietXinXam();
  Future<void> fetchDataQueBoi() async {
    try {
      final List<ItemModelXinXam> fetchedTattoos =
          await apiChiTietXinXam.fetchxinxamitem(widget.id);
      setState(() {
        listXinXam = fetchedTattoos;
      });
    } catch (error) {
      print('Error fetching tattoos: $error');
    }
  }

  bool showVanKhan = true; // Biến cờ để điều khiển hiển thị 'Đọc văn khấn'

  @override
  Widget build(BuildContext context) {
    final random = Random();
    final randomIndex = listXinXam.isNotEmpty
        ? random.nextInt(listXinXam.length)
        : 0; // Ensure listXinXam is not empty

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
              if (showVanKhan)
                GestureDetector(
                  onTap: () {
                    if (listXinXam.isNotEmpty) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          final randomIndex =
                              Random().nextInt(listXinXam.length);
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            backgroundColor: const Color(0xffFCCDB3),
                            title: Center(child: Text('VĂN KHẤN')),
                            content: const Text(
                              ''' Trời Phật che chở, thánh thần thiêng liêng. Có ngờ thì hỏi, có bói thì thông. Chữ rằng :- “Có lòng thành tức có thân chứng, có lời cầu xin tức có sự ứng nghiệm”. \n Hôm nay là ngày… tháng ….năm ..., lúc ... giờ... Con tên là ......tuổi, ở tại ...Muốn biết về việc Gặp sự quan tâm, lòng đương thắc mắc, dám xin cung thỉnh Đức Phật Quan Âm lai lâm chứng giám, ban cho một quẻ linh xâm, đặng tỏ sự tình hay dỡ, kết quả xấu tốt ra sao. Hay khen hèn chê, để chúng con biết đường mà lội, biết lối mà qua, hầu có thể tránh dữ tìm lành, đổi tai làm phúc. Nay kính khẩn.''',
                            ),
                            actions: [
                              Center(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => QueBoi(
                                          ten2: listXinXam[randomIndex].tenque,
                                          ten1: widget.ten,
                                          ten: listXinXam[randomIndex].tenxam,
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
                    }
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
                        'ĐỌC KHẤN',
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
