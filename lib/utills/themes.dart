import 'dart:ui';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Themes {
  static const Color primaryColor = Color.fromRGBO(112, 173, 71, 1);
  static const Color darkPrimaryColor = Color(0xff198754);
  static const Color lightGreen = Color(0xff99FF33);
  static const Color defaultGreenColor = Color.fromRGBO(112, 173, 71, 1);
  static const Color darkGreenHeader = Color(0xff006400);
  static const Color defaultLightBGColor = Color.fromRGBO(198, 224, 180, 0.5);
  static const Color defaultDarkBGColor = Color.fromRGBO(169, 208, 142, 0.5);
  static const Color defaultLightGreenColor = Color.fromRGBO(112, 173, 71, 0.8);
  static const Color headline = Color(0xffE2E1E1);
  static const Color iconColor = Color(0xff7F8489);
  static Color backgroundColour = Colors.green.withOpacity(0.3);

  static TextStyle heading1 = TextStyle(
      fontSize: 40.r, fontWeight: FontWeight.w700, letterSpacing: -0.36);
  static TextStyle heading2 = TextStyle(
    fontSize: 36.r,
    fontWeight: FontWeight.w700,
    color: headline,
  );
  static TextStyle heading3 = const TextStyle(
      fontSize: 24, fontWeight: FontWeight.w700, letterSpacing: -0.36);
  static TextStyle heading4 = const TextStyle(
      fontSize: 22, fontWeight: FontWeight.w700, letterSpacing: -0.36);
  static TextStyle heading5 = const TextStyle(
      fontSize: 20, fontWeight: FontWeight.w700, letterSpacing: -0.36);
  static TextStyle heading6 = const TextStyle(
      fontSize: 18, fontWeight: FontWeight.w700, letterSpacing: -0.36);
  static TextStyle bodyText1 = const TextStyle(
      fontSize: 18, fontWeight: FontWeight.w400, letterSpacing: -0.36);
  static TextStyle bodyText2 = const TextStyle(
      fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: -0.36);

  /// ledger heading style
  static TextStyle tableHeadPortrait(Color? color) => TextStyle(
        color: color ?? Colors.white,
        fontSize: 43.r,
        fontWeight: FontWeight.w600,
      );

  // static TextStyle tableHeadLandscape(Color? color) => TextStyle(
  //       color: color ?? Colors.white,
  //       fontSize: 40.r,
  //       fontWeight: FontWeight.w600,
  //     );

  /// ledger data style
  static TextStyle tableData = TextStyle(
    color: Colors.black,
    fontSize: 35.r,
    fontWeight: FontWeight.w400,
  );

  /// ledger total style
  static TextStyle tableTotal = TextStyle(
    color: Colors.black,
    fontSize: 35.r,
    fontWeight: FontWeight.w600,
  );
}