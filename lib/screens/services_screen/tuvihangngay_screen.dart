//import 'dart:math';

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:giapha/constant/colors_const.dart';
import 'package:giapha/model/Data/DataTuViHangNgay.dart';
import 'package:giapha/model/ReadData/ModelTuViHangNgay.dart';
import 'package:giapha/utils/date_utils.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

class TuViHangNgayScreen extends StatefulWidget {
  const TuViHangNgayScreen({super.key});

  @override
  State<TuViHangNgayScreen> createState() => _TuViHangNgayScreenState();
}

class _TuViHangNgayScreenState extends State<TuViHangNgayScreen> {
  final ValueNotifier<double> fontSizeNotifier = ValueNotifier<double>(15);
  DateTime selectedDate = DateTime.now();
  int _focusedIndex = 0;
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

  @override
  void initState() {
    super.initState();
  }

  //region: area ads
  /// Loads and shows a banner ad.
  ///
  /// Dimensions of the ad are determined by the AdSize class.

  // Widget currentAd = SizedBox(
  //   width: 0.0,
  //   height: 0.0,
  // );

  //endregion

  final List<ItemModelTuViHangNgay> _items = itemListTuViHangNgay;
  final DateTime _calendar = DateTime.now();

  void _onItemFocus(int index) {
    //print(index);
    setState(() {
      _focusedIndex = index;
    });
  }

  Widget _buildItemDetail(dynamic dayOfWeek, dynamic screenHeight) {
    if (_items.length > _focusedIndex) {
      return Column(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Container(
                    height: (screenHeight * 13 / 100),
                    width: 340,
                    decoration: BoxDecoration(
                      color: ColorConst.colorPrimary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Image(
                                height: 48,
                                width: 48,
                                image: AssetImage('assets/icons/tuvi1.png')),
                            Text(
                              _items[_focusedIndex].ten,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700),
                            ),
                            const Image(
                                height: 48,
                                width: 48,
                                image: AssetImage('assets/icons/tuvi1.png')),
                          ],
                        ),
                        ValueListenableBuilder(
                          valueListenable: fontSizeNotifier,
                          builder: (context, fontSize, _) {
                            return Text(
                              '$dayOfWeek ${_calendar.day}-${_calendar.month}-${_calendar.year}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Container(
                  height: (screenHeight * 45 / 100),
                  width: 340,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 20, bottom: 5, right: 10, left: 10),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'Diễn giải',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.red,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          ValueListenableBuilder(
                            valueListenable: fontSizeNotifier,
                            builder: (context, fontSize, _) {
                              return Text(
                                _items[_focusedIndex].noidung,
                                style: TextStyle(
                                    fontSize: fontSize,
                                    fontWeight: FontWeight.w400),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    return const Text("Không có dữ liệu");
  }

  Widget _buildListItem(BuildContext context, int index) {
    if (index == _items.length) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    //horizontal
    return SizedBox(
      width: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            height: 100,
            width: 100,
            image: AssetImage(_items[index].image),
          )
        ],
      ),
    );
  }
  // double customEquation(double distance) {
  //   // return 1-min(distance.abs()/500, 0.2);
  //   return 1 - (distance / 1000);
  // }

  @override
  Widget build(BuildContext context) {
    var dayOfWeek = getNameDayOfWeek(_calendar);
    final Size screenSize = MediaQuery.of(context).size;

    final double screenHeight = screenSize.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConst.colorPrimary,
        automaticallyImplyLeading: false,
        title: const Text(
          'Tử vi mỗi ngày',
          style: TextStyle(color: Colors.black, fontSize: 20),
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
                  Color.fromRGBO(251, 255, 244, 1),
                  Color.fromARGB(255, 165, 247, 149),
                  Color.fromARGB(255, 120, 230, 76),
                  Color.fromARGB(255, 103, 250, 97),
                ],
                tileMode: TileMode.mirror,
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Center(
                    child: ScrollSnapList(
                      onItemFocus: _onItemFocus,
                      itemSize: 150,
                      itemBuilder: _buildListItem,
                      itemCount: _items.length,
                      dynamicItemSize: true,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                    flex: 8, child: _buildItemDetail(dayOfWeek, screenHeight)),
              ],
            ),
          ),
          Positioned(
            right: 10,
            bottom: 60,
            child: Column(
              children: [
                TextButton(
                  onPressed: increaseFontSize,
                  child: const Icon(
                    Icons.add_circle,
                    color: Colors.red,
                  ),
                ),
                TextButton(
                  onPressed: decreaseFontSize,
                  child: const Icon(
                    Icons.remove_circle,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
