import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class NgayTotChiTiet extends StatefulWidget {
  const NgayTotChiTiet({super.key});

  @override
  State<NgayTotChiTiet> createState() => _NgayTotChiTietState();
}

class _NgayTotChiTietState extends State<NgayTotChiTiet> {
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

  Widget boxBox(String text, String text1, String text2) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            padding:
                const EdgeInsets.only(top: 5, bottom: 5, right: 10, left: 10),
            decoration: BoxDecoration(
                color: const Color(0xffFFA877),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.black)),
            child: Column(
              children: [
                Text(
                  text,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.w400),
                ),
                Text(
                  text1,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          ValueListenableBuilder(
            valueListenable: fontSizeNotifier,
            builder: (context, fontSize, _) {
              return Text(
                text2,
                style: TextStyle(fontSize: fontSize),
              );
            },
          ),
          const SizedBox(
            height: 10,
          ),
          Divider(
            height: 5,
            thickness: 2,
            endIndent: 0,
            color: Colors.blue[200],
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
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
          title: const Text(
            'Xem ngày tốt',
            style: TextStyle(color: Colors.black, fontSize: 20),
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
            SingleChildScrollView(
              child: Container(
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
                child: Center(
                  child: Column(children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Stack(alignment: Alignment.center, children: [
                      Column(
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          Stack(
                            children: [
                              Container(
                                height: (screenHeight * 13 / 100),
                                width: (screenWidth * 30 / 100),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  ),
                                ),
                              ),
                              Container(
                                height: (screenHeight * 8 / 100),
                                width: (screenWidth * 30 / 100),
                                decoration: const BoxDecoration(
                                  color: Color(0xffEF6518),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Positioned(
                        top: 0,
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                              color: Colors.yellow,
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      ),
                    ]),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        boxBox('Condition', 'Nguyễn Bỉnh Khiêm', 'text'),
                        boxBox('Đổng Công', 'Soạn trạch nhật', 'text1'),
                        boxBox('Kiết hung tinh(Vạn sự)', '', 'text2'),
                        boxBox('Twelve Earthly Branches', '', 'text3'),
                        boxBox('Yin and Yang day', '', 'text4'),
                        boxBox('Twenty-Eight Constellations', '', 'text5'),
                        boxBox('Zodiac, Black Zodiac', '', 'text6'),
                        boxBox('Ngày lục nhâm', '', 'text7'),
                        boxBox('Can', '', 'text8'),
                        boxBox('Chi', '', 'text9'),
                        boxBox('Nạp âm ngày', '', 'text9'),
                      ],
                    ),
                  ]),
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
        ));
  }
}
