import 'package:flutter/material.dart';
import 'dart:async';

import 'package:giapha/api_all/apitrangchu.dart';
import 'package:giapha/constant/colors_const.dart';
import 'package:giapha/model/ReadData/ModelVanKhan.dart';

class ChiTiet extends StatefulWidget {
  ChiTiet({super.key, required this.ten, required this.id});

  String? ten;
  final String id;

  @override
  State<ChiTiet> createState() => _ChiTietState();
}

class _ChiTietState extends State<ChiTiet> {
  late ScrollController _scrollController;
  Timer? _scrollTimer;

  bool _isScrolling = false;
  double _scrollSpeed = 5.0;
  final ValueNotifier<double> fontSizeNotifier = ValueNotifier<double>(16);
  bool isLoading = true;
  void increaseFontSize() {
    if (fontSizeNotifier.value < 24.0) {
      fontSizeNotifier.value += 1.0;
    }
  }

  void decreaseFontSize() {
    if (fontSizeNotifier.value > 12.0) {
      fontSizeNotifier.value -= 1.0;
    }
  }

  final ApiChiTietVanKhan _apiService = ApiChiTietVanKhan();
  late VanKhanModel vanKhanModel;

  Future<void> _loadVanKhan() async {
    try {
      final vanKhan1 = await _apiService.fetchVanKhan(widget.id);
      setState(() {
        vanKhanModel = vanKhan1;
        isLoading = false;
      });
    } catch (e) {
      print('Error loading VanKhan: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget box(String text, String text1) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Center(
              child: Container(
                width: 340,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black)),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 25, right: 10, left: 10, bottom: 5),
                  child: Column(
                    children: [
                      ValueListenableBuilder(
                          valueListenable: fontSizeNotifier,
                          builder: (context, fontSize, _) {
                            return Text(
                              text1
                                  .replaceAll("\\n\\n", "\n\n")
                                  .replaceAll("\\n", "\n"),
                              softWrap: true,
                              style: TextStyle(
                                  fontSize: fontSize,
                                  fontWeight: FontWeight.w400),
                            );
                          }),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Positioned(
          top: 10,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.yellow,
            ),
            height: 40,
            width: MediaQuery.of(context).size.width / 2,
            child: Center(
                child: Text(
              text,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
            )),
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    _loadVanKhan();
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _scrollTimer?.cancel();
    super.dispose();
  }

  void _toggleAutoScroll() {
    setState(() {
      _isScrolling = !_isScrolling;
      if (_isScrolling) {
        _startAutoScroll();
      } else {
        _scrollTimer?.cancel();
      }
    });
  }

  void _changeScrollSpeed(double value) {
    // print('xem chya bn ma cham the $value');
    setState(() {
      _scrollSpeed = value;
      if (_isScrolling) {
        _scrollTimer?.cancel();
        _startAutoScroll();
      }
    });
  }

  void _startAutoScroll() {
    if (_scrollController.hasClients == false) return;

    _scrollTimer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
      if (_scrollController.hasClients == true) {
        _scrollController.animateTo(
          _scrollController.position.pixels + _scrollSpeed,
          duration: const Duration(milliseconds: 200),
          curve: Curves.linear,
        );

        if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 20) {
          setState(() {
            _isScrolling = false;
            timer.cancel();
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //print(widget.samle);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffFBBA95),
        automaticallyImplyLeading: false,
        title: Text(
          widget.ten ?? '',
          style: const TextStyle(color: Colors.black, fontSize: 20),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
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
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      children: [
                        box(
                          'Giới thiệu',
                          vanKhanModel.gioiThieu,
                        ),
                        box(
                          'Sắm lễ',
                          vanKhanModel.samle,
                        ),
                        box(
                          'VĂN KHẤN',
                          vanKhanModel.vanKhan,
                        ),
                      ],
                    ),
                  ),
          ),
          Positioned(
            right: 10,
            bottom: 10,
            child: Column(
              children: [
                TextButton(
                  onPressed: increaseFontSize,
                  child: const Icon(
                    Icons.add_circle,
                    color: Colors.yellow,
                  ),
                ),
                TextButton(
                  onPressed: decreaseFontSize,
                  child: const Icon(
                    Icons.remove_circle,
                    color: Colors.yellow,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        color: const Color(0xffFBBA95),
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                _toggleAutoScroll();
              },
              icon: Icon(
                _isScrolling ? Icons.pause : Icons.play_arrow,
                color: Colors.black,
              ),
            ),
            Slider(
              activeColor: ColorConst.colorPrimary,
              inactiveColor: Colors.grey,
              thumbColor: ColorConst.colorSecondary,
              min: 1.0,
              max: 20.0,
              value: _scrollSpeed,
              onChanged: _changeScrollSpeed,
              divisions: 19,
            ),
            Text('${_scrollSpeed.toInt()}%')
          ],
        ),
      ),
    );
  }
}
