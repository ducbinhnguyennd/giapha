import 'package:flutter/material.dart';

class ChiTietXinXam extends StatefulWidget {
  const ChiTietXinXam(
      {super.key,
      required this.ten,
      required this.noidung,
      required this.ten1});
  final String ten;
  final String ten1;
  final String noidung;

  @override
  State<ChiTietXinXam> createState() => _ChiTietXinXamState();
}

class _ChiTietXinXamState extends State<ChiTietXinXam> {
  final ValueNotifier<double> fontSizeNotifier = ValueNotifier<double>(16);

  void increaseFontSize() {
    if (fontSizeNotifier.value < 24.0) {
      fontSizeNotifier.value += 1.0;
    }
  }

  void decreaseFontSize() {
    if (fontSizeNotifier.value > 12.0) {
      fontSizeNotifier.value -= 1.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffFBBA95),
        automaticallyImplyLeading: false,
        title: const Text(
          'Chi tiết quẻ',
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_outlined,
            color: Colors.black,
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment(0.8, 1),
                colors: <Color>[
                  Color(0xffF7E3D7),
                  Color(0xffFFA877),
                  Color(0xffFBBA95),
                  Color(0xffEF6518),
                ],
                tileMode: TileMode.mirror,
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          widget.ten1,
                          style: const TextStyle(
                              color: Color(0xffFF5C00),
                              fontSize: 28,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'CCGabrielBautistaLito'),
                        ),
                        Text(
                          widget.ten,
                          style: const TextStyle(
                            color: Color(0xffFF5C00),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ValueListenableBuilder(
                        valueListenable: fontSizeNotifier,
                        builder: (context, fontSize, _) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              widget.noidung.replaceAll("\\n", "\n"),
                              style: TextStyle(
                                  fontSize: fontSize,
                                  fontWeight: FontWeight.w400),
                            ),
                          );
                        }),
                  ),
                  const SizedBox(
                    height: 200,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 10,
            bottom: 40,
            child: Column(
              children: [
                TextButton(
                  onPressed: increaseFontSize,
                  child: const Icon(
                    Icons.add_circle,
                    color: Colors.yellow,
                  ),
                ),
                TextButton(
                  onPressed: decreaseFontSize,
                  child: const Icon(
                    Icons.remove_circle,
                    color: Colors.yellow,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
