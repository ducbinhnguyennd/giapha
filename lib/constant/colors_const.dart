import 'package:flutter/material.dart';

class ColorConst {
  static const Color colorPrimary = Color(0xffFFA1A9);
  static const Color colorPrimary30 = Color(0xffED4264);
  static const Color colorPrimary50 = Color(0xffFF4D6D);
  static const Color colorPrimary80 = Color.fromARGB(255, 244, 217, 219);
  static const Color colorPrimary120 = Color(0xffFFA1A9);
  static const Color colorSecondary = Color(0xffFFA1A9);
  static const Color colorTertiary = Color(0xffFFA1A9);
  static const Color colorQuaternary = Color.fromARGB(255, 242, 172, 177);
  static const Color colorBackgroundSecondary = Color(0xFFE6E9EF);
  static const Color colorBackgroundTertiary = Color(0xFF1f282a);
  static const Color backgroundScaffoldColor = Color(0xFFF3F3F3);
  static const Color colorPrimaryText = Color(0xFFFFFFFF);
  static const Color colorPrimaryTextDark = Color(0xFFF5F5F5);
  static const Color colorBackgroundGray = Color(0xffE6EBEE);
  static const Color colorGrey = Color(0xff999999);
  static const Color colorConfigButtonBackground = Color(0xff183153);
  static const Color colorDanger = Color(0xffcf6679);
  static const Color colorSuccess = Color(0xff67c23a);
  static const Color colorWarning = Color(0xffffd682);
  static const Color colorFail = Color(0xfff56c6c);
  static const Color colorButtonSnackBarLoginColor = Color(0xffffd682);
  static const Color colorButtonCategory1 = Color(0xffcf6679);
  static const Color colorPrimaryTextLight = Color(0xff313131);
  static const Color colorPrimaryTextLight1 = Color(0xff4F2B37);
  static const Color colorTextStory = Color(0xff515356);
  static const Color colorTextStory1 = Color(0xffB67A5D);
  static const Color colorTextVip = Color(0xffffd682);
  static const Color colorTextVip2 = Color(0xffffd682);
  static const Color colorVipBackground = Color(0xff050028);
  static const Color colorReadStoryBackground = Color(0xffbfe2fd);
  static const Color colorVipBackground2 = Color(0xff515356);
  static const Color colorBackgroundStory = Color(0xffF6F6F6);
  static const Color colorRedFreeBackground = Color(0xffB51C2C);
  static const Color colorRedFreeBackground1 = Color(0xffD00E17);
  static const Color colorOrange = Color(0xffFA7935);
  static const Color colorBorderLogin = Color(0xff97b4c9);
  static const Color colorWhite = Color(0xFFFFFFFF);

  static const Color colorGradientPalaceHolderBackgroundBegin =
      Color(0xffFEE5E6);
  static const Color colorGradientPalaceHolderBackgroundEnd = Color(0xffD5D5D5);
  static const Color colorBgButtonRadio = Color(0xff3B3B4F);
  static const Color colorBgNovelGray = Color(0xffdcdcdc);
  static const Color colorBgNovelBlack = Color(0xff111111);
  static const Color colorBgNovelYellow = Color(0xffF1EDA9);
  static const Color colorDotColor = Color(0xFFFF5A93);
  static const Color colorBgElevatedButtonColor = Color(0xFF1A65C7);
}

class Gradients {
  static const Gradient defaultGradientBackground = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [ColorConst.colorPrimary, ColorConst.colorSecondary]);

  static const Gradient vipGradientBackground = LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topCenter,
      colors: [ColorConst.colorVipBackground, ColorConst.colorVipBackground2]);

  static Gradient placeHolderGradientBackground = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        ColorConst.colorGradientPalaceHolderBackgroundBegin.withOpacity(1.0),
        ColorConst.colorGradientPalaceHolderBackgroundEnd.withOpacity(1.0)
      ]);

  static Gradient fourButtonsGradientBackground = const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        // Color(0xFF30A0CE),
        // Color(0xFFAD5C96),
        Color(0xFF398DBF),
        Color(0xFFE04086),
      ]);

  static LinearGradient shimmerGradient = const LinearGradient(
    colors: [
      Color(0xFFEBEBF4),
      Color(0xFFF4F4F4),
      Color(0xFFEBEBF4),
    ],
    stops: [
      0.1,
      0.3,
      0.4,
    ],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
    tileMode: TileMode.clamp,
  );

  static LinearGradient fourButtonsGradientBackground2 = const LinearGradient(
    colors: [
      Color(0xFFB5685E),
      Colors.transparent,
      Colors.transparent,
      // Color(0xFF793A19).withOpacity(1.0),
      Color(0xFFB15E56),
    ],
    stops: [
      0.0,
      0.2,
      0.8,
      1,
    ],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
    tileMode: TileMode.clamp,
  );

  static LinearGradient userGradientBackground = const LinearGradient(
    colors: [
      ColorConst.colorPrimary,
      Colors.transparent,
      Colors.transparent,
      // Color(0xFF793A19).withOpacity(1.0),
      Color(0xFFB15E56),
    ],
    stops: [
      0.0,
      0.4,
      0.6,
      1,
    ],
    begin: Alignment(0, 1),
    end: Alignment(0, -1),
    tileMode: TileMode.clamp,
  );
}
