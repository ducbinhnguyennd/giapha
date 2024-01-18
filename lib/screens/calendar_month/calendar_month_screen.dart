import 'dart:math';
import 'package:flutter/material.dart';
import 'package:giapha/calendar/calendar.dart';
import 'package:giapha/event/EventList.dart';
import 'package:giapha/mainscreen.dart';

import 'package:giapha/model/Data/DataBatTu.dart';
import 'package:giapha/model/Data/DataDongCong.dart';
import 'package:giapha/model/Data/DataThapNhi.dart';
import 'package:giapha/model/Data/DataTrangTrinh.dart';
import 'package:giapha/model/DataService.dart';
import 'package:giapha/model/EventVO.dart';

import 'package:giapha/model/ReadData/ModelBatTu.dart';
import 'package:giapha/model/ReadData/ModelDongCong.dart';
import 'package:giapha/model/ReadData/ModelThapNhiKienTru.dart';
import 'package:giapha/model/ReadData/ModelTrangTrinh.dart';
import 'package:giapha/screens/calendar_month/CheckGioLucNham.dart';
import 'package:giapha/screens/calendar_month/CheckXung.dart';
import 'package:giapha/screens/calendar_month/checkgiohoangdao.dart';
import 'package:giapha/screens/calendar_month/tinhtuvi/CheckQuanNiem.dart';
import 'package:giapha/screens/calendar_month/tinhtuvi/checknapamngay.dart';
import 'package:giapha/screens/calendar_month/tinhtuvi/checkngayhoangdao.dart';
import 'package:giapha/screens/calendar_month/tinhtuvi/checknguhanh.dart';
import 'package:giapha/screens/calendar_month/tinhtuvi/checknhithap.dart';
import 'package:giapha/screens/calendar_month/tinhtuvi/checktruc.dart';
import 'package:giapha/screens/calendar_month/tinhtuvi/ngayxuathanh.dart';
import 'package:giapha/screens/calendar_month/tinhtuvi/tinhlucdieu.dart';
import 'package:giapha/screens/calendar_month/widget/HomNay.dart';

//import 'package:giapha/screen/calendar_month/chonngay.dart';
import 'package:giapha/utils/lunar_solar_utils.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

class CalendarMonthScreen extends StatefulWidget {
  const CalendarMonthScreen({
    super.key,
    //required this.selectedDate
  });
  //final DateTime selectedDate;

  @override
  State<CalendarMonthScreen> createState() => _CalendarMonthScreenState();
}

class _CalendarMonthScreenState extends State<CalendarMonthScreen> {
  DateTime _selectedDate = DateTime.now();
  //bool returnToday = false;
  List<EventVO> _eventData = [];
  List<EventVO> _eventByMonths = [];
  final List<ItemModelTrangTrinh> _items = itemListTrangTrinh;

