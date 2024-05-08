import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:giapha/api_all/apitrangchu.dart';
import 'package:giapha/constant/asset_path_const.dart';
import 'package:giapha/constant/common_service.dart';
import 'package:giapha/constant/strings_const.dart';
import 'package:giapha/model/giaPha_model.dart';
import 'package:giapha/model/user_model.dart';
import 'package:giapha/routes.dart';
import 'package:giapha/screens/giapha_screen/item_caygiapha.dart';
import 'package:giapha/user_Service.dart';

class FamilyTreeScreen extends StatefulWidget {
  final TabController tabController;

  const FamilyTreeScreen({Key? key, required this.tabController})
      : super(key: key);
  @override
  _FamilyTreeScreenState createState() => _FamilyTreeScreenState();
}

class _FamilyTreeScreenState extends State<FamilyTreeScreen>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late CayGiaPhaApi _api;
  late Member _familyTreeRoot;
  late Creator _creator;
  bool _isLoading = true;
  Data? currentUser;
  @override
  void initState() {
    super.initState();
    _api = CayGiaPhaApi();
    _loadUser();
  }

  _loadUser() {
    UserServices us = UserServices();
    us.getInfoLogin().then((value) {
      if (value != "") {
        setState(() {
          currentUser = Data.fromJson(jsonDecode(value));
          _fetchFamilyTree(currentUser?.user[0].lineage ?? '');
          print('binh in ${currentUser}');
        });
      } else {
        setState(() {
          currentUser = null;
        });
      }
    }, onError: (error) {});
  }

  Future<void> _fetchFamilyTree(String userId) async {
    try {
      Map<String, dynamic>? jsonData = await _api.fetchFamilyTree(userId);
      setState(() {
        _familyTreeRoot = Member.fromJson(jsonData['familyTreeJSON'][0]);
        _creator = Creator.fromJson(jsonData['creator']);
        _isLoading = false;
      });
    } catch (e) {
      print('Failed to load family tree: $e');
      setState(() {
        _isLoading = false;
      });
      // Xử lý lỗi
    }
  }

  void _switchToTab(int tabIndex) {
    // Sử dụng tabController được truyền từ widget
    widget.tabController.animateTo(tabIndex);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Image.asset(
            AssetsPathConst.bggiapha,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fill,
          ),
          if (currentUser == null)
            Positioned(
              bottom: 40,
              left: 30,
              right: 30,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: 80,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.black),
                child: Row(
                  children: [
                    Expanded(
                        flex: 7,
                        child: Center(
                          child: Text(
                            'Vui lòng đăng nhập để thực hiện chức năng này',
                            style: TextStyle(color: Colors.white),
                          ),
                        )),
                    Expanded(
                      flex: 3,
                      child: InkWell(
                        onTap: () {
                          _switchToTab(3);
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.amber),
                          child: Center(child: Text('Đăng nhập')),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          else if (_isLoading)
            Center(
              child: CircularProgressIndicator(),
            )
          else
            Positioned(
              top: 110,
              left: 0,
              right: 0,
              child: Padding(
                padding:
                    const EdgeInsets.only(bottom: kBottomNavigationBarHeight),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Text('Gia phả: ${_creator.namegiapha}'),
                        Text('Người tạo họ - ${_creator.name ?? ''}'),
                        Text('Số diện thoại - ${_creator.phone ?? ''}'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          if (!_isLoading)
            Positioned(
              top: 220,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                    child: FamilyTreeGeneration(
                      generation: _familyTreeRoot,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    height: 300,
                    child: FamilyTreeGeneration(
                      generation: _familyTreeRoot,
                      showChildren: true,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class FamilyTreeGeneration extends StatelessWidget {
  final Member generation;
  final bool showChildren;

  FamilyTreeGeneration({
    required this.generation,
    this.showChildren = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: showChildren ? generation.children!.length : 1,
      itemBuilder: (context, index) {
        final List<Member> children =
            showChildren ? generation.children![index] : [generation];

        // return Column(

        //   children: children.map((child) {
        //     // return ListTile(
        //     //   title: Text(child.name ?? ''),
        //     //   onTap: () {
        //     //     _showChildrenOfMember(context, child);
        //     //   },
        //     // );
        //     return ItemCayGiaPha(
        //       name: child.name ?? '',
        //       date: child.date ?? '',
        //       relationship: '',
        //     );
        //   }).toList(),
        // );
        return Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Căn giữa theo chiều dọc
          children: children.map((child) {
            return ItemCayGiaPha(
                name: child.name ?? '',
                date: child.date ?? '',
                avatar: child.avatar ?? '',
                relationship: child.generation ?? '',
                id: child.id ?? '',
                onTap: () {
                  _showChildrenOfMember(context, child);
                });
          }).toList(),
        );
      },
    );
  }

//  onTap: () {
//                           Navigator.of(context).pop();
//                           _showChildrenOfMember(context, child);
//                         },
  void _showChildrenOfMember(BuildContext context, Member member) {
    if (member.children != null && member.children!.isNotEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(member.name ?? ''),
            content: SingleChildScrollView(
              child: Column(
                children: member.children!.map((childList) {
                  return Column(
                    children: childList.map((child) {
                      return ItemCayGiaPha(
                          name: child.name ?? '',
                          date: child.date ?? '',
                          avatar: child.avatar ?? '',
                          relationship: child.generation ?? '',
                          id: child.id ?? '',
                          onTap: () {
                            Navigator.of(context).pop();
                            _showChildrenOfMember(context, child);
                          });
                    }).toList(),
                  );
                }).toList(),
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Đóng'),
              ),
            ],
          );
        },
      );
    } else {
      CommonService.showToast('Đã hết đời tiếp theo', context);
    }
  }
}
