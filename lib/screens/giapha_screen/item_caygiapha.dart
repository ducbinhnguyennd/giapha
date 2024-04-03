import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:giapha/constant/asset_path_const.dart';
import 'package:giapha/constant/colors_const.dart';

class ItemCayGiaPha extends StatefulWidget {
  const ItemCayGiaPha({
    super.key,
    required this.name,
    required this.date,
    required this.relationship,
    required this.onTap,
    required this.avatar,
    // required this.onTap1
  });
  final String name;
  final String date;
  final String relationship;
  final String avatar;

  final VoidCallback onTap;
  // final VoidCallback onTap1;

  @override
  State<ItemCayGiaPha> createState() => _ItemCayGiaPhaState();
}

class _ItemCayGiaPhaState extends State<ItemCayGiaPha> {
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
                InkWell(
                  onTap: () {},
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
                                image: MemoryImage(
                                    base64Decode(widget.avatar ?? '')),
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
