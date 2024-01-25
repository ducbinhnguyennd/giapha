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
import 'package:giapha/screens/bangtin_screen/binhluan_screen.dart';
import 'package:giapha/screens/bangtin_screen/postbai.dart';
import 'package:giapha/screens/bangtin_screen/thongbao_screen.dart';
import 'package:giapha/screens/widgets/item_bangtin.dart';
import 'package:giapha/user_Service.dart';

class BangTinScreen extends StatefulWidget {
  const BangTinScreen({Key? key}) : super(key: key);
  static const routeName = 'bangtin';

  @override
  State<BangTinScreen> createState() => _BangTinScreenState();
}

class _BangTinScreenState extends State<BangTinScreen>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  Data? currentUser;
  int selectedTabIndex = 0;
  bool nutlike = false;
  Bangtin? bangtin;
  ApiBangTinDaLog apiBangTinDaLog = ApiBangTinDaLog();
  bool isLoading = false;
  List<Bangtin> posts = [];

  Future<void> _refresh() async {
    await _loadUser();
  }

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _loadUser() async {
    UserServices us = UserServices();
    us.getInfoLogin().then((value) {
      if (value != "") {
        setState(() {
          currentUser = Data.fromJson(jsonDecode(value));
          nutlike = bangtin?.isLiked ?? false;
        });
      } else {
        setState(() {
          currentUser = null;
        });
      }
    }, onError: (error) {}).then((value) async {
      print('userid: ${currentUser?.user[0].id}');
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: ColorConst.colorPrimary50,
        elevation: 0,
        title: Text(
          'Bảng tin',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: RefreshIndicator(
        color: ColorConst.colorPrimary120,
        onRefresh: _refresh,
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 13,
              color: Colors.grey[200],
              child: Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Xin chào',
                            style: TextStyle(fontSize: 12),
                          ),
                          Text(
                            currentUser?.user[0].username ?? 'bạn',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 19),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      )),
                  Expanded(
                    flex: 8,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 13.0, 8.0, 13.0),
                      child: InkWell(
                        onTap: () {
                          if (currentUser != null &&
                              currentUser!.user != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PostBaiVietScreen(
                                      userId: currentUser?.user[0].id ?? '')),
                            ).then((result) {
                              if (result.dataToPass == true) {
                                setState(() {
                                  _loadUser();
                                });
                              }
                            });
                          } else {
                            CommonService.showToast(
                                StringConst.textyeucaudangnhap, context);
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              border:
                                  Border.all(color: Colors.black, width: 1)),
                          child:
                              const Center(child: Text('Bạn đang nghĩ gì ?')),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: InkWell(
                        onTap: (() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NotificationScreen(
                                      userID: currentUser?.user[0].id ?? '',
                                    )),
                          );
                        }),
                        child: Image.asset(
                          AssetsPathConst.categoryBell,
                          height: 25,
                          color: ColorConst.colorPrimary120,
                        ),
                      ))
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Bangtin>>(
                future: apiBangTinDaLog.getPosts(currentUser?.user[0].id ?? ''),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: CircularProgressIndicator(
                      color: ColorConst.colorPrimary120,
                    ));
                  } else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  } else {
                    posts = snapshot.data!;
                    return ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        return ItemBangTin(
                          widgetDelete:
                              (posts[index].userId == currentUser?.user[0].id)
                                  ? _item3DauCham(posts, index)
                                  : Container(),
                          username: posts[index].username,
                          like: posts[index].like,
                          content: posts[index].content,
                          date: posts[index].date,
                          cmt: posts[index].cmt.toString(),
                          useridbaiviet: posts[index].userId,
                          userid: currentUser?.user[0].id,
                          idbaiviet: posts[index].id,
                          isLike: posts[index].isLiked,
                          comments: posts[index].comments ?? [],
                          widgetPostCM: binhluon(
                            posts[index].comments ?? [],
                            posts[index].id,
                            currentUser?.user[0].id ?? '',
                          ),
                          images: posts[index].images ?? [],
                          avatar: posts[index].avatar,
                          role: posts[index].role,
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  InkWell _item3DauCham(List<Bangtin> posts, int index) {
    return InkWell(
      onTap: () {
        if (posts[index].userId == currentUser?.user[0].id) {
          _showDeleteDialog(posts[index].id, currentUser?.user[0].id ?? '');
        }
      },
      child: Icon(
        Icons.more_vert,
        size: 22,
      ),
    );
  }

  void _showDeleteDialog(String idPost, String userId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Xóa bài viết'),
          content: Text('Bạn có chắc muốn xóa bài viết này?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Hủy'),
            ),
            TextButton(
              onPressed: () async {
                await XoaBaiDang.xoaBaiDang(idPost, userId);
                Navigator.of(context).pop();
                setState(() {
                  _loadUser();
                });
              },
              child: Text('Xóa'),
            ),
          ],
        );
      },
    );
  }

  Widget binhluon(List<Comment> comments, String baivietID, String userID) {
    return InkWell(
      onTap: (() {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CommentScreen(
              baivietID: baivietID,
              userID: userID,
            ),
          ),
        ).then((value) {
          if (value == true) {
            _loadUser();
          }
        });
      }),
      child: Row(
        children: [
          Icon(Icons.chat, size: 25, color: Colors.grey[350]),
          Text(' Bình luận')
        ],
      ),
    );
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
  bool get wantKeepAlive => true;
}
