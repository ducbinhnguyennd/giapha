import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:giapha/api_all/apitrangchu.dart';
import 'package:giapha/constant/colors_const.dart';
import 'package:giapha/constant/common_service.dart';
import 'package:giapha/mainscreen.dart';
import 'package:giapha/model/bangtin_model.dart';

import 'package:giapha/model/danhsachHoModel.dart';
import 'package:giapha/model/user_model.dart';
import 'package:giapha/screens/bangtin_screen/bangtin.dart';

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
  String _key = '';
  List<danhsachHoModel> _foundUsers = [];
  Data? currentUser;
  int selectedTabIndex = 0;
  bool nutlike = false;
  Bangtin? bangtin;
  ApiBangTinDaLog apiBangTinDaLog = ApiBangTinDaLog();
  List<Bangtin> posts = [];
  Joindongho joindongho = Joindongho();
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

  final TextEditingController _passwordController = TextEditingController();

  // Hàm để hiển thị modal và xử lý logic khi nhấn nút
  void _showPasswordModal(BuildContext context, String id, String iduser) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Nhập mật khẩu"),
          content: TextField(
            controller: _passwordController,
            onChanged: (val) {
              setState(() {
                _key = val;
              });
            },
            obscureText: true,
            decoration: InputDecoration(
              hintText: "Nhập mật khẩu",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Hủy"),
            ),
            TextButton(
              onPressed: () async {
                var response = await joindongho.joinDongho(id, iduser, _key);

                CommonService.showToast('Đang đăng nhập...', context);
                if (_key.isNotEmpty) {
                  if (response?.statusCode == 200) {
                    CommonService.showToast('Đăng nhập thành công', context);
                    // setState(() {});
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BangTinScreen()),
                    );
                  } else {
                    CommonService.showToast('Sai mã', context);
                  }
                } else {
                  CommonService.showToast('Nhập mã', context);
                }
                Navigator.of(context).pop();
              },
              child: Text("Xác nhận"),
            ),
          ],
        );
      },
    );
  }

  final ApiUser apiService = ApiUser();
  _loadUser() {
    UserServices us = UserServices();
    us.getInfoLogin().then((value) {
      if (value != "") {
        setState(() {
          currentUser = Data.fromJson(jsonDecode(value));

          print('binh in ${currentUser}');
          print('binh in 2 ${currentUser?.user[0].id}');
        });
      } else {
        setState(() {
          currentUser = null;
        });
      }
    }, onError: (error) {});
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
    super.build(context);
    if (currentUser != null || currentUser?.user[0].lineage != "") {
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
                            onTap: () {
                              _showPasswordModal(
                                context,
                                _foundUsers[index].id,
                                currentUser?.user[0].id ?? '',
                              );
                            },
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
                                onTap: () {
                                  _showPasswordModal(context, _items[index].id,
                                      currentUser?.user[0].id ?? '');
                                },
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
      return const BangTinScreen();
    }
  }

  @override
  bool get wantKeepAlive => true;
}
