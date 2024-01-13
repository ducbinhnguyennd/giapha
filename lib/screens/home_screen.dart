import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:giapha/calendar/SelectDateButton.dart';
import 'package:giapha/calendar/StrokeText.dart';
import 'package:giapha/calendar/SwipeDetector.dart';
import 'package:giapha/model/DataService.dart';
import 'package:giapha/model/QuoteVO.dart';
import 'package:giapha/screens/calendar_month/calendar_month_screen.dart';
import 'package:giapha/screens/services_screen/giaimong/giaimong_screen.dart';
import 'package:giapha/screens/services_screen/trondoi/tuvitrondoi_screen.dart';
import 'package:giapha/screens/services_screen/tuvihangngay_screen.dart';
import 'package:giapha/screens/services_screen/vankhan/vankhan_screen.dart';
import 'package:giapha/screens/services_screen/xemngaytot/xemngaytot_screen.dart';
import 'package:giapha/screens/services_screen/xinxam/xinxam_screen.dart';
import 'package:giapha/utils/date_utils.dart';
import 'package:giapha/utils/lunar_solar_utils.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin<HomeScreen> {
  List<QuoteVO> _quoteData = [];
  DateTime _selectedDate = DateTime.now();
  late Timer _timer;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _getData();

    //_animation
    _controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    _controller.value = 0.8;
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
    //timer update datetime
    const oneSec = Duration(seconds: 2);
    _timer = Timer.periodic(
        oneSec,
        (Timer timer) => setState(() {
              DateTime now = DateTime.now();
              _selectedDate = DateTime(_selectedDate.year, _selectedDate.month,
                  _selectedDate.day, now.hour, now.minute, now.second);
            }));
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  _getData() async {
    var data = await loadQuoteData();
    setState(() {
      _quoteData = data;
    });
  }

  _onSwipeLeft() {
    _controller.value = 0.8;
    _controller.forward();
    setState(() {
      _selectedDate = decreaseDay(_selectedDate);
    });
  }

  _onSwipeRight() {
    _controller.value = 0.8;
    _controller.forward();
    setState(() {
      _selectedDate = increaseDay(_selectedDate);
    });
  }

  // Future<void> _showDatePicker(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //       context: context,
  //       initialDate: _selectedDate,
  //       firstDate: DateTime(1920, 8),
  //       lastDate: DateTime(2101));
  //   if (picked != null && picked != _selectedDate) {
  //     setState(() {
  //       _selectedDate = picked;
  //     });
  //   }
  // }

  Widget paddingText(double top, String text, TextStyle style) {
    return Padding(
      padding: EdgeInsets.only(top: top, left: 10, right: 10),
      child: Text(text, style: style),
    );
  }

  Widget getHeader(context, double screenHeight, double screenWidth) {
    var title = ' ${_selectedDate.month} - ${_selectedDate.year}';
    var todayStyle =
        const TextStyle(color: Colors.white, fontWeight: FontWeight.bold);

    var isToday = _selectedDate.year == DateTime.now().year &&
        _selectedDate.month == DateTime.now().month &&
        _selectedDate.day == DateTime.now().day;
    // String en = 'en';
    return Positioned(
      top: 40,
      left: 10,
      right: 10,
      child: Stack(
        children: [
          Align(
              alignment: Alignment.topRight,
              child: SelectDateButton(
                  title: title,
                  onPress: () {
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
                                            color:
                                                Colors.black.withOpacity(0.2),
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
                                          'choose_adate',
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
                    //_showDatePicker(context);
                  })),
          if (!isToday)
            Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                    height: 40,
                    width: 100,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedDate = DateTime.now();
                        });
                      },
                      child: Center(
                        child: Text(
                          "Hôm nay",
                          style: todayStyle,
                        ),
                      ),
                    ))),
        ],
      ),
    );
  }

  Widget getMainDate(double screenWidth, double screenHeight) {
    var backgroundIndex = (_selectedDate.day % 17);
    var dayOfWeek = getNameDayOfWeek(_selectedDate);
    var quote = QuoteVO("", "");
    if (_quoteData.isNotEmpty) {
      quote = _quoteData[_selectedDate.day % _quoteData.length];
    }
    const dayOfWeekStyle = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 30,
    );

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const CalendarMonthScreen()));
      },
      child: SwipeDetector(
        onSwipeRight: () {
          _onSwipeRight();
        },
        onSwipeLeft: () {
          _onSwipeLeft();
        },
        child: FadeTransition(
          opacity: _animation,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/image_${backgroundIndex + 1}.jpg'),
                fit: BoxFit.cover,
              ),
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40)),
              //color: Colors.blue,
            ),
            height: (screenHeight * 77 / 104),
            width: double.infinity,
            child: Stack(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: StrokeText(
                        strokeWidth: 0,
                        fontSize: (screenHeight * 14 / 100),
                        color: Colors.white,
                        strokeColor: Colors.white,
                        fontWeight: FontWeight.w100,
                        text: '',
                        _selectedDate.day.toString(),
                      ),
                    ),
                    paddingText(5, dayOfWeek, dayOfWeekStyle),
                    SizedBox(
                      height: (screenHeight * 2 / 100),
                    ),
                    Platform.isIOS
                        ? Text(
                            _selectedDate.day.toString(),
                            style: const TextStyle(
                              fontSize: 140,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                              shadows: <Shadow>[
                                Shadow(
                                  offset: Offset(1.0, 1.0),
                                  blurRadius: 2.0,
                                  color: Colors.white,
                                ),
                                Shadow(
                                  offset: Offset(-1.0, -1.0),
                                  blurRadius: 2.0,
                                  color: Colors.white,
                                ),
                                Shadow(
                                  offset: Offset(1.0, -1.0),
                                  blurRadius: 2.0,
                                  color: Colors.white,
                                ),
                                Shadow(
                                  offset: Offset(-1.0, 1.0),
                                  blurRadius: 2.0,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          )
                        : Text(
                            _selectedDate.day.toString(),
                            style: const TextStyle(
                              fontSize: 120,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                              shadows: <Shadow>[
                                Shadow(
                                  offset: Offset(1.0, 1.0),
                                  blurRadius: 2.0,
                                  color: Colors.white,
                                ),
                                Shadow(
                                  offset: Offset(-1.0, -1.0),
                                  blurRadius: 2.0,
                                  color: Colors.white,
                                ),
                                Shadow(
                                  offset: Offset(1.0, -1.0),
                                  blurRadius: 2.0,
                                  color: Colors.white,
                                ),
                                Shadow(
                                  offset: Offset(-1.0, 1.0),
                                  blurRadius: 2.0,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),

                    // Text(
                    //   _selectedDate.day.toString(),
                    //   style: const TextStyle(
                    //       fontSize: 140,
                    //       fontWeight: FontWeight.bold,
                    //       color: Colors.red),
                    // ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: paddingText(
                          10,
                          quote.content,
                          const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(1.0, 1.0),
                                blurRadius: 1.0,
                                color: Colors.white,
                              ),
                              Shadow(
                                offset: Offset(-1.0, -1.0),
                                blurRadius: 1.0,
                                color: Colors.white,
                              ),
                              Shadow(
                                offset: Offset(1.0, -1.0),
                                blurRadius: 1.0,
                                color: Colors.white,
                              ),
                              Shadow(
                                offset: Offset(-1.0, 1.0),
                                blurRadius: 1.0,
                                color: Colors.white,
                              ),
                            ],
                          )),
                    ),
                    Platform.isIOS
                        ? Align(
                            alignment: Alignment.centerRight,
                            child: paddingText(
                                10,
                                quote.author,
                                const TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  shadows: <Shadow>[
                                    Shadow(
                                      offset: Offset(1.0, 1.0),
                                      blurRadius: 1.0,
                                      color: Colors.white,
                                    ),
                                    Shadow(
                                      offset: Offset(-1.0, -1.0),
                                      blurRadius: 1.0,
                                      color: Colors.white,
                                    ),
                                    Shadow(
                                      offset: Offset(1.0, -1.0),
                                      blurRadius: 1.0,
                                      color: Colors.white,
                                    ),
                                    Shadow(
                                      offset: Offset(-1.0, 1.0),
                                      blurRadius: 1.0,
                                      color: Colors.white,
                                    ),
                                  ],
                                )),
                          )
                        : Align(
                            alignment: Alignment.centerRight,
                            child: paddingText(
                                3,
                                quote.author,
                                const TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  shadows: <Shadow>[
                                    Shadow(
                                      offset: Offset(1.0, 1.0),
                                      blurRadius: 1.0,
                                      color: Colors.white,
                                    ),
                                    Shadow(
                                      offset: Offset(-1.0, -1.0),
                                      blurRadius: 1.0,
                                      color: Colors.white,
                                    ),
                                    Shadow(
                                      offset: Offset(1.0, -1.0),
                                      blurRadius: 1.0,
                                      color: Colors.white,
                                    ),
                                    Shadow(
                                      offset: Offset(-1.0, 1.0),
                                      blurRadius: 1.0,
                                      color: Colors.white,
                                    ),
                                  ],
                                )),
                          ),
                    Platform.isIOS
                        ? SizedBox(
                            height: (screenHeight * 2 / 100),
                          )
                        : SizedBox(
                            height: (screenHeight * 2 / 160),
                          ),
                    getDateInfo(screenHeight)
                  ],
                ),
                getHeader(context, screenHeight, screenWidth),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget boxButton(String image, String text, Function() onTap) {
    return Row(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.white),
            width: 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(height: 57, width: 57, image: AssetImage(image)),
                Text(
                  text,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
      ],
    );
  }

  Widget infoBox(Widget widget, bool hasBorder) {
    return Expanded(
        child: Container(
      padding: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
          border: Border(
              right: BorderSide(color: Colors.grey, width: hasBorder ? 1 : 0))),
      child: widget,
    ));
  }

  Widget getDateInfo(double height) {
    var headerStyle =
        const TextStyle(color: Colors.white, fontWeight: FontWeight.bold);
    var bodyStyle = const TextStyle(
        color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16);
    var bottomStyle = const TextStyle(color: Colors.white);
    var dayStyle = const TextStyle(
        color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold);
    var hourMinute = '${_selectedDate.hour}:${_selectedDate.minute}';
    var lunarDates = convertSolar2Lunar(
        _selectedDate.day, _selectedDate.month, _selectedDate.year, 7);
    var lunarDay = lunarDates[0];
    var lunarMonth = lunarDates[1];
    var lunarYear = lunarDates[2];
    var lunarMonthName = getCanChiMonth(lunarMonth, lunarYear);

    var jd = jdn(_selectedDate.day, _selectedDate.month, _selectedDate.year);
    var dayName = getCanDay(jd);
    var beginHourName = getBeginHour(jd);
    return Container(
      height: (height * 10 / 100),
      color: Colors.black.withOpacity(0.3),
      child: (IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            infoBox(
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text("Ngày", style: headerStyle),
                    Text(lunarDay.toString(), style: dayStyle),
                    Text(dayName, style: bottomStyle),
                  ],
                ),
                true),
            infoBox(
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text("Tháng", style: headerStyle),
                    Text(lunarMonth.toString(), style: dayStyle),
                    Text(lunarMonthName, style: bottomStyle),
                  ],
                ),
                false),
            infoBox(
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text("Giờ hoàng đạo", style: headerStyle),
                    Text(hourMinute, style: bodyStyle),
                    Text(beginHourName, style: bottomStyle),
                  ],
                ),
                true),
          ],
        ),
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;

    super.build(context);
    return Stack(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                image: DecorationImage(
                    image: AssetImage('assets/images/backgroud.jpg'),
                    fit: BoxFit.cover),
                // gradient: LinearGradient(
                //   begin: Alignment.topLeft,
                //   end: Alignment(0.8, 1),
                //   colors: <Color>[
                //     Color(0xffF7E3D7),
                //     Color(0xffFFA877),
                //     Color(0xffFBBA95),
                //     Color(0xffEF6518),
                //   ],
                //   tileMode: TileMode.mirror,
                // ),
              ),
            ),
            Positioned(
                bottom: 20,
                right: 10,
                left: 10,
                child: SizedBox(
                  width: (screenWidth * 10 / 100),
                  height: Platform.isIOS
                      ? (screenHeight * 10 / 100)
                      : (screenHeight * 10 / 85),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      InkWell(
                        child: boxButton(
                          'assets/icons/icontuvi.png',
                          'Tử vi mỗi ngày',
                          () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const TuViHangNgayScreen(),
                                ));
                          },
                        ),
                      ),
                      InkWell(
                        child: boxButton(
                          'assets/icons/iconngaytot.png',
                          'Xem ngày tốt',
                          () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const XemNgayTotScreen(),
                                ));
                          },
                        ),
                      ),
                      InkWell(
                        child: boxButton(
                          'assets/icons/icontrondoi.png',
                          'Tử vi trọn đời',
                          () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const TuViTronDoiScreen(),
                                ));
                          },
                        ),
                      ),
                      InkWell(
                        child: boxButton(
                          'assets/icons/iconvankhan.png',
                          'Văn khấn',
                          () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const VanKhan(),
                                ));
                          },
                        ),
                      ),
                      InkWell(
                        child: boxButton(
                          'assets/icons/icongiaimong.png',
                          'Giải mộng',
                          () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const GiaiMongScreen(),
                                ));
                          },
                        ),
                      ),
                      InkWell(
                        child: boxButton(
                          'assets/icons/iconxinxam.png',
                          'Xin xăm',
                          () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const XinXamScreen(),
                                ));
                          },
                        ),
                      ),
                      // InkWell(
                      //   child: boxButton(
                      //     'assets/icons/iconngaytot.png',
                      //     'Xem Ngày tốt',
                      //     () {
                      //       Navigator.push(
                      //           context,
                      //           MaterialPageRoute(
                      //             builder: (context) =>
                      //                 const XemNgayTotScreen(),
                      //           ));
                      //     },
                      //   ),
                      // ),
                      // InkWell(
                      //   child: boxButton(
                      //     'assets/icons/iconngaytot.png',
                      //     'Bói Bài',
                      //     () {
                      //       Navigator.push(
                      //           context,
                      //           MaterialPageRoute(
                      //             builder: (context) => const VanKhan(),
                      //           ));
                      //     },
                      //   ),
                      // ),
                    ],
                  ),
                )),
          ],
        ),
        Stack(
          children: [
            getMainDate(screenWidth, screenHeight),
          ],
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
