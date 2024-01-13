import 'dart:io';

import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  const Test({
    super.key,
    required this.text,
    required this.text1,
    required this.text2,
    required this.text3,
    required this.height,
    required this.width,
    required this.image,
  });
  final String image;
  final String text;
  final String text1;
  final String text2;
  final Widget text3;
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(
                height: (height * 3 / 100),
              ),
              Stack(
                children: [
                  Container(
                    height: (height * 60 / 100),
                    width: (width * 90 / 100),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: text2.length,
                      itemBuilder: (context, index) {
                        return text3;
                      },
                    ),
                  ),
                  Container(
                    height: (height * 8 / 100),
                    width: (width * 90 / 100),
                    decoration: BoxDecoration(
                      color: const Color(0xffFCCDB3),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: 20,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  text1,
                  style: const TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Platform.isIOS ? Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(90),
                        border: Border.all(color: Colors.black, width: 0.2)),
                  ): Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(90),
                        border: Border.all(color: Colors.black, width: 0.2)),
                  ),
                  Image(height: 90, width: 90, image: AssetImage(image)),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  text,
                  style: const TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
