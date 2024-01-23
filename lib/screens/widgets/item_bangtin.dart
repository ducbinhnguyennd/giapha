import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:giapha/api_all/apitrangchu.dart';
import 'package:giapha/constant/asset_path_const.dart';
import 'package:giapha/constant/colors_const.dart';
import 'package:giapha/constant/common_service.dart';
import 'package:giapha/constant/strings_const.dart';

import 'package:giapha/model/bangtin_model.dart';
import 'package:giapha/model/user_model.dart';
import 'package:giapha/routes.dart';

// ignore: must_be_immutable
class ItemBangTin extends StatefulWidget {
  ItemBangTin(
      {Key? key,
      required this.username,
      this.like,
      required this.content,
      required this.date,
      required this.cmt,
      this.userid,
      required this.idbaiviet,
      required this.isLike,
      required this.comments,
      this.widgetDelete,
      this.widgetPostCM,
      required this.avatar,
      required this.role,
      required this.useridbaiviet,
      required this.images})
      : super(key: key);

  final String? username;
  int? like;
  final String? content;
  final String? date;
  final String? cmt;
  final String? userid;
  final String? idbaiviet;
  final String? useridbaiviet;
  final String? avatar;
  final String? role;

  bool isLike = false;

  final List<Comment> comments;
  List<String>? images;
  Widget? widgetDelete;
  Widget? widgetPostCM;

  @override
  _ItemBangTinState createState() => _ItemBangTinState();
}

class _ItemBangTinState extends State<ItemBangTin> {
  bool isFollowing = false;
  Data? currentUser;
  LikeApiService likeApiService = LikeApiService();
  void toggleFollowStatus() {
    setState(() {
      isFollowing = !isFollowing;
    });
  }

  void toggleLike() {
    if (widget.userid != null) {
      if (!widget.isLike) {
        // If the post is not liked, allow the user to like it
        setState(() {
          widget.isLike = true;

          widget.like = widget.like! + 1;
        });

        likeApiService.likeBaiViet(widget.userid ?? '', widget.idbaiviet ?? '');
      } else {
        _showToast("Bạn đã thích bài viết này");
      }
    } else {
      _showToast(StringConst.textyeucaudangnhap);
    }
  }

  void _showToast(String msg) {
    if (msg.contains(StringConst.textyeucaudangnhap)) {
      CommonService.showSnackBar(StringConst.textyeucaudangnhap, context, () {
        RouteUtil.redirectToLoginScreen(context);
      });
      return;
    }

    CommonService.showToast(msg, context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8.0, 8.0, 8.0),
                child: ClipOval(
                  child: widget.avatar == ''
                      ? CircleAvatar(
                          backgroundColor: ColorConst.colorPrimary,
                          child: Text(
                            widget.username?.substring(0, 1) ?? '',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        )
                      : Container(
                          height: 40,
                          width: 40,
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        widget.username ?? '',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 5),
                      (widget.role == 'admin')
                          ? Image.asset(
                              AssetsPathConst.tichxanh,
                              height: 18,
                            )
                          : Container()
                    ],
                  ),
                  Text(
                    widget.date ?? '2023-11-18T04:38:10.828Z',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Spacer(),
              widget.widgetDelete ?? Container()
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 15.0, 10.0),
            child: Text(
              widget.content ?? '',
              style: TextStyle(fontSize: 15),
            ),
          ),
          for (String imageBase64 in widget.images!)
            Hero(
              tag: 'image_hero_${widget.idbaiviet}_$imageBase64',
              child: Material(
                child: Center(
                  child: Image.memory(
                    base64Decode(imageBase64),
                    height: MediaQuery.of(context).size.height / 2,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${widget.like} lượt thích'),
                Text('${widget.cmt} bình luận')
              ],
            ),
          ),
          Divider(
            color: Colors.grey,
            thickness: 1,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: toggleLike,
                      child: Icon(
                        widget.isLike ? Icons.favorite : Icons.favorite_border,
                        color: widget.isLike
                            ? ColorConst.colorPrimary50
                            : Colors.grey[350],
                        size: 25,
                      ),
                    ),
                    widget.isLike ? Text(' Đã Thích') : Text(' Thích')
                  ],
                ),
                widget.widgetPostCM ?? Container(),
                InkWell(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => ReportScreen(
                    //       baivietID: widget.idbaiviet ?? '',
                    //       userID: widget.userid ?? '',
                    //     ),
                    //   ),
                    // );
                  },
                  child: Row(
                    children: [
                      Icon(Icons.report, size: 25, color: Colors.grey[350]),
                      Text(' Report')
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: ColorConst.colorPrimary80,
            thickness: 5,
          ),
        ],
      ),
    );
  }
}
