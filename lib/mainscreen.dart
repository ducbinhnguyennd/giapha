import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:giapha/constant/asset_path_const.dart';
import 'package:giapha/constant/colors_const.dart';
import 'package:giapha/constant/double_x.dart';
import 'package:giapha/screens/setting_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  static const routeName = 'main_screen';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  final _storage = const FlutterSecureStorage();
  String _username = '';
  int _backButtonCount = 0;

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 5, vsync: this); // Change the length as needed

    _storage.read(key: 'user').catchError((value) {
      print("Error Is: $value");
    }).then((value) {
      var data = jsonDecode(value!);
      var email = data['user']['Email'];
      setState(() {
        _username = email ?? '';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        print('poped');
        _backButtonCount++;

        if (_backButtonCount == 2) {
          return true; // allow back navigation to happen
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Nhấn Back lần nữa để thoát"),
              duration: Duration(seconds: 2),
            ),
          );
          return false; // prevent back navigation
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            // HomePage(),
            // FavoriteMangaScreen(),

            // BangTinScreen(),
            // BXHScreen(),
            Container(),
            Container(),
            Container(),
            Container(),
            TaikhoanScreen()
          ],
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              decoration: const BoxDecoration(color: Colors.white),
              height: DoubleX.kLayoutHeightMedium + 10,
              child: TabBar(
                  unselectedLabelColor: Colors.black,
                  labelColor: ColorConst.colorPrimary50,
                  indicatorColor: Colors.transparent,
                  indicatorWeight: DoubleX.kPaddingSizeTiny_0XX,
                  labelPadding: const EdgeInsets.all(0),
                  controller: _tabController,
                  tabs: const <Tab>[
                    Tab(
                      icon: ImageIcon(
                        AssetImage(AssetsPathConst.tabHome),
                        size: DoubleX.kSizeLarge - 5,
                      ),
                      iconMargin:
                          EdgeInsets.only(bottom: DoubleX.kPaddingSizeZero),
                      child: Visibility(
                        visible: true,
                        child: Text(
                          'Trang Chủ',
                          style: TextStyle(fontSize: DoubleX.kFontSizeTiny_1X),
                        ),
                      ),
                    ),
                    Tab(
                      icon: ImageIcon(
                        AssetImage(AssetsPathConst.tabBook),
                        size: DoubleX.kSizeLarge - 5,
                      ),
                      iconMargin:
                          EdgeInsets.only(bottom: DoubleX.kPaddingSizeZero),
                      child: Visibility(
                        visible: true,
                        child: Text(
                          'Tủ truyện',
                          style: TextStyle(fontSize: DoubleX.kFontSizeTiny_1X),
                        ),
                      ),
                    ),
                    Tab(
                      icon: ImageIcon(
                        AssetImage(AssetsPathConst.tabTop),
                        size: DoubleX.kSizeLarge - 5,
                      ),
                      iconMargin:
                          EdgeInsets.only(bottom: DoubleX.kPaddingSizeZero),
                      child: Visibility(
                        visible: true,
                        child: Text(
                          'Thế giới',
                          style: TextStyle(fontSize: DoubleX.kFontSizeTiny_1X),
                        ),
                      ),
                    ),
                    Tab(
                      icon: Icon(Icons.favorite_border_rounded,
                          size: DoubleX.kSizeLarge),
                      iconMargin:
                          EdgeInsets.only(bottom: DoubleX.kPaddingSizeZero),
                      child: Visibility(
                        visible: true,
                        child: Text(
                          'BXH',
                          style: TextStyle(fontSize: DoubleX.kFontSizeTiny_1X),
                        ),
                      ),
                    ),
                    Tab(
                      icon: ImageIcon(
                        AssetImage(AssetsPathConst.tabUser),
                        size: DoubleX.kSizeLarge - 5,
                      ),
                      iconMargin:
                          EdgeInsets.only(bottom: DoubleX.kPaddingSizeZero),
                      child: Visibility(
                        visible: true,
                        child: Text(
                          'Tài khoản',
                          style: TextStyle(fontSize: DoubleX.kFontSizeTiny_1X),
                        ),
                      ),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
