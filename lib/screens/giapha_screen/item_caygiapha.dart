import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:giapha/api_all/apitrangchu.dart';
import 'package:giapha/constant/asset_path_const.dart';
import 'package:giapha/constant/colors_const.dart';
import 'package:giapha/model/chitietUser_model.dart';

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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Stack(
                                        children: [
                                          Container(
                                            height: 95,
                                            width: 75,
                                            color: Colors.red,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              child: widget.avatar == ''
                                                  ? Center(
                                                      child: Text(
                                                        widget.name
                                                            .substring(0, 1),
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
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
                                                                  widget
                                                                      .avatar)),
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 5,
                                            bottom: 0,
                                            right: 0,
                                            child: personData.dead == true
                                                ? Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        color: Colors.black),
                                                    child: Text(
                                                      'Thọ: ${personData.deadInfo.lived} tuổi',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                    ),
                                                  )
                                                : Container(),
                                          )
                                        ],
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              widget.name,
                                              style: TextStyle(
                                                  color: Colors.black),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                            Text(
                                              'Giới tính: ${personData.sex}',
                                              style: TextStyle(
                                                  color: Colors.black),
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
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                  )
                                                : Container(),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'Học vấn: ',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        TextSpan(
                                          text: '${personData.academicLevel}',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ],
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'Giới thiệu: ',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        TextSpan(
                                          text: '${personData.bio}',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ],
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'Nghề nghiệp: ',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        TextSpan(
                                          text: '${personData.job}',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ],
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'Thường trú: ',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        TextSpan(
                                          text: '${personData.address}',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ],
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'Quê quán: ',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        TextSpan(
                                          text: '${personData.hometown}',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ],
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
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
                          // : Container(
                          //     height: 45,
                          //     width: 45,
                          //     decoration: BoxDecoration(
                          //       shape: BoxShape.circle,
                          //       image: DecorationImage(
                          //         image: MemoryImage(base64Decode(widget.avatar)),
                          //         fit: BoxFit.cover,
                          //       ),
                          //     ),
                          //   ),
                          : Center(
                              child: Text(
                                widget.name.substring(0, 1),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: ColorConst.colorBackgroundStory,
                                ),
                              ),
                            )),
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
