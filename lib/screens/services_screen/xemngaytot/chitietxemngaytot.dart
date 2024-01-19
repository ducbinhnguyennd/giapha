import 'dart:io';

import 'package:flutter/material.dart';
import 'package:giapha/constant/common_service.dart';
import 'package:giapha/screens/calendar_month/tinhtuvi/checkngayhoangdao.dart';
import 'package:giapha/utils/lunar_solar_utils.dart';

import '../../calendar_month/tinhtuvi/checktuoixung.dart';

class ChiTietXemNgayTot extends StatefulWidget {
  const ChiTietXemNgayTot({super.key, required this.ten, required this.check});

  final String ten;
  final String check;

  @override
  State<ChiTietXemNgayTot> createState() => _ChiTietXemNgayTotState();
}

class _ChiTietXemNgayTotState extends State<ChiTietXemNgayTot> {
  List<int> yearList = [];
  int startYear = 2000;
  int endYear = DateTime.now().year;
  int selectedYear = 0;
  List<int> monthList = [];
  int startMonth = 1;
  int endMonth = 12;
  int selectedMonth = 0;
  bool isShowList = false;
  List<String> ls = [
    'Vui lòng chọn',
    'Tháng Một',
    'Tháng Hai',
    'Tháng Ba',
    'Tháng Tư',
    'Tháng Năm',
    'Tháng Sáu',
    'Tháng Bảy',
    'Tháng Tám',
    'Tháng Chín',
    'Tháng Mười',
    'Tháng 11',
    'Tháng 12'
  ];
  @override
  void initState() {
    selectedYear = DateTime.now().year;
    selectedMonth = 0;
    for (int year = startYear; year <= endYear; year++) {
      yearList.add(year);
    }
    // for (int month = startMonth; month <= endMonth; month++) {
    //   monthList.add(month);
    // }
    super.initState();
  }

  String getTotXau(String check) {
    if (check == 'Hoàng Đạo') {
      return 'Tốt';
    } else if (check == 'Hắc Đạo') {
      return 'Xấu';
    } else {
      return 'Bình thường';
    }
  }

  List<Widget> getDaysInMonth() {
    final daysInMonth = DateTime(DateTime.now().year, selectedMonth + 1, 0).day;
    final List<Widget> daysList = [];

    for (int day = 1; day <= daysInMonth; day++) {
      var lunarDates =
          convertSolar2Lunar(day, selectedMonth, DateTime.now().year, 7);
      var lunarDay = lunarDates[0];
      var lunarMonth = lunarDates[1];
      var lunarYear = lunarDates[2];
      var lunarYearName = getCanChiYear(lunarYear);
      var jd = jdn(day, selectedMonth, DateTime.now().year);
      var chiNgay = getChiDay(jd);
      var image = getCheckTuoiXung(chiNgay);
      var checkNgayHD = getNgayHoangDao(
        lunarMonth,
        chiNgay,
      );
      final formattedDate = Container(
        decoration: BoxDecoration(
          color: const Color(0xffFCCDB3),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image(height: 50, width: 50, image: AssetImage(image)),
            Column(
              children: [
                Row(
                  children: [
                    Text(
                      '$day ',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Tháng',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      ' $selectedMonth',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Năm',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${DateTime.now().year}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(children: [
                  Text('$lunarDay '),
                  Text('Tháng'),
                  Text(' $lunarMonth $lunarYearName'),
                ])
              ],
            ),
            Text(
              getTotXau(checkNgayHD),
              style: TextStyle(
                color:
                    getTotXau(checkNgayHD) == 'Tốt' ? Colors.red : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      );
      daysList.add(formattedDate);
    }

    return daysList;
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> daysList = getDaysInMonth();
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
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
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        //getHeader(context),
                        Container(
                          height: 40,
                          // width: MediaQuery.of(context).size.width / 2.3,
                          padding: const EdgeInsets.only(
                              top: 5, bottom: 5, left: 10, right: 10),
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
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      backgroundColor: const Color(0xffFBBA95),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        height: (screenHeight * 30 / 100),
                                        width: (screenWidth * 30 / 100),
                                        child: ListView.builder(
                                          itemCount: ls.length,
                                          itemBuilder: (context, index) {
                                            return Column(
                                              children: [
                                                ListTile(
                                                  title: Center(
                                                    child: Text(
                                                      '${ls[index].toString()}',
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    setState(() {
                                                      selectedMonth = index;
                                                      Navigator.pop(
                                                          context, ls[index]);
                                                    });
                                                  },
                                                ),
                                                const Divider(
                                                  color: Colors.grey,
                                                  thickness: 1.0,
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      selectedMonth != 0
                                          ? '${ls[selectedMonth]}'
                                          : "Chọn tháng",
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    const Image(
                                        image: AssetImage(
                                            'assets/icons/namtrondoi.png'),
                                        height: 20,
                                        width: 20)
                                  ],
                                ),
                              )),
                        ),
                        Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width / 2.4,
                          padding: const EdgeInsets.only(
                              top: 5, bottom: 5, left: 10, right: 10),
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
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      backgroundColor: const Color(0xffFBBA95),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        height: (screenHeight * 30 / 100),
                                        width: (screenWidth * 30 / 100),
                                        child: Column(
                                          children: [
                                            Expanded(
                                              flex: 9,
                                              child: ListView.builder(
                                                itemCount: yearList.length,
                                                itemBuilder: (context, index) {
                                                  return Column(
                                                    children: [
                                                      ListTile(
                                                        title: Center(
                                                          child: Text(
                                                            yearList[index]
                                                                .toString(),
                                                            style: const TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        ),
                                                        onTap: () {
                                                          setState(() {
                                                            selectedYear =
                                                                yearList[index];
                                                            Navigator.pop(
                                                                context,
                                                                yearList[
                                                                    index]);
                                                          });
                                                        },
                                                      ),
                                                      const Divider(
                                                        // Thêm Divider sau mỗi ListTile
                                                        color: Colors
                                                            .grey, // Màu sắc của đường kẻ
                                                        thickness:
                                                            1.0, // Độ dày của đường kẻ
                                                      ),
                                                    ],
                                                  );
                                                },
                                              ),
                                            ),
                                            Expanded(
                                                flex: 1,
                                                child: Center(
                                                  child: Text(
                                                    'Chọn năm',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ))
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      selectedYear != 0
                                          ? selectedYear.toString()
                                          : "Chưa được chọn",
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    const Image(
                                        image: AssetImage(
                                            'assets/icons/namtrondoi.png'))
                                  ],
                                ),
                              )),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (selectedYear != 0 && selectedMonth != 0) {
                          setState(() {
                            isShowList = true;
                          });
                        } else {
                          CommonService.showToast(
                              'Vui lòng chọn tháng để xem', context);
                        }
                      },
                      child: Container(
                        width: 180,
                        padding: const EdgeInsets.all(10),
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
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: Text(
                            'Xem ngày tốt',
                            style: TextStyle(
                                color: Color(0xffFF5C00),
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'CCGabrielBautistaLito'),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: isShowList,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        height: MediaQuery.of(context).size.height / 1.5,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: daysList.length,
                          itemBuilder: (context, index) {
                            return Container(
                                padding: const EdgeInsets.all(8),
                                child: daysList[index]);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
