import 'package:flutter/material.dart';
import 'package:giapha/constant/asset_path_const.dart';
import 'package:giapha/constant/colors_const.dart';
import 'package:giapha/mainscreen.dart';
import 'package:giapha/routes.dart';

class IntroSigin extends StatefulWidget {
  const IntroSigin({Key? key}) : super(key: key);
  static const routeName = 'introsigin';

  @override
  State<IntroSigin> createState() => _IntroSiginState();
}

class _IntroSiginState extends State<IntroSigin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(AssetsPathConst.backgroundStoryDetail),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height / 3,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [ColorConst.colorPrimary, Colors.white],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: ColorConst.colorPrimary,
                      spreadRadius: 20,
                      blurRadius: 40,
                      offset: Offset(0, -25),
                    ),
                  ]),
            ),
          ),
          Positioned(
            bottom: 200,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                    color: ColorConst.colorPrimary50, // Màu hồng

                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: Offset(0, 3),
                      ),
                    ]),
                child: TextButton(
                  onPressed: () {
                    RouteUtil.redirectToLoginScreen(context);
                  },
                  child: const Text(
                    'Đăng nhập',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 120,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                    border: Border.all(color: ColorConst.colorPrimary50),
                    color: Colors.white, // Màu hồng

                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: Offset(0, 3),
                      ),
                    ]),
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, MainScreen.routeName);
                  },
                  child: const Text(
                    'Tiếp tục không cần tài khoản',
                    style: TextStyle(
                      fontSize: 20,
                      color: ColorConst.colorPrimary50,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
              bottom: 80,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Bạn chưa có tài khoản? ',
                    style: TextStyle(
                        color: ColorConst.colorPrimary50, fontSize: 17),
                  ),
                  InkWell(
                    child: Text('Đăng ký ngay',
                        style: TextStyle(
                          color: ColorConst.colorPrimary50,
                          fontSize: 17,
                          decoration: TextDecoration.underline,
                        )),
                    onTap: (() {
                      RouteUtil.redirectToRegisterScreen(context);
                    }),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
