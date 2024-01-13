import 'package:flutter/material.dart';
import 'package:giapha/screens/calendar_month/tinhtuvi/checktuoi.dart';

class GioHoangDao extends StatelessWidget {
  const GioHoangDao(
      {super.key,
      required this.text,
      required this.text1,
      required this.text2,
      required this.text3,
      required this.text4,
      required this.text5,
      required this.text6,
      required this.text7,
      required this.text8,
      required this.text9,
      required this.text10,
      required this.text11});

  final String text;
  final String text1;
  final String text2;
  final String text3;
  final String text4;
  final String text5;
  final String text6;
  final String text7;
  final String text8;
  final String text9;
  final String text10;
  final String text11;

  @override
  Widget build(BuildContext context) {
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
      child: Column(
        children: [
          const SizedBox(
            height: 18,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Image(
                      height: 50,
                      width: 50,
                      image: AssetImage(
                        getCheckTuoi(text),
                      )),
                  Text(
                    text,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                  Text(
                    text6,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                ],
              ),
              Column(
                children: [
                  Image(
                      height: 50,
                      width: 50,
                      image: AssetImage(
                        getCheckTuoi(text2),
                      )),
                  Text(
                    text2,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                  Text(
                    text8,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                ],
              ),
              Column(
                children: [
                  Image(
                      height: 50,
                      width: 50,
                      image: AssetImage(
                        getCheckTuoi(text4),
                      )),
                  Text(
                    text4,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                  Text(
                    text10,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                ],
              ),
              Column(
                children: [
                  Image(
                      height: 50,
                      width: 50,
                      image: AssetImage(
                        getCheckTuoi(text7),
                      )),
                  Text(
                    text7,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                  Text(
                    text1,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                ],
              ),
              Column(
                children: [
                  Image(
                      height: 50,
                      width: 50,
                      image: AssetImage(
                        getCheckTuoi(text9),
                      )),
                  Text(
                    text9,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                  Text(
                    text3,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                ],
              ),
              Column(
                children: [
                  Image(
                      height: 50,
                      width: 50,
                      image: AssetImage(
                        getCheckTuoi(text11),
                      )),
                  Text(
                    text11,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                  Text(
                    text5,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
