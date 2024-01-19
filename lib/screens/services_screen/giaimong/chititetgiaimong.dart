import 'package:flutter/material.dart';

class ChiTietGiaiMong extends StatefulWidget {
  const ChiTietGiaiMong({
    super.key,
    required this.ten,
    required this.gioithieu,
  });

  final String ten;
  final String gioithieu;

  @override
  State<ChiTietGiaiMong> createState() => _ChiTietGiaiMongState();
}

class _ChiTietGiaiMongState extends State<ChiTietGiaiMong> {
  final ValueNotifier<double> fontSizeNotifier = ValueNotifier<double>(15);

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
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffFBBA95),
        automaticallyImplyLeading: false,
        title: Text(
          widget.ten,
          style: const TextStyle(color: Colors.black, fontSize: 20),
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
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  height: screenHeight,
                  width: screenWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0xffF7E3D7),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: SingleChildScrollView(
                      child: ValueListenableBuilder(
                          valueListenable: fontSizeNotifier,
                          builder: (context, fontSize, _) {
                            return Text(
                              widget.gioithieu.replaceAll("\\n\\n", "\n\n"),
                              style: TextStyle(
                                  fontSize: fontSize,
                                  fontWeight: FontWeight.w400),
                            );
                          }),
                    ),
                  ),
                ),
              )),
          Positioned(
            right: 10,
            bottom: 40,
            child: Column(
              children: [
                TextButton(
                  onPressed: increaseFontSize,
                  child: const Icon(
                    Icons.add_circle,
                    color: Colors.black,
                  ),
                ),
                TextButton(
                  onPressed: decreaseFontSize,
                  child: const Icon(
                    Icons.remove_circle,
                    color: Colors.black,
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
