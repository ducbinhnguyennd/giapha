import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:giapha/routes.dart';
import 'package:giapha/screens/splash_screen.dart';

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    int backButtonCount = 0;

    return MaterialApp(
      title: 'Truyền Thống Việt',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      routes: routes,
      home: Builder(
        // ignore: deprecated_member_use
        builder: (BuildContext context) => WillPopScope(
          onWillPop: () async {
            backButtonCount++;

            if (backButtonCount == 2) {
              SystemNavigator.pop();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Nhấn Back lần nữa để thoát"),
                  duration: Duration(seconds: 2),
                ),
              );
            }
            return false;
          },
          child: SplashScreen(),
        ),
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
