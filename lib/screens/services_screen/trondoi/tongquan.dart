import 'package:flutter/material.dart';

class ListTongQuan extends StatelessWidget {
  const ListTongQuan({super.key, required this.text, required this.text1});

  final String text;
  final Widget text1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
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
            )),
            // Column(
            //   children: [
            //     Container(
            //       height: 15,
            //     ),
            //     const Divider(
            //       height: 5,
            //       thickness: 2,
            //       indent: 120,
            //       endIndent: 0,
            //       color: Colors.white,
            //     ),
            //     // Container(),
            //   ],
            // ),
          ],
        ),
        const SizedBox(
          height: 27,
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: text1,
        ),
        const SizedBox(
          height: 40,
        )
      ],
    );
  }
}
