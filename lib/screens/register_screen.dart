import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:giapha/api_all/api_diachi.dart';
import 'package:giapha/api_all/apitrangchu.dart';
import 'package:giapha/constant/asset_path_const.dart';
import 'package:giapha/constant/colors_const.dart';
import 'package:giapha/constant/common_service.dart';
import 'package:giapha/mainscreen.dart';
import 'package:giapha/model/diachi_model.dart';
import 'package:giapha/user_Service.dart';
import 'package:intl/intl.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  static const routeName = 'register_screen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameKey = GlobalKey<FormFieldState>();
  final _passwordKey = GlobalKey<FormFieldState>();
  final _phoneKey = GlobalKey<FormFieldState>();
  final _hovatenKey = GlobalKey<FormFieldState>();
  final _dateKey = GlobalKey<FormFieldState>();
  final _addressKey = GlobalKey<FormFieldState>();
  final _hometownKey = GlobalKey<FormFieldState>();
  final _jobKey = GlobalKey<FormFieldState>();

  TextEditingController phoneEditingController = TextEditingController();
  TextEditingController userEditingController = TextEditingController();
  TextEditingController passwEditingController = TextEditingController();
  TextEditingController hovatenEditingController = TextEditingController();
  TextEditingController dateEditingController = TextEditingController();
  TextEditingController addressEditingController = TextEditingController();
  TextEditingController hometownEditingController = TextEditingController();
  TextEditingController jobtownEditingController = TextEditingController();

  bool isEmailCorrect = false;
  String _username = '';
  String _password = '';
  String _hovaten = '';
  DateTime _date = DateTime.now();
  String _address = '';
  String _hometown = '';
  String _phone = '';
  String _job = '';
  bool success = false;
  final AddressApi _addressApi = AddressApi();
  List<Province> _provinces = [];
  Province? _selectedProvince;
  District? _selectedDistrict;
  Ward? _selectedWard;
  @override
  void dispose() {
    // emailEditingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadProvinces();
  }

  dynamic snackBar = SnackBar(
    duration: const Duration(milliseconds: 1500),
    content: const Text("Your Registration Complete"),
    action: SnackBarAction(
      label: 'Got it',
      onPressed: () {},
    ),
  );
  Future<void> _loadProvinces() async {
    try {
      final List<Province> provinces = await _addressApi.fetchProvinces();
      setState(() {
        _provinces = provinces;
      });
    } catch (e) {
      print('Error loading provinces: $e');
    }
  }

  Future<Response?> register(
      String username,
      String password,
      String hovaten,
      String date,
      String address,
      String hometown,
      String phone,
      String job) async {
    var dio = Dio();
    print(_date);
    if (username.isEmpty) {
      CommonService.showToast('Tên đăng nhập đang trống', context);
    } else if (password.isEmpty) {
      CommonService.showToast('Mật khẩu đang trống', context);
    } else if (hovaten.isEmpty) {
      CommonService.showToast('Họ tên đang để trống', context);
    } else if (address.isEmpty) {
      CommonService.showToast('Nơi thường trú đang trống', context);
    } else if (phone.isEmpty) {
      CommonService.showToast('Số điện thoại đang trống', context);
    } else if (phone.length != 10) {
      CommonService.showToast('Số điện thoại phải đủ 10 số', context);
    } else if (!phone.startsWith('0')) {
      CommonService.showToast('Số điện thoại đầu 0', context);
    } else if (job.isEmpty) {
      CommonService.showToast('Nghề nghiệp đang trống', context);
    } else {
      try {
        var response = await dio.post(
          'https://appgiapha.vercel.app/register',
          options: Options(
            followRedirects: true,
            maxRedirects: 5,
          ),
          data: {
            "username": username,
            "password": password,
            "hovaten": hovaten,
            "date": date,
            "address": address,
            "hometown": hometown,
            "phone": phone,
            "job": job
          },
        );

        print(response.data);
        if (response.data['success'] == true) {
          Login login = Login();
          var response = await login.signIn(_username, _password);

          if (response?.data['success'] == true) {
            UserServices us = UserServices();
            await us.saveinfologin(jsonEncode(response?.data['data']));
            // final storage = new FlutterSecureStorage();

            print('${response?.data['data']}');
            Navigator.pushReplacement<void, void>(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => const MainScreen(),
              ),
            );
          }
        }
        setState(() {
          success = true;
          CommonService.showToast('Đăng ký tài khoản thành công', context);
        });

        return response;
      } catch (e) {
        print('binh login: $e');
        CommonService.showToast('Tên tài khoản đã tồn tại', context);
      }
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height / 2,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.white, ColorConst.colorPrimary],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white,
                      spreadRadius: 30,
                      blurRadius: 40,
                      offset: Offset(0, -25),
                    ),
                  ]),
            ),
          ),
          Positioned(
            top: 50,
            left: 10,
            right: 10,
            child: Column(
              children: [
                InkWell(
                  onTap: (() {
                    Navigator.of(context).pop();
                  }),
                  child: Container(
                    child: Row(
                      children: [
                        Icon(Icons.arrow_back_ios_new),
                        Text(
                          'Màn hình đăng nhập',
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(16),
                  height: 550,
                  child: Form(
                      key: _formKey,
                      child: ListView(children: [
                        Padding(padding: EdgeInsets.all(0)),
                        TextFormField(
                          controller: userEditingController,
                          key: _usernameKey,
                          onChanged: (val) {
                            _username = val;
                          },
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: ColorConst.colorPrimary50),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            labelText: "Tên đăng nhập",
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          key: _passwordKey,
                          controller: passwEditingController,
                          onChanged: (val) {
                            _password = val;
                          },
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: ColorConst.colorPrimary50),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            labelText: "Mật khẩu",
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          key: _hovatenKey,
                          controller: hovatenEditingController,
                          onChanged: (val) {
                            _hovaten = val;
                          },
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: ColorConst.colorPrimary50),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            labelText: "Họ Tên",
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Column(
                          children: [
                            TextFormField(
                              key: _dateKey,
                              controller: dateEditingController,
                              readOnly: true, // Make the text field read-only
                              onTap: () {
                                // Show date picker dialog when the text field is tapped
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      backgroundColor: const Color(0xffFBBA95),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        height: 500,
                                        width: 300,
                                        child: Column(
                                          children: [
                                            Expanded(
                                              flex: 7,
                                              child: ScrollDatePicker(
                                                minimumDate:
                                                    DateTime(1930, 1, 1),
                                                maximumDate: DateTime.now(),
                                                options:
                                                    const DatePickerOptions(
                                                  backgroundColor:
                                                      Color(0xffFBBA95),
                                                ),
                                                selectedDate: _date,
                                                locale: Locale('vi'),
                                                onDateTimeChanged:
                                                    (DateTime value) {
                                                  setState(() {
                                                    _date = value;
                                                    dateEditingController.text =
                                                        DateFormat('dd/MM/yyyy')
                                                            .format(_date);
                                                  });
                                                },
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black
                                                            .withOpacity(0.2),
                                                        offset:
                                                            const Offset(0, 3),
                                                        blurRadius: 7,
                                                        spreadRadius: 5,
                                                      ),
                                                    ],
                                                    color:
                                                        const Color(0xffFCCDB3),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                  ),
                                                  child: const Center(
                                                    child: Text(
                                                      'Chọn ngày',
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xffFF5C00),
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        //fontFamily: 'CCGabrielBautistaLito'
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              decoration: InputDecoration(
                                labelText: 'Ngày sinh',
                                hintText: dateEditingController.text,
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: ColorConst.colorPrimary50),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              key: _phoneKey,
                              onChanged: (val) {
                                doValidation(_phoneKey, null);
                                _phone = val;
                              },
                              keyboardType: TextInputType.phone,
                              maxLength: 10,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: ColorConst.colorPrimary50),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                labelText: "Số điện thoại",
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: Colors.black)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  DropdownButton<Province>(
                                    value: _selectedProvince,
                                    hint: Text('Nơi thường trú'),
                                    onChanged: (Province? newValue) {
                                      setState(() {
                                        _selectedProvince = newValue;
                                        _selectedDistrict = null;
                                        _selectedWard = null;
                                        _address = '';
                                      });
                                    },
                                    items: _provinces
                                        .map<DropdownMenuItem<Province>>(
                                          (Province province) =>
                                              DropdownMenuItem<Province>(
                                            value: province,
                                            child: Text(province.name),
                                          ),
                                        )
                                        .toList(),
                                    underline: Container(),
                                  ),
                                  if (_selectedProvince != null)
                                    DropdownButton<District>(
                                      value: _selectedDistrict,
                                      hint: Text('Chọn quận/huyện'),
                                      onChanged: (District? newValue) {
                                        setState(() {
                                          _selectedDistrict = newValue;
                                          _selectedWard = null;
                                          _address = '';
                                        });
                                      },
                                      items: _selectedProvince!.districts
                                          .map<DropdownMenuItem<District>>(
                                            (District district) =>
                                                DropdownMenuItem<District>(
                                              value: district,
                                              child: Text(district.name),
                                            ),
                                          )
                                          .toList(),
                                      underline: Container(),
                                    ),

                                  // Dropdown for wards
                                  if (_selectedDistrict != null)
                                    DropdownButton<Ward>(
                                      value: _selectedWard,
                                      hint: Text('Chọn xã/phường/thị trấn'),
                                      onChanged: (Ward? newValue) {
                                        setState(() {
                                          _selectedWard = newValue;
                                          _address = '';
                                        });
                                      },
                                      items: _selectedDistrict!.wards
                                          .map<DropdownMenuItem<Ward>>(
                                            (Ward ward) =>
                                                DropdownMenuItem<Ward>(
                                              value: ward,
                                              child: Text(ward.name),
                                            ),
                                          )
                                          .toList(),
                                      underline: Container(),
                                    ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              key: _jobKey,
                              controller: jobtownEditingController,
                              onChanged: (val) {
                                _job = val;
                              },
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: ColorConst.colorPrimary50),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                labelText: "Nghề nghiệp",
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            InkWell(
                                onTap: () async {
                                  // if (_address == '') {
                                  //   CommonService.showToast(
                                  //       'Nơi thường trú đang trống', context);
                                  // } else {
                                  //   _address =
                                  //       '${_selectedWard?.name}, ${_selectedDistrict?.name}, ${_selectedProvince?.name}';
                                  // }
                                  _address =
                                      '${_selectedWard?.name}, ${_selectedDistrict?.name}, ${_selectedProvince?.name}';
                                  _hometown = '';
                                  await register(
                                      _username,
                                      _password,
                                      _hovaten,
                                      DateFormat('dd/MM/yyyy').format(_date),
                                      _address,
                                      _hometown,
                                      _phone,
                                      _job);
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 3,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: ColorConst.colorPrimary50),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Đăng ký',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18),
                                        )),
                                  ),
                                )),
                          ],
                        )
                      ])),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void doValidation(
      GlobalKey<FormFieldState>? keyName, GlobalKey<FormState>? formKey) {
    if (formKey != null && formKey.currentState!.validate()) {}
  }
}
