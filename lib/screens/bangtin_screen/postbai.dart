import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:giapha/api_all/apitrangchu.dart';
import 'package:giapha/model/user_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:giapha/constant/colors_const.dart';
import 'package:giapha/constant/common_service.dart';
import 'package:giapha/constant/double_x.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as image_format;
import 'dart:math' as math;

class PostBaiVietScreen extends StatefulWidget {
  final String userId;

  const PostBaiVietScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _PostBaiVietScreenState createState() => _PostBaiVietScreenState();
}

class _PostBaiVietScreenState extends State<PostBaiVietScreen> {
  TextEditingController contentController = TextEditingController();
  ApiPostBaiDang apiService = ApiPostBaiDang();
  XFile? _imageFile;
  final _picker = ImagePicker();
  Data? currentUser;
  bool isAvatarChanged = false;

  @override
  Widget build(BuildContext context) {
    InventoryData dataToPass = InventoryData(isAvatarChanged, false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Viết bài mới'),
        backgroundColor: ColorConst.colorPrimary50,
        leading: InkWell(
            onTap: (() {
              Navigator.of(context).pop(dataToPass);
            }),
            child: Icon(Icons.arrow_back_ios)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: contentController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Nhập nội dung bài đăng...',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: MaterialButton(
                    onPressed: () {
                      _onImageButtonPressed(ImageSource.gallery,
                          context: context);
                    },
                    height: DoubleX.kLayoutHeightTiny_1XX,
                    color: ColorConst.colorPrimary,
                    child: const Text(
                      "Chọn ảnh...",
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: ColorConst.colorPrimaryText),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.only(bottom: DoubleX.kPaddingSizeMedium_1XX),
              child: _imageFile != null
                  ? Center(
                      child: SizedBox(
                        width: DoubleX.kLayoutWidthHuge,
                        height: DoubleX.kLayoutHeightHuge,
                        child: Image.file(File(_imageFile!.path),
                            width: DoubleX.kSizeHuge,
                            height: DoubleX.kSizeHuge),
                      ),
                    )
                  : const Text("Bấm nút chọn ảnh ở trên để chọn ảnh!"),
            ),
            InkWell(
              onTap: (() async {
                try {
                  if (contentController.text.isEmpty) {
                    CommonService.showToast(
                        'Vui lòng nhập nội dung bài viết', context);
                    return;
                  }

                  String imagePath = '';
                  if (_imageFile != null) {
                    final tempDir = await getTemporaryDirectory();
                    final path = tempDir.path;
                    int rand = math.Random().nextInt(10000);
                    final image = image_format
                        .decodeImage(File(_imageFile!.path).readAsBytesSync());
                    final thumbnail =
                        image_format.copyResize(image!, width: 700);

                    File image2 = File('$path/img_$rand.jpg');

                    await image2.writeAsBytes(
                        image_format.encodeJpg(thumbnail, quality: 72));

                    imagePath = image2.path;
                  }

                  uploadImageAvatar(widget.userId, contentController.text,
                          imagePath, context)
                      .then((data) {
                    if (data != null) {
                      print(" uploadImageAvatar : $data");
                    } else
                      (e) {
                        Fluttertoast.showToast(
                            msg: '${e}',
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.TOP,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      };
                  });

                  CommonService.showToast('Đăng bài viết thành công', context);
                  await Future.delayed(Duration(seconds: 1));
                  setState(() {
                    isAvatarChanged = true;
                  });
                  Navigator.pop(context, InventoryData(isAvatarChanged, true));
                } catch (e) {
                  print('lỗi gì đây $e');
                }
              }),
              child: Container(
                height: 45,
                width: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: ColorConst.colorPrimary50),
                child: Center(
                    child: Text(
                  'Đăng bài',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onImageButtonPressed(ImageSource source, {context}) async {
    final pickedFile = await _picker.pickImage(source: source);

    setState(() {
      _imageFile = pickedFile;
    });
  }

  static Future<dynamic> uploadImageAvatar(
      String userId, String content, String? path, BuildContext context) async {
    var body = FormData();
    if (path != null && path != '') {
      List<String> st = path.split("/");
      String filename = st[st.length - 1];
      body.files.add(MapEntry(
        'images',
        await MultipartFile.fromFile(path, filename: filename),
      ));
    }
    body.fields.addAll([
      MapEntry('content', content),
    ]);
    Dio dio = Dio();
    String urlTrangChu = 'https://appgiapha.vercel.app/postbaiviet/$userId';

    Map<String, String> header = {};
    dio.options.headers = header;
    try {
      Response response = await dio.post(urlTrangChu, data: body);

      return response.data;
    } catch (e) {
      // ignore: deprecated_member_use
      DioError di = e as DioError;

      return di.message;
    } finally {}
  }
}

class InventoryData {
  final bool dataToPass;
  final bool boolValue;

  InventoryData(this.dataToPass, this.boolValue);
}
