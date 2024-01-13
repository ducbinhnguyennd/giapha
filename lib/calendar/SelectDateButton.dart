import 'package:flutter/material.dart';

class SelectDateButton extends StatelessWidget {
  const SelectDateButton(
      {super.key, required this.title, required this.onPress});

  final String title;
  final Function onPress;
  @override
  Widget build(BuildContext context) {
    var textStyle = const TextStyle(
        color: Color(0xffEF6518), fontSize: 17, fontWeight: FontWeight.bold);
    return GestureDetector(
      onTap: () {
        onPress();
      },
      child: Container(
        height: 40,
        width: 190,
        padding: const EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          border: Border.all(
              color: const Color(0xffEF6518),
              width: 1.0,
              style: BorderStyle.solid),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(child: Text(title, style: textStyle)),
            const Icon(
              Icons.arrow_drop_down,
              size: 30,
              color: Color(0xffEF6518),
            )
          ],
        ),
      ),
    );
  }
}
