import 'package:flutter/material.dart';
import 'package:giapha/model/Data/DataTuViTronDoi.dart';
import 'package:giapha/model/ReadData/ModelTuViTronDoi.dart';
import 'package:giapha/screens/services_screen/trondoi/test.dart';
import 'package:giapha/screens/services_screen/trondoi/tongquan.dart';

class TuViTronDoiScreen extends StatefulWidget {
  const TuViTronDoiScreen({super.key});

  @override
  State<TuViTronDoiScreen> createState() => _TuViTronDoiScreenState();
}

class _TuViTronDoiScreenState extends State<TuViTronDoiScreen> {
  bool isSelectedNam = false;
  bool isSelectedNu = false;
  List<int> yearList = [];
  int startYear = 1996;
  // int endYear = DateTime.now().year;
  int endYear = 2005;

  int selectedYear = 0;
  final List<ItemModelTuViTronDoi> _items = itemListTuViTronDoi;
  final ValueNotifier<double> fontSizeNotifier = ValueNotifier<double>(16);

  void increaseFontSize() {
    if (fontSizeNotifier.value < 18) {
      fontSizeNotifier.value += 1.0;
    }
  }

  void decreaseFontSize() {
    if (fontSizeNotifier.value > 12.0) {
      fontSizeNotifier.value -= 1.0;
    }
  }

  @override
  void initState() {
    isSelectedNam = true;
    // selectedYear = DateTime.now().year;
    selectedYear = 2005;
    for (int year = startYear; year <= endYear; year++) {
      yearList.add(year);
    }
    super.initState();
  }

