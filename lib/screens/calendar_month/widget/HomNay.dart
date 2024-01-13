import 'package:flutter/material.dart';

class HomNay extends StatelessWidget {
  const HomNay(
      {super.key,
      required this.a,
      required this.a1,
      required this.a2,
      required this.a3,
      required this.a4,
      required this.a5,
      required this.a6});

  final String a;
  final String a1;
  final String a2;
  final String a3;
  final String a4;
  final String a5;
  final String a6;

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
      child: Column(children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          a,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                const Text(
                  'Day',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  a1,
                  style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w400,
                      color: Colors.red),
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  a4,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
              ],
            ),
            Column(
              children: [
                const Text(
                  'Month',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  a2,
                  style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w400,
                      color: Colors.red),
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  a5,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
              ],
            ),
            Column(
              children: [
                const Text(
                  'Year',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  a3,
                  style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w400,
                      color: Colors.red),
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  a6,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
              ],
            ),
          ],
        )
      ]),
    );
  }
}
