import 'package:flutter/material.dart';
import 'package:giapha/calendar/constanst.dart';

class Header extends StatelessWidget {
  const Header(
      {super.key,
      required this.currentMonth,
      required this.onPreviousPress,
      required this.onNextPress});
  final DateTime currentMonth;
  final Function onPreviousPress;
  final Function onNextPress;
  @override
  Widget build(BuildContext context) {
    var month = currentMonth.month;
    var year = currentMonth.year;
    // var title = '${months[month - 1]} $year';
    var title = '${months[month - 1]}';
    const titleStyle = TextStyle(
        color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_left),
          iconSize: 30,
          color: Colors.black,
          onPressed: () {
            onPreviousPress();
          },
        ),
        Row(
          children: [
            Text(title, style: titleStyle),
            Text(' Năm ', style: titleStyle),
            Text('${year}', style: titleStyle),
          ],
        ),
        IconButton(
          icon: const Icon(Icons.arrow_right),
          iconSize: 30,
          color: Colors.black,
          onPressed: () {
            onNextPress();
          },
        ),
      ],
    );
  }
}
