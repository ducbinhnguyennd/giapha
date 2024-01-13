import 'package:flutter/material.dart';

import '../tinhtuvi/checktuoixung.dart';

class TuoiXung extends StatelessWidget {
  const TuoiXung({
    super.key,
    required this.a1,
    required this.a2,
    required this.a3,
    required this.a4,
  });

  final String a1;
  final String a2;
  final String a3;
  final String a4;

  String getTextAfterSpace(String text) {
    List<String> words = text.split(" ");
    return words.length > 1 ? words[1] : "";
  }

  @override
  Widget build(BuildContext context) {
    print('tanvl : ${getTextAfterSpace(a1)}');
    print('tanvl : ${getTextAfterSpace(a2)}');
    print('tanvl : ${getTextAfterSpace(a3)}');
    print('tanvl : ${getTextAfterSpace(a4)}');
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Image(
                height: 60,
                width: 60,
                image: AssetImage(getCheckTuoiXung(getTextAfterSpace(a1)))),
            Text(
              a1,
              style: const TextStyle(
                  fontSize: 15, fontWeight: FontWeight.w400, color: Colors.red),
            ),
          ],
        ),
        Column(
          children: [
            Image(
                height: 60,
                width: 60,
                image: AssetImage(getCheckTuoiXung(getTextAfterSpace(a2)))),
            Text(
              a2,
              style: const TextStyle(
                  fontSize: 15, fontWeight: FontWeight.w400, color: Colors.red),
            ),
          ],
        ),
        Column(
          children: [
            Image(
                height: 60,
                width: 60,
                image: AssetImage(getCheckTuoiXung(getTextAfterSpace(a3)))),
            Text(
              a3,
              style: const TextStyle(
                  fontSize: 15, fontWeight: FontWeight.w400, color: Colors.red),
            ),
          ],
        ),
        Column(
          children: [
            Image(
                height: 60,
                width: 60,
                image: AssetImage(getCheckTuoiXung(getTextAfterSpace(a4)))),
            Text(
              a4,
              style: const TextStyle(
                  fontSize: 15, fontWeight: FontWeight.w400, color: Colors.red),
            ),
          ],
        ),
      ],
    );
  }
}
