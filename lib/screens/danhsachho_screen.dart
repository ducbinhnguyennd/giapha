import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:giapha/api_all/apitrangchu.dart';
import 'package:giapha/constant/colors_const.dart';
import 'package:giapha/constant/common_service.dart';
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

class _DanhsachhoScreenState extends State<DanhsachhoScreen> {
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

  PostDongHo postDongHo = PostDongHo();

  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _refresh() async {
    await _loadUser();
  }

  final TextEditingController _passwordController = TextEditingController();
  void _showPasswordModal(BuildContext context, String id, String iduser) {
    if (currentUser == null || currentUser!.user.isEmpty) {
      CommonService.showToast('Vui lòng đăng nhập để thêm dòng họ', context);
      return;
    }
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
                if (_key.isNotEmpty) {
                  if (response?.statusCode == 200) {
                    CommonService.showToast('Đăng nhập thành công', context);
                    setState(() {});
                    Navigator.pushNamed(context, BangTinScreen.routeName);
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
          fetchData();
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
        _foundUsers = _items;
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
      setState(() {
        results = _items;
      });
    } else {
      results = _items.where((ho) {
        String nameLower = removeAccents(ho.name);
        String createrLower = removeAccents(ho.creater);
        String category = removeAccents(ho.address);
        String queryLower = removeAccents(query.toLowerCase());

        return nameLower.contains(queryLower) ||
            createrLower.contains(queryLower) ||
            // authorLower.contains(queryLower) ||
            category.contains(queryLower);
      }).toList();
    }

    setState(() {
      _foundUsers = results.cast<danhsachHoModel>();
    });
  }

  // void _showDialogCreateFamily() {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: Text("Tạo gia phả"),
  //         content: SingleChildScrollView(
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               TextField(
  //                 controller: _giaPhaController,
  //                 decoration: InputDecoration(
  //                   hintText: "Nhập tên gia phả",
  //                 ),
  //               ),
  //               TextField(
  //                 controller: _passwordFamilyController,
  //                 obscureText: true,
  //                 decoration: InputDecoration(
  //                   hintText: "Nhập mật khẩu",
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               _giaPhaController.clear();
  //               _passwordFamilyController.clear();
  //               Navigator.of(context).pop();
  //             },
  //             child: Text("Hủy"),
  //           ),
  //           TextButton(
  //             onPressed: () async {
  //               final String userId = currentUser!.user[0].id;
  //               final String name = _giaPhaController.text;
  //               final String address = currentUser!.user[0].address;
  //               final String key = _passwordFamilyController.text;

  //               if (name.isNotEmpty && key.isNotEmpty) {
  //                 try {
  //                   CommonService.showLoading(context);
  //                   var response = await postNewFamily.postNewFamily(
  //                       userId, name, address, key);
  //                   Navigator.of(context).pop();

  //                   if (response != null && response.statusCode == 200) {
  //                     CommonService.showToast(
  //                         'Tạo gia phả thành công', context);

  //                     var newFamily = danhsachHoModel(
  //                       id: response.data['_id'] ?? '',
  //                       name: name,
  //                       key: key,
  //                       address: address,
  //                       members: 0,
  //                       generation: 1,
  //                       creater: currentUser!.user[0].hovaten,
  //                       phone: currentUser!.user[0].phone,
  //                     );

  //                     setState(() {
  //                       _items.add(newFamily);
  //                       _foundUsers = _items;
  //                     });

  //                     _giaPhaController.clear();
  //                     _passwordFamilyController.clear();
  //                     Navigator.of(context).pop();
  //                   } else {
  //                     CommonService.showToast(
  //                         'Đã có lỗi xảy ra, vui lòng thử lại', context);
  //                   }
  //                 } catch (e) {
  //                   Navigator.of(context).pop();
  //                   CommonService.showToast(
  //                       'Lỗi kết nối: ${e.toString()}', context);
  //                   print('Error creating family: ${e.toString()}');
  //                 }
  //               } else {
  //                 CommonService.showToast(
  //                     'Vui lòng điền đầy đủ thông tin', context);
  //               }
  //             },
  //             child: Text("Xác nhận"),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  final TextEditingController _giaPhaController = TextEditingController();
  final TextEditingController _passwordFamilyController =
      TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _nicknameController = TextEditingController();
  TextEditingController _sexController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _avatarController = TextEditingController();
  TextEditingController _maritalStatusController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _academicLevelController = TextEditingController();
  TextEditingController _jobController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _hometownController = TextEditingController();
  TextEditingController _bioController = TextEditingController();
  TextEditingController _deadController = TextEditingController();
  TextEditingController _deadDateController = TextEditingController();
  TextEditingController _worshipAddressController = TextEditingController();
  TextEditingController _worshipPersonController = TextEditingController();
  TextEditingController _burialAddressController = TextEditingController();

  void showDialogCreateFamilyAndAddMember() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Tạo gia phả và thêm thông tin của trưởng họ"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Các TextField liên quan đến việc tạo gia phả
                TextField(
                  controller: _giaPhaController,
                  decoration: InputDecoration(
                    hintText: "Nhập tên gia phả",
                  ),
                ),
                TextField(
                  controller: _passwordFamilyController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Nhập mật khẩu",
                  ),
                ),
                // Các TextField dành cho thêm thành viên
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(hintText: "Tên trưởng họ"),
                ),
                TextField(
                  controller: _nicknameController,
                  decoration: InputDecoration(hintText: "Biệt danh"),
                ),
                TextField(
                  controller: _sexController,
                  decoration: InputDecoration(hintText: "Giới tính"),
                ),
                TextField(
                  controller: _dateController,
                  decoration: InputDecoration(hintText: "Ngày sinh"),
                ),
                TextField(
                  controller: _avatarController,
                  decoration: InputDecoration(hintText: "Ảnh đại diện"),
                ),
                TextField(
                  controller: _maritalStatusController,
                  decoration: InputDecoration(hintText: "Tình trạng hôn nhân"),
                ),
                TextField(
                  controller: _phoneController,
                  decoration: InputDecoration(hintText: "Số điện thoại"),
                ),
                TextField(
                  controller: _academicLevelController,
                  decoration: InputDecoration(hintText: "Trình độ học vấn"),
                ),
                TextField(
                  controller: _jobController,
                  decoration: InputDecoration(hintText: "Nghề nghiệp"),
                ),
                TextField(
                  controller: _addressController,
                  decoration: InputDecoration(hintText: "Địa chỉ"),
                ),
                TextField(
                  controller: _hometownController,
                  decoration: InputDecoration(hintText: "Quê quán"),
                ),
                TextField(
                  controller: _bioController,
                  decoration: InputDecoration(hintText: "Tiểu sử"),
                ),
                TextField(
                  controller: _deadController,
                  decoration: InputDecoration(
                      hintText: "Tình trạng qua đời (true/false)"),
                ),
                TextField(
                  controller: _deadDateController,
                  decoration: InputDecoration(hintText: "Ngày mất"),
                ),
                TextField(
                  controller: _worshipAddressController,
                  decoration: InputDecoration(hintText: "Địa chỉ thờ"),
                ),
                TextField(
                  controller: _worshipPersonController,
                  decoration: InputDecoration(hintText: "Người thờ"),
                ),
                TextField(
                  controller: _burialAddressController,
                  decoration: InputDecoration(hintText: "Địa chỉ an táng"),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                _giaPhaController.clear();
                _passwordFamilyController.clear();
                _nameController.clear();
                _nicknameController.clear();
                _sexController.clear();
                _dateController.clear();
                _avatarController.clear();
                _maritalStatusController.clear();
                _phoneController.clear();
                _academicLevelController.clear();
                _jobController.clear();
                _addressController.clear();
                _hometownController.clear();
                _bioController.clear();
                _deadController.clear();
                _deadDateController.clear();
                _worshipAddressController.clear();
                _worshipPersonController.clear();
                _burialAddressController.clear();
                Navigator.of(context).pop();
              },
              child: Text("Hủy"),
            ),
            TextButton(
              onPressed: () async {
                final String userId = currentUser!.user[0].id;
                final String name = _giaPhaController.text;
                final String address = currentUser!.user[0].address;
                final String key = _passwordFamilyController.text;

                // Thông tin thành viên
                final String nickname = _nicknameController.text;
                final String sex = _sexController.text;
                final String date = _dateController.text;
                final String avatar = _avatarController.text;
                final String maritalStatus = _maritalStatusController.text;
                final String phone = _phoneController.text;
                final String academicLevel = _academicLevelController.text;
                final String job = _jobController.text;
                final String memberAddress = _addressController.text;
                final String hometown = _hometownController.text;
                final String bio = _bioController.text;
                final bool dead = _deadController.text.toLowerCase() == 'true';
                final String deadDate = _deadDateController.text;
                final String worshipAddress = _worshipAddressController.text;
                final String worshipPerson = _worshipPersonController.text;
                final String burialAddress = _burialAddressController.text;

                if (name.isNotEmpty && key.isNotEmpty) {
                  try {
                    CommonService.showLoading(context);
                    // Gọi hàm tạo gia phả
                    var response = await postDongHo.postNewFamily(
                        userId, name, address, key);

                    if (response != null && response.statusCode == 200) {
                      CommonService.showToast(
                          'Tạo gia phả thành công', context);

                      // Lấy id dòng họ vừa tạo để thêm thành viên đầu tiên
                      final String idDongho = response.data['_id'];

                      var memberResponse = await postDongHo.postFirstMember(
                        idDongho,
                        name,
                        nickname,
                        sex,
                        date,
                        avatar,
                        maritalStatus,
                        phone,
                        academicLevel,
                        job,
                        memberAddress,
                        hometown,
                        bio,
                        dead,
                        deadDate,
                        worshipAddress,
                        worshipPerson,
                        burialAddress,
                      );

                      if (memberResponse != null &&
                          memberResponse.statusCode == 200) {
                        CommonService.showToast(
                            'Thêm thành viên thành công', context);
                      } else {
                        CommonService.showToast(
                            'Đã có lỗi khi thêm thành viên', context);
                      }
                    } else {
                      CommonService.showToast(
                          'Đã có lỗi xảy ra khi tạo gia phả', context);
                    }
                  } catch (e) {
                    CommonService.showToast(
                        'Lỗi kết nối: ${e.toString()}', context);
                  } finally {
                    // CommonService.hideLoading(context);
                    Navigator.of(context).pop();
                  }
                } else {
                  CommonService.showToast(
                      'Vui lòng điền đầy đủ thông tin', context);
                }
              },
              child: Text("Xác nhận"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // super.build(context);
    if (currentUser?.user[0].lineage == "" || currentUser == null) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
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
                hintText: "Tìm theo tên họ, người tạo, địa chỉ",
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
                  ? Padding(
                      padding: EdgeInsets.all(8.0),
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 8.0,
                            childAspectRatio: 2 / 2.5),
                        itemCount: _foundUsers.length,
                        itemBuilder: (context, index) {
                          return ZoomTapAnimation(
                            onTap: () {
                              _showPasswordModal(context, _foundUsers[index].id,
                                  currentUser?.user[0].id ?? '');
                            },
                            child: ItemHo(
                              tenho: _foundUsers[index].name,
                              diachi: _foundUsers[index].address,
                              members: _foundUsers[index].members.toString(),
                              generation:
                                  _foundUsers[index].generation.toString(),
                              creater: _foundUsers[index].creater,
                              phone: _foundUsers[index].phone,
                            ),
                          );
                        },
                      ),
                    )
                  : isLoading
                      ? Center(child: CircularProgressIndicator())
                      : Center(child: Text('Không tìm thấy kết quả phù hợp.'))),
        ]),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (currentUser == null || currentUser!.user.isEmpty) {
                CommonService.showToast(
                    'Vui lòng đăng nhập để thêm dòng họ', context);
                return;
              }
              showDialogCreateFamilyAndAddMember();
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100)),
            focusColor: ColorConst.colorPrimary50,
            backgroundColor: ColorConst.colorPrimary,
            child: const Icon(Icons.add, color: ColorConst.colorWhite)),
      );
    } else {
      return const BangTinScreen();
    }
  }
}
