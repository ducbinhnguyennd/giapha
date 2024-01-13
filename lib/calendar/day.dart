import 'package:flutter/material.dart';
import 'package:giapha/calendar/constanst.dart';
import 'package:giapha/calendar/dot.dart';
import 'package:giapha/calendar/utils.dart';
import 'package:giapha/utils/lunar_solar_utils.dart';

class Day extends StatefulWidget {
  const Day({
    super.key,
    required this.width,
    required this.date,
    required this.selectedDate,
    required this.currentCalendar,
    required this.onDayPress,
    required this.markedDays,
  });

  final double width;
  final DateTime date;
  final DateTime selectedDate;
  final DateTime currentCalendar;
  final Function onDayPress;
  final List<DateTime> markedDays;

  @override
  State<Day> createState() => _DayState();
}

class _DayState extends State<Day> {
  bool isSelected = false;

  bool checkMarked() {
    bool marked = false;
    for (var element in widget.markedDays) {
      if (element.day == widget.date.day &&
          element.month == widget.date.month) {
        marked = true;
      }
    }
    return marked;
  }

  @override
  Widget build(BuildContext context) {
    var notInMainCalendar = false;
    DateTime now = DateTime.now();
    var lunarDates = convertSolar2Lunar(
        widget.date.day, widget.date.month, widget.date.year, 7);
    var lunarDay = lunarDates[0];
    var lunarMonth = lunarDates[1];
    var boxColor = Colors.white;
    Color dotColor = DOT_COLOR;
    var textColor = DAY_TEXT_NORMAL;
    if (isOtherMonth(widget.date, widget.currentCalendar)) {
      // is other month
      notInMainCalendar = true;
    }
    if (equalDate(now, widget.date)) {
      boxColor = Colors.cyan[100]!;
      textColor = DAY_TEXT_SELECTED;
    }
    if (equalDate(widget.selectedDate, widget.date)) {
      boxColor = const Color(0xffFDDAA5);
      textColor = Colors.black;
    }
    var isShowDot = checkMarked();
    //dot color
    if (boxColor != Colors.transparent) {}
    if (notInMainCalendar) {
      textColor = DAY_TEXT_OTHER;
      isShowDot = false;
      boxColor = Colors.white;
    }
    if (widget.date.weekday == DateTime.saturday ||
        widget.date.weekday == DateTime.sunday) {
      textColor = Colors.red;
    }

    var dayStyle =
        TextStyle(fontSize: 18, color: textColor, fontWeight: FontWeight.bold);
    var lunarDayStyle = TextStyle(fontSize: 10, color: textColor);
    return GestureDetector(
      onTap: () {
        widget.onDayPress(widget.date);
      },
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 56,
                  width: 46,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10), color: boxColor),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.date.day.toString(),
                        style: dayStyle,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        '${lunarDay.toString()}/${lunarMonth.toString()}',
                        style: lunarDayStyle,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              right: 5,
              top: 5,
              child: Align(child: Dot(isShow: isShowDot, color: dotColor)),
            )
          ],
        ),
      ),
    );
  }
}
