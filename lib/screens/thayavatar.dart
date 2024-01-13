import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:giapha/constant/asset_path_const.dart';
import 'package:giapha/constant/colors_const.dart';
import 'package:giapha/constant/common_service.dart';
import 'package:giapha/constant/double_x.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as image_format;
import 'dart:math' as math;
import 'package:path_provider/path_provider.dart';

// ignore: must_be_immutable
class SuaThongTin extends StatefulWidget {
  SuaThongTin({super.key, required this.userID});
  String userID;
  static const routeName = 'suathongtin';

  @override
  State<SuaThongTin> createState() => _SuaThongTinState();
}

class _SuaThongTinState extends State<SuaThongTin> {
  bool isAvatarChanged = false;
  XFile? _imageFile;
  final _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    InventoryData dataToPass = InventoryData(isAvatarChanged, false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConst.colorPrimary50,
        centerTitle: true,
        title: const Text('Thay đổi ảnh đại diện'),
        leading: InkWell(
          onTap: (() {
            Navigator.of(context).pop(dataToPass);
          }),
          child: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                bottom: DoubleX.kPaddingSizeMedium_1XX,
              ),
              child: _imageFile != null
                  ? Center(
                      child: SizedBox(
                        width: DoubleX.kLayoutWidthHuge,
                        height: DoubleX.kLayoutHeightHuge,
                        child: ClipOval(
                          child: Image.file(
                            File(_imageFile!.path),
                            width: DoubleX.kSizeHuge,
                            height: DoubleX.kSizeHuge,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                  : Center(
                      child: SizedBox(
                        width: DoubleX.kLayoutWidthHuge,
                        height: DoubleX.kLayoutHeightHuge,
                        child: ClipOval(
                          child: Image.asset(AssetsPathConst.logo),
                        ),
                      ),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: GestureDetector(
                onTap: () {
                  _onImageButtonPressed(ImageSource.gallery, context: context);
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: Gradients.defaultGradientBackground,
                  ),
                  child: Center(
                    child: Text(
                      'Chọn ảnh',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
              child: GestureDetector(
                onTap: () async {
                  _uploadAndNavigate(context);
                  setState(() {
                    isAvatarChanged = true;
                  });
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: Gradients.defaultGradientBackground,
                  ),
                  child: Center(
                    child: Text(
                      'Cập nhật avatar',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  //  void _showToast(String ms) {
  //   if (ms.contains(StringConst.textyeucaudangnhap)) {
  //     // update count show user need login: only first show toast need login, after will show snack bar to go to login screen,
  //     // show snack bar login here,
  //     CommonService.showSnackBar(StringConst.textyeucaudangnhap, context, () {
  //       // go to login screen
  //       RouteUtil.redirectToLoginScreen(context);
  //     });
  //     return;
  //   }

  //   // SHOW TOAST
  //   if (!mounted) return;
  //   CommonService.showToast(ms, context);
  // }

  Future<void> _uploadAndNavigate(BuildContext context) async {
    if (_imageFile == null) {
      CommonService.showToast("Vui lòng chọn ảnh để upload", context);
      return;
    }

    try {
      final tempDir = await getTemporaryDirectory();
      final path = tempDir.path;
      int rand = math.Random().nextInt(10000);
      if (_imageFile != null) {
        final image = image_format.decodeImage(
          File(_imageFile!.path).readAsBytesSync(),
        );
        if (image != null) {
          final thumbnail = image_format.copyResize(
            image,
            width: 200,
          );

          File image2 = File('$path/img_$rand.jpg');
          await image2.writeAsBytes(
            image_format.encodeJpg(thumbnail, quality: 72),
          );

          await uploadImageAvatar(
            widget.userID,
            image2.path,
            context,
          ).then((data) {
            if (data != null) {
              print("Thienlogin : uploadImageAvatar : $data");
            } else {
              CommonService.showToast("Vui lòng thử lại sau", context);
            }
          });
        }
      }
    } catch (e) {
      print('lỗi gì đây $e');
    }
  }

  void _onImageButtonPressed(ImageSource source, {context}) async {
    final pickedFile = await _picker.pickImage(source: source);

    setState(() {
      _imageFile = pickedFile;
    });
  }

  static Future<dynamic> uploadImageAvatar(
    String userId,
    String path,
    BuildContext context,
  ) async {
    List<String> st = path.split("/");
    String filename = st[st.length - 1];
    print('thay_avatar : uploadImageAvatar : Dang upload... ');
    var body = FormData.fromMap({
      'avatar': await MultipartFile.fromFile(path, filename: filename),
    });
    Dio dio = Dio();
    String urlTrangChu = 'https://du-an-2023.vercel.app/doiavatar/$userId';

    Map<String, String> header = {};
    dio.options.headers = header;
    try {
      Response response = await dio.post(urlTrangChu, data: body);

      return response.data;
    } catch (e) {
      DioError di = e as DioError;

      return di.message;
    } finally {
      CommonService.showToast("Thay ảnh đại diện thành công", context);
      // Không gọi Navigator.pop ở đây
    }
  }
}

class InventoryData {
  final bool dataToPass;
  final bool boolValue;

  InventoryData(this.dataToPass, this.boolValue);
}