  final List<DateTime> _markedDates = [];
  DateTime _calendar = DateTime.now();
  final ValueNotifier<double> fontSizeNotifier = ValueNotifier<double>(16);
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
    _getData();
    DateTime now = DateTime.now();
    _selectedDate = DateTime(_selectedDate.year, _selectedDate.month,
        _selectedDate.day, now.hour, now.minute, now.second);
  }

  _getData() async {
    var data = await loadEventData();
    setState(() {
      _eventData = data;
    });
    generateEventByMonth(_calendar.month);
    generate_markedDates();
  }

  // ignore: non_constant_identifier_names
  generate_markedDates() {
    _markedDates.clear();
    for (var event in _eventData) {
      _markedDates.add(event.date as DateTime);
    }
  }

  generateEventByMonth(int month) {
    _eventByMonths.clear();
    for (var event in _eventData) {
      if (event.date?.month == month) {
        _eventByMonths.add(event);
      }
    }
    setState(() {
      _eventByMonths = _eventByMonths;
    });
  }

  Widget boxBox(Widget widget, String text) {
    return Column(
      children: [
        Row(
          children: [
            const SizedBox(
              height: 30,
            ),
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                color: Colors.yellow,
              ),
              height: 30,
              //width: 100,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(text),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: Container(
              color: Colors.white,
              height: 2,
            ))
          ],
        ),
        const SizedBox(
          height: 27,
        ),
        Container(
          padding: const EdgeInsets.all(10),
          child: widget,
        ),
        const SizedBox(
          height: 40,
        )
      ],
    );
  }

  void handleDaySelected(DateTime selectedDate) {
    setState(() {
      _selectedDate = selectedDate;
    });
  }

  Widget text(String text, String text1) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: text,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          TextSpan(
            text: text1,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget checkXung(String a, String a1) {
    return Container(
      height: 131,
      width: 337,
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
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white, width: 0.3)),
      child: Column(children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          a,
          style: const TextStyle(
              fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: CheckXung(
            nameDay: a1,
          ),
        )
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    int itemCount = min(6, _items.length);
    List<ItemModelTrangTrinh> randomItems = [..._items];
    randomItems.shuffle();
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    // super.build(context);
    var isToday = _selectedDate.year == DateTime.now().year &&
        _selectedDate.month == DateTime.now().month &&
        _selectedDate.day == DateTime.now().day;
    var lunarDates = convertSolar2Lunar(
        _selectedDate.day, _selectedDate.month, _selectedDate.year, 7);
    var lunarDay = lunarDates[0];
    var lunarMonth = lunarDates[1];
    var lunarYear = lunarDates[2];
    var lunarMonthName = getCanChiMonth(lunarMonth, lunarYear);
    var lunarYearName = getCanChiYear(lunarYear);

    var jd = jdn(_selectedDate.day, _selectedDate.month, _selectedDate.year);
    var dayName = getCanChiDay(jd);
    var tietkhi = getTietKhi(jd);
    var canNgay = getCanDay(jd);
    var chiNgay = getChiDay(jd);
    //var lucnhan = getLucNham(jd);
    var nguhanhCan = getNguHanhCheck(canNgay, '');
    var nguhanhChi = getNguHanhCheck('', chiNgay);
    var check = getTruc(_selectedDate.month, chiNgay);
    var napam = getNapAmNgay(dayName);
    var checkNgayHD = getNgayHoangDao(
      lunarMonth,
      chiNgay,
    );

    var dongCong = ('$check $chiNgay');
    print('$dongCong');
    var quanniem = getQuanNIem(lunarDay);
    var lunarMansion = getLunarMansion(_selectedDate);
    var lucdieu = getNgayLucDieu(lunarMonth, lunarDay);
    print('tan vlog: $lucdieu');
    var xuathanh = getThongBao(lunarMonth, lunarDay);

    List<ItemModelThapNhi> listThapNhi = itemListThapNhi
        .where((element) =>
            // ignore: unrelated_type_equality_checks
            element.check == check)
        .toList();
    List<ItemModelDongCong> listDongCong = itemListDongCong
        .where((element) =>
            // ignore: unrelated_type_equality_checks
            element.check == dongCong)
        .toList();
    List<ItemModelBatTu> listBatTu = itemListBatTu
        .where((element) =>
            // ignore: unrelated_type_equality_checks
            element.check == lunarMansion)
        .toList();
    //print(listDongCong);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffFCCDB3),
        title: Text(
          ' ${_selectedDate.month}, ${_selectedDate.year}',
          style: const TextStyle(color: Colors.black, fontSize: 20),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MainScreen(),
                ));
          },
          child: const Icon(
            Icons.arrow_back_outlined,
            color: Colors.black,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      backgroundColor: const Color(0xffFBBA95),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        height: (screenHeight * 30 / 100),
                        width: (screenWidth * 30 / 100),
                        child: Column(
                          children: [
                            Expanded(
                              flex: 7,
                              child: ScrollDatePicker(
                                minimumDate: DateTime(2000, 1, 1),
                                maximumDate: DateTime(2060),
                                options: const DatePickerOptions(
                                    backgroundColor: Color(0xffFBBA95)),
                                selectedDate: _selectedDate,
                                locale: Locale('vi'),
                                onDateTimeChanged: (DateTime value) {
                                  setState(() {
                                    _selectedDate = value;
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
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
                                      'Chọn ngày',
                                      style: TextStyle(
                                        color: Color(0xffFF5C00),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        //fontFamily: 'CCGabrielBautistaLito'
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: const Icon(
                Icons.search,
                color: Colors.black,
                size: 32,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/backgroud.jpg'),
              fit: BoxFit.cover),
        ),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 40, bottom: 60),
                      child: Container(
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
                            borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(color: Colors.white, width: 0.3)),
                        width: 340,
                        child: Calendar(
                          //returnToday: returnToday,
                          //returnToday: returnToday,
                          onDaySelected: handleDaySelected,
                          markedDays: _markedDates,
                          onDateTimeChanged: (newDate) {
                            setState(() {
                              _calendar = newDate;
                            });
                            generateEventByMonth(newDate.month);
                          },
                          selectedDate: _selectedDate,
                        ),
                      )),
                  boxBox(
                      Column(
                        children: [
                          HomNay(
                            a: 'Dương lịch',
                            a1: _selectedDate.day.toString(),
                            a2: _selectedDate.month.toString(),
                            a3: _selectedDate.year.toString(),
                            a4: '',
                            a5: '',
                            a6: '',
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          HomNay(
                              a: 'Âm lịch',
                              a1: lunarDay.toString(),
                              a2: lunarMonth.toString(),
                              a3: lunarYear.toString(),
                              a4: dayName,
                              a5: lunarMonthName,
                              a6: lunarYearName),
                        ],
                      ),
                      'Hôm nay'),
                  boxBox(
                      CheckGioHoangDao(
                        nameDay: chiNgay,
                      ),
                      'Giờ hoàng đạo'),
                  boxBox(
                      Column(
                        children: [
                          checkXung('Tuổi xung theo ngày', dayName),
                          const SizedBox(
                            height: 32,
                          ),
                          checkXung('Tuổi xung theo tháng', lunarMonthName),
                        ],
                      ),
                      'Tuổi xung'),
                  boxBox(
                      EventList(
                        data: _eventByMonths,
                      ),
                      'Sự kiện'),
                  boxBox(
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          text('Tiết khí', tietkhi),
                          text('Đại tiểu nguyệt', 'Tháng đủ'),
                          text('Nạp âm ngày', napam),
                          text('Kiết hung nhật', checkNgayHD),
                          text('Ngày lục nhâm', lucdieu),
                          text('Ngày xuất hành', xuathanh),
                          text('Quan niệm dân gian', quanniem),
                          text('Chi ngày', '$chiNgay ($nguhanhChi)'),
                          text('Can ngày', '$canNgay ($nguhanhCan)'),
                        ],
                      ),
                      'tongquan'),
                  //boxBox(Container(), 'Sao tốt - Sao xấu'),
                  boxBox(
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          text(
                            'truc',
                            check,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: listThapNhi.length,
                              itemBuilder: (context, index) {
                                return Text(
                                  listThapNhi[index].noidung,
                                  style: const TextStyle(fontSize: 16),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                      'thap_nhi'),
                  boxBox(
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          text(
                            'sao',
                            lunarMansion,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: listBatTu.length,
                              itemBuilder: (context, index) {
                                return Text(
                                  listBatTu[index].noidung,
                                  style: const TextStyle(fontSize: 16),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      'Nhị thập bát tú'),
                  // boxBox(CheckLucNham(lucnhamngay: lucdieu), 'Giờ lục nhâm'),

                  boxBox(
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          text(
                            'Ngày',
                            dongCong,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: listDongCong.length,
                              itemBuilder: (context, index) {
                                return Text(
                                  listDongCong[index].noidung,
                                  style: const TextStyle(fontSize: 16),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                      'Đồng cộng soạn trạch nhật'),
                  boxBox(
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: itemCount,
                        itemBuilder: (context, index) {
                          return ExpansionTile(
                            title: Text(
                              randomItems[index].ten,
                            ),
                            children: [Text(randomItems[index].noidung)],
                          );
                        },
                      ),
                      'Trạng trình Nguyễn Bỉnh Khiêm'),
                ],
              ),
            ),
            Positioned(
              right: 10,
              bottom: 40,
              child: Column(
                children: [
                  if (!isToday)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedDate = DateTime.now();
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(20),
                            border:
                                Border.all(color: Colors.white, width: 0.3)),
                        height: 30,
                        width: 100,
                        child: Center(
                            child: Text(
                          'Hôm nay',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )),
                      ),
                    )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
