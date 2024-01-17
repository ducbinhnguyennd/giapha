import 'package:flutter/material.dart';
import 'dart:async';

import 'package:giapha/api_all/apitrangchu.dart';
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
  late Timer _timer;
  bool _isScrolling = false;
  int _milliseconds = 60000;
  double _currentSliderValue = 50;
  final double _defaultSliderValue = 50;
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
                              text1,
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
    _startScrolling();
    _loadVanKhan();
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _timer.cancel();
    super.dispose();
  }

  void _startScrolling() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      if (_isScrolling) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: _milliseconds),
          curve: Curves.easeOut,
        );
      } else {
        _timer.cancel();
      }
    });
  }

  void _stopScrolling() {
    setState(() {
      _isScrolling = false;
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
            Icons.arrow_back_outlined,
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
                  : ListView.builder(
                      controller: _scrollController,
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return Container(
                          height: MediaQuery.of(context).size.height,
                          child: Column(children: [
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
                          ]),
                        );
                      },
                    )),
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
                setState(() {
                  _isScrolling = !_isScrolling;
                  if (_isScrolling) {
                    _startScrolling();
                    _currentSliderValue = _defaultSliderValue;
                    _milliseconds =
                        ((_currentSliderValue / 100) * 110000).toInt();
                  } else {
                    _stopScrolling();
                  }
                });
              },
              icon: Icon(
                _isScrolling ? Icons.pause : Icons.play_arrow,
                color: Colors.black,
              ),
            ),
            Slider(
                activeColor: Colors.black,
                value: _currentSliderValue,
                max: 100,
                label: _currentSliderValue.toString(),
                onChanged: (double value) {
                  setState(() {
                    if (value >= 1) {
                      _currentSliderValue = value;
                      _milliseconds =
                          ((_currentSliderValue / 100) * 110000).toInt();
                    }
                  });
                }),
            Text('${_currentSliderValue.toInt()}%')
          ],
        ),
      ),
    );
  }
}
