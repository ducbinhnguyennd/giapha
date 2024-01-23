import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:giapha/api_all/apitrangchu.dart';
import 'package:giapha/constant/asset_path_const.dart';
import 'package:giapha/constant/colors_const.dart';
import 'package:giapha/constant/common_service.dart';
import 'package:giapha/constant/strings_const.dart';
import 'package:giapha/model/bangtin_model.dart';

import 'package:giapha/model/danhsachHoModel.dart';
import 'package:giapha/model/user_model.dart';
import 'package:giapha/model/user_model2.dart';
import 'package:giapha/screens/bangtin_screen/binhluan_screen.dart';
import 'package:giapha/screens/bangtin_screen/postbai.dart';
import 'package:giapha/screens/bangtin_screen/thongbao_screen.dart';
import 'package:giapha/screens/widgets/item_bangtin.dart';
import 'package:giapha/screens/widgets/item_ho.dart';
import 'package:giapha/user_Service.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class DanhsachhoScreen extends StatefulWidget {
  const DanhsachhoScreen({super.key});

  @override
  State<DanhsachhoScreen> createState() => _DanhsachhoScreenState();
}

class _DanhsachhoScreenState extends State<DanhsachhoScreen>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  List<danhsachHoModel> _items = [];

  List<danhsachHoModel> _foundUsers = [];
  Data? currentUser;
  int selectedTabIndex = 0;
  bool nutlike = false;
  Bangtin? bangtin;
  ApiBangTinDaLog apiBangTinDaLog = ApiBangTinDaLog();
  List<Bangtin> posts = [];

  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    fetchData();
    _loadUser();
  }

  Future<void> _refresh() async {
    await _loadUser();
  }

  final ApiUser apiService = ApiUser();
  Future<void> _loadUser() async {
    UserServices us = UserServices();
    us.getInfoLogin().then((value) {
      if (value != "") {
        setState(() {
          currentUser = Data.fromJson(jsonDecode(value));
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

  Future<void> fetchData() async {
    try {
      final List<danhsachHoModel> apiData =
          await DanhSachHoService().fetchdsHo();
      setState(() {
        _items = apiData;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  String removeAccents(String input) {
    var str = input.toLowerCase();
    str = str.replaceAll(RegExp(r'[àáạảãâầấậẩẫăằắặẳẵ]'), 'a');
    str = str.replaceAll(RegExp(r'[èéẹẻẽêềếệểễ]'), 'e');
    str = str.replaceAll(RegExp(r'[ìíịỉĩ]'), 'i');
    str = str.replaceAll(RegExp(r'[òóọỏõôồốộổỗơờớợởỡ]'), 'o');
    str = str.replaceAll(RegExp(r'[ùúụủũưừứựửữ]'), 'u');
    str = str.replaceAll(RegExp(r'[ỳýỵỷỹ]'), 'y');
    str = str.replaceAll(RegExp(r'[đ]'), 'd');
    return str;
  }

  void _runFilter(String query) {
    List<danhsachHoModel> results = [];
    if (query.isEmpty) {
      //results = _items.cast<ItemModel>();
    } else {
      results = _items.where((ho) {
        String nameLower = removeAccents(ho.name);
        // String authorLower = removeAccents(book.);
        String category = removeAccents(ho.address);
        String queryLower = removeAccents(query.toLowerCase());

        return nameLower.contains(queryLower) ||
            // authorLower.contains(queryLower) ||
            category.contains(queryLower);
      }).toList();
    }

    setState(() {
      _foundUsers = results.cast<danhsachHoModel>();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (currentUser == null || currentUser?.user[0].lineage == "") {
      return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Tìm kiếm họ'),
          centerTitle: true,
          backgroundColor: ColorConst.colorPrimary50,
        ),
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) => _runFilter(value),
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
                hintText: "Tìm theo tên hoặc địa chỉ",
                suffixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(),
                ),
              ),
            ),
          ),
          Expanded(
              child: _foundUsers.isNotEmpty
                  ? ListView.builder(
                      itemCount: _foundUsers.length,
                      itemBuilder: (context, index) {
                        return ZoomTapAnimation(
                            onTap: () {},
                            child: ItemHo(
                              tenho: _foundUsers[index].name,
                              diachi: _foundUsers[index].address,
                              members: _foundUsers[index].members.toString(),
                              generation:
                                  _foundUsers[index].generation.toString(),
                              creater: _foundUsers[index].creater,
                              phone: _foundUsers[index].phone,
                            ));
                      },
                    )
                  : isLoading
                      ? Center(child: CircularProgressIndicator())
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 8.0,
                                    mainAxisSpacing: 8.0,
                                    childAspectRatio: 2 / 2.5),
                            itemCount: _items.length,
                            itemBuilder: (context, index) {
                              return ZoomTapAnimation(
                                onTap: () {},
                                child: ItemHo(
                                  tenho: _items[index].name,
                                  diachi: _items[index].address,
                                  members: _items[index].members.toString(),
                                  generation:
                                      _items[index].generation.toString(),
                                  creater: _items[index].creater,
                                  phone: _items[index].phone,
                                ),
                              );
                            },
                          ),
                        )),
        ]),
      );
    } else {
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
                        padding:
                            const EdgeInsets.fromLTRB(8.0, 13.0, 8.0, 13.0),
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
                  future:
                      apiBangTinDaLog.getPosts(currentUser?.user[0].id ?? ''),
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

  @override
  bool get wantKeepAlive => true;
}
