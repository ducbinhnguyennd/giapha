import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:giapha/api_all/apitrangchu.dart';
import 'package:giapha/constant/asset_path_const.dart';
import 'package:giapha/constant/colors_const.dart';
import 'package:giapha/model/chitietUser_model.dart';
import 'package:giapha/screens/giapha_screen/item_chitiet.dart';

class ItemCayGiaPha extends StatefulWidget {
  const ItemCayGiaPha({
    super.key,
    required this.name,
    required this.date,
    required this.relationship,
    required this.onTap,
    required this.avatar,
    required this.id,
    // required this.onTap1
  });
  final String name;
  final String date;
  final String relationship;
  final String avatar;
  final String id;

  final VoidCallback onTap;
  // final VoidCallback onTap1;

  @override
  State<ItemCayGiaPha> createState() => _ItemCayGiaPhaState();
}

class _ItemCayGiaPhaState extends State<ItemCayGiaPha> {
  late ApiChitietPerson apiChitietPerson;
  late ChitietPerson personData;
  @override
  void initState() {
    super.initState();
    apiChitietPerson = ApiChitietPerson();
    _fetchPersonData();
  }

  Future<void> _fetchPersonData() async {
    try {
      final fetchedData = await apiChitietPerson.fetchPersonData(widget.id);
      setState(() {
        personData = fetchedData;
      });
    } catch (e) {
      print('Error: $e');
      // Xử lý lỗi nếu cần
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: 230,
      height: 100,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            AssetsPathConst.khungho,
          ),
          fit: BoxFit.fill,
        ),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                // InkWell(
                //   onTap: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => ItemChiTiet(
                //                 id: widget.id,
                //                 avatar: widget.avatar,
                //               )),
                //     );
                //   },
                //   child: Text(
                //     'Xem chi tiết',
                //     style: TextStyle(
                //       color: Colors.black,
                //       fontSize: 12,
                //     ),
                //   ),
                // ),
                /////////

                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            content: Stack(
                          children: [
                            Container(
                              height: 300,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        AssetsPathConst.khungthongtin),
                                    fit: BoxFit.fill),
                              ),
                            ),
                            Positioned(
                              top: 30,
                              left: 10,
                              right: 5,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 95,
                                    width: 75,
                                    color: Colors.red,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: widget.avatar == ''
                                          ? Center(
                                              child: Text(
                                                widget.name.substring(0, 1),
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 30,
                                                  color: ColorConst
                                                      .colorBackgroundStory,
                                                ),
                                              ),
                                            )
                                          : Container(
                                              height: 95,
                                              width: 55,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  image: MemoryImage(
                                                      base64Decode(
                                                          widget.avatar)),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.name,
                                          style: TextStyle(color: Colors.black),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                        Text(
                                          'Năm sinh: ${widget.date}',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                        personData.dead == true
                                            ? Text(
                                                'Năm mất: ${personData.deadInfo.deadDate}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              )
                                            : Container(),
                                        Text(
                                          'Giới tính: ${personData.sex}',
                                          style: TextStyle(color: Colors.black),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                        Text(
                                          'Học vấn: ${personData.academicLevel}',
                                          style: TextStyle(color: Colors.black),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                        personData.dead == true
                                            ? Text(
                                                'Thọ: ${personData.deadInfo.lived} tuổi',
                                                style: TextStyle(
                                                    color: const Color.fromARGB(
                                                        255, 12, 6, 6)),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              )
                                            : Container(),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ));
                      },
                    );
                  },
                  child: Text(
                    'Xem chi tiết',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                ),

                Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    boxShadow: const <BoxShadow>[
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.17),
                        blurRadius: 10,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: widget.avatar == ''
                        ? Center(
                            child: Text(
                              widget.name.substring(0, 1),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: ColorConst.colorBackgroundStory,
                              ),
                            ),
                          )
                        : Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: MemoryImage(base64Decode(widget.avatar)),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: widget.onTap,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.date,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    widget.relationship,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
