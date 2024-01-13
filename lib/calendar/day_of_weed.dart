import 'package:flutter/material.dart';

class DayOfWeek extends StatelessWidget {
  const DayOfWeek({super.key, required this.title, required this.width});

  final String title;
  final double width;

  @override
  Widget build(BuildContext context) {
    Color textColor = Colors.black;
    if (title == 'T7' || title == 'CN') {
      textColor = Colors.red;
    }
    return SizedBox(
      width: 45,
      height: width,
      child: Center(
        child: Text(title.toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: DOW_TEXT_SIZE,
                color: textColor,
                fontWeight: FontWeight.bold)),
      ),
    );
  }
}