  Widget boxBox(String text, String text2) {
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
            child: Text(
              text,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
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

  Widget boxBox2(String i, String i1) {
    return Row(children: [
      ValueListenableBuilder(
          valueListenable: fontSizeNotifier,
          builder: (context, fontSize, _) {
            return Text(
              i,
              style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w400,
                  color: Colors.red),
            );
          }),
      ValueListenableBuilder(
          valueListenable: fontSizeNotifier,
          builder: (context, fontSize, _) {
            return Text(
              i1,
              style: TextStyle(
                  fontSize: fontSize - 2, fontWeight: FontWeight.w400),
            );
          }),
    ]);
  }

  Widget boxBox3(String i, String i1) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ValueListenableBuilder(
              valueListenable: fontSizeNotifier,
              builder: (context, fontSize, _) {
                return Text(
                  i,
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: fontSize,
                      fontWeight: FontWeight.w400),
                );
              }),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ValueListenableBuilder(
              valueListenable: fontSizeNotifier,
              builder: (context, fontSize, _) {
                return Text(
                  i1,
                  style: TextStyle(
                      fontSize: fontSize - 2, fontWeight: FontWeight.w400),
                );
              }),
        ),
      ],
    );
  }

  Widget listTuVi(
      String text,
      String text1,
      String text2,
      String text3,
      String text4,
      String text5,
      String text6,
      String text7,
      String text8,
      String text9) {
    return Column(
      children: [
        ListTongQuan(
          text: 'Tổng quan',
          text1: ValueListenableBuilder(
              valueListenable: fontSizeNotifier,
              builder: (context, fontSize, _) {
                return Text(
                  text,
                  style: TextStyle(
                      fontSize: fontSize, fontWeight: FontWeight.w400),
                );
              }),
        ),
        ListTongQuan(
          text: 'Cuộc sống',
          text1: ValueListenableBuilder(
              valueListenable: fontSizeNotifier,
              builder: (context, fontSize, _) {
                return Text(
                  text1,
                  style: TextStyle(
                      fontSize: fontSize, fontWeight: FontWeight.w400),
                );
              }),
        ),
        ListTongQuan(
          text: 'Tình yêu',
          text1: ValueListenableBuilder(
              valueListenable: fontSizeNotifier,
              builder: (context, fontSize, _) {
                return Text(
                  text2,
                  style: TextStyle(
                      fontSize: fontSize, fontWeight: FontWeight.w400),
                );
              }),
        ),
        ListTongQuan(
          text: 'Gia đạo, Công danh',
          text1: ValueListenableBuilder(
              valueListenable: fontSizeNotifier,
              builder: (context, fontSize, _) {
                return Text(
                  text3,
                  style: TextStyle(
                      fontSize: fontSize, fontWeight: FontWeight.w400),
                );
              }),
        ),
        ListTongQuan(
          text: 'Những tuổi hợp làm ăn',
          text1: ValueListenableBuilder(
              valueListenable: fontSizeNotifier,
              builder: (context, fontSize, _) {
                return Text(
                  text4,
                  style: TextStyle(
                      fontSize: fontSize, fontWeight: FontWeight.w400),
                );
              }),
        ),
        ListTongQuan(
          text: 'Lựa chọn vợ chồng',
          text1: ValueListenableBuilder(
              valueListenable: fontSizeNotifier,
              builder: (context, fontSize, _) {
                return Text(
                  text5,
                  style: TextStyle(
                      fontSize: fontSize, fontWeight: FontWeight.w400),
                );
              }),
        ),
        ListTongQuan(
          text: 'Tuổi đại kỵ',
          text1: ValueListenableBuilder(
              valueListenable: fontSizeNotifier,
              builder: (context, fontSize, _) {
                return Text(
                  text6,
                  style: TextStyle(
                      fontSize: fontSize, fontWeight: FontWeight.w400),
                );
              }),
        ),
        ListTongQuan(
          text: 'Năm khó khăn',
          text1: ValueListenableBuilder(
              valueListenable: fontSizeNotifier,
              builder: (context, fontSize, _) {
                return Text(
                  text7,
                  style: TextStyle(
                      fontSize: fontSize, fontWeight: FontWeight.w400),
                );
              }),
        ),
        ListTongQuan(
          text: 'Ngày giờ xuất hành đẹp',
          text1: ValueListenableBuilder(
              valueListenable: fontSizeNotifier,
              builder: (context, fontSize, _) {
                return Text(
                  text8,
                  style: TextStyle(
                      fontSize: fontSize, fontWeight: FontWeight.w400),
                );
              }),
        ),
        ListTongQuan(
          text: 'Diễn biến từng năm',
          text1: ValueListenableBuilder(
              valueListenable: fontSizeNotifier,
              builder: (context, fontSize, _) {
                return Text(
                  text9,
                  style: TextStyle(
                      fontSize: fontSize, fontWeight: FontWeight.w400),
                );
              }),
        ),
      ],
    );
  }

  Widget listTuVi1(
    String text,
    String text1,
    String text2,
    String text3,
    String text4,
    String text5,
    String text6,
    String text7,
    String text8,
    double height,
  ) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          SizedBox(
            height: height,
          ),
          ValueListenableBuilder(
              valueListenable: fontSizeNotifier,
              builder: (context, fontSize, _) {
                return Text(
                  text,
                  style: TextStyle(
                      fontSize: fontSize + 4,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                );
              }),
          SizedBox(
            height: height / 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              boxBox3('Cung', text1),
              boxBox3('Trực', text2),
              boxBox3('Xương', text6),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: boxBox2('Mạng', text3),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: boxBox2('Khắc', text4),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: boxBox2('Con nhà', text5),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: boxBox2('Tướng tinh', text7),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: boxBox2('Độ mạng', text8),
          ),
          SizedBox(
            height: height * 2,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    List<ItemModelTuViTronDoi> listItem = _items.where((item) {
      // ignore: unrelated_type_equality_checks
      return item.nam == selectedYear.toString() &&
          (item.check == "Nam" && isSelectedNam == true ||
              item.check == 'Nữ' && isSelectedNu == true);
    }).toList();
    // print('tantan:${_items}');
    // print('${isSelectedNam},${isSelectedNu}');
    // print(listItem);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color(0xffFBBA95),
        automaticallyImplyLeading: false,
        title: const Text(
          'Tử vi trọn đời',
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
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/backgroud.jpg'),
              fit: BoxFit.cover),
        ),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 40,
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
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      isSelectedNam = true;
                                      isSelectedNu = false;
                                    });
                                  },
                                  style: ButtonStyle(
                                    elevation:
                                        const MaterialStatePropertyAll(0),
                                    shape: MaterialStatePropertyAll(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30))),
                                    backgroundColor: MaterialStateProperty.all(
                                      isSelectedNam
                                          ? const Color(0xffF27E3C)
                                          : const Color(0xffFCCDB3),
                                    ),
                                  ),
                                  child: Text(
                                    'Nam',
                                    style: TextStyle(
                                      color: isSelectedNam
                                          ? Colors.black
                                          : Colors.grey,
                                    ),
                                  )),
                              ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      isSelectedNam = false;
                                      isSelectedNu = true;
                                    });
                                  },
                                  style: ButtonStyle(
                                    shape: MaterialStatePropertyAll(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30))),
                                    elevation:
                                        const MaterialStatePropertyAll(0),
                                    backgroundColor: MaterialStateProperty.all(
                                      isSelectedNu
                                          ? const Color(0xffF27E3C)
                                          : const Color(0xffFCCDB3),
                                    ),
                                  ),
                                  child: Text(
                                    'Nữ',
                                    style: TextStyle(
                                      color: isSelectedNu
                                          ? Colors.black
                                          : Colors.grey,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          height: 40,
                          width: 131,
                          padding: const EdgeInsets.only(
                              top: 5, bottom: 5, left: 10, right: 10),
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
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    backgroundColor: const Color(0xffFBBA95),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      height: (screenHeight * 30 / 100),
                                      width: (screenWidth * 30 / 100),
                                      child: Column(
                                        children: [
                                          Expanded(
                                            flex: 9,
                                            child: ListView.builder(
                                              itemCount: yearList.length,
                                              itemBuilder: (context, index) {
                                                return Column(
                                                  children: [
                                                    ListTile(
                                                      title: Center(
                                                        child: Text(
                                                          yearList[index]
                                                              .toString(),
                                                          style: const TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ),
                                                      onTap: () {
                                                        setState(() {
                                                          selectedYear =
                                                              yearList[index];
                                                          Navigator.pop(context,
                                                              yearList[index]);
                                                        });
                                                      },
                                                    ),
                                                    const Divider(
                                                      // Thêm Divider sau mỗi ListTile
                                                      color: Colors
                                                          .grey, // Màu sắc của đường kẻ
                                                      thickness:
                                                          1.0, // Độ dày của đường kẻ
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                          ),
                                          Expanded(
                                              flex: 1,
                                              child: Center(
                                                child: Text(
                                                  'Chọn năm',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ))
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    selectedYear != 0
                                        ? selectedYear.toString()
                                        : "Vui lòng chọn",
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  const Image(
                                      image: AssetImage(
                                          'assets/icons/namtrondoi.png'))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: listItem.length,
                    itemBuilder: (context, index) {
                      return Test(
                        text: listItem[index].a,
                        text1: listItem[index].ten,
                        text2: 'listItem',
                        text3: listTuVi1(
                          listItem[index].nam,
                          listItem[index].cung,
                          listItem[index].truc,
                          listItem[index].mang,
                          listItem[index].khac,
                          listItem[index].connha,
                          listItem[index].xuong,
                          listItem[index].tuong,
                          listItem[index].domang,
                          (screenHeight * 10 / 100),
                        ),
                        height: screenHeight,
                        width: screenWidth,
                        image: listItem[index].image,
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: listItem.length,
                    itemBuilder: (context, index) {
                      return listTuVi(
                          listItem[index].tongquat,
                          listItem[index].cuocsong,
                          listItem[index].tinhduyen,
                          listItem[index].giadao,
                          listItem[index].tuoihop,
                          listItem[index].vochong,
                          listItem[index].tuoiky,
                          listItem[index].namkhokhan,
                          listItem[index].gioxuathanh,
                          listItem[index].dientien);
                    },
                  ),
                ],
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
      ),
    );
  }
}
