import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class Styles {
  ///Color
  static Color get colorPrimary => const Color(0XFF34A8C5);

  static Color get colorSecondary => const Color(0xFF255c65);

  static Color get colorTertiary => const Color(0xFF5a4647);

  static Color get backgroundColor => const Color(0XFF1B1B27);

  static const FontColorWhite = Color(0xFFFFFFFF);
  static const FontColorGray = Color(0xFFBCBCBC);
  static const FontColorDarkGray = Color(0xFF8D9595);
  static const FontColorLiteGray = Color(0xFFE8E8E8);
  static const FontColorLiteGraycallendar = Color(0xFFEEEEEE);
  static const FontColorDarkGray1 = Color(0xFF9A9A9A);
  static const FontColorLiteGray2 = Color.fromRGBO(198, 198, 198, 1.0);

  ///gradient color
  static const ColorGradient1 = Color(0XFF379fb9);
  static const ColorGradient2 = Color(0XFF833356);

  ///categories color
  static Color categoryBlue = Colors.blue.shade700;
  static Color categoryGreen = Colors.green.shade400;
  static Color categoryDarkGreen = Colors.green.shade700;
  static Color categoryPurple = Colors.purple.shade600;
  static Color categoryRed = Colors.red.shade600;
  static Color categoryOrange = Colors.orange.shade600;
  static Color categoryBrown = Colors.brown;
  static Color categoryGray = Colors.grey;
  static Color categoryPink = Colors.pink;
  static Color categoryLightBlue = Colors.lightBlue;
  static Color categorySilver = Color(0XFFC0C0C0);

  static List<Color> categoryColors = [
    categoryBlue,
    categoryGreen,
    categoryDarkGreen,
    categoryPurple,
    categoryRed,
    categoryOrange,
    categoryBrown,
    categoryGray,
    categorySilver,
    categoryPink,
    categoryLightBlue
  ];

  //font
  static double get fontSize0 => 80.0.sp; //20

  /// Equals 30 px
  static double get fontSize01 => 65.0.sp; //30

  /// Equals 20 px
  static double get fontSize1 => 55.0.sp; //20

  /// Equals 18 px
  static double get fontSize2 => 50.0.sp; //18

  /// Equals 16 px
  static double get fontSize3 => 45.0.sp; //16

  /// Equals 14 px
  static double get fontSize4 => 40.0.sp; //14

  /// Equals 12 px
  static double get fontSize5 => 35.0.sp; //12

  /// Equals 10 px
  static double get fontSize6 => 30.0.sp; //10

  /// Equals 8 px
  static double get fontSize7 => 26.0.sp; //8

  static final inputDecorationStyle = InputDecorationTheme(
    contentPadding: EdgeInsets.symmetric(horizontal: 10),
    filled: true,
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: Styles.colorPrimary,
      ),
      borderRadius: const BorderRadius.all(
        Radius.circular(30),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Styles.colorPrimary,
      ),
      borderRadius: const BorderRadius.all(
        Radius.circular(30),
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Styles.colorPrimary,
      ),
      borderRadius: const BorderRadius.all(
        Radius.circular(30),
      ),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Styles.colorPrimary,
      ),
      borderRadius: const BorderRadius.all(
        Radius.circular(30),
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Styles.colorPrimary,
      ),
      borderRadius: const BorderRadius.all(
        Radius.circular(30),
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Styles.colorPrimary,
      ),
      borderRadius: const BorderRadius.all(
        Radius.circular(30),
      ),
    ),
    isDense: true,
  );
}

abstract class CommonSizes {
  static const TINY_LAYOUT_W_GAP = 10.0;
  static const SMALL_LAYOUT_W_GAP = 25.0;
  static const MED_LAYOUT_W_GAP = 50.0;
  static const BIG_LAYOUT_W_GAP = 75.0;
  static const BIGGER_LAYOUT_W_GAP = 100.0;
  static const BIGGEST_LAYOUT_W_GAP = 125.0;
  static const BORDER_RADIUS_STANDARD = 15.0;
  static const BORDER_RADIUS_CORNERS_BIG = 18.0;

  static final appBarHeight = 120.h;

  static final navBarHeight = 120.h;

  /// --------------- ///
  static final vSmallestSpace5v = SizedBox(height: 5.h);
  static final vSmallestSpace = SizedBox(height: 10.h);
  static final vSmallerSpace = SizedBox(height: 20.h);
  static final vSmallSpace = SizedBox(height: 30.h);
  static final vBigSpace = SizedBox(height: 40.h);
  static final vBiggerSpace = SizedBox(height: 50.h);
  static final vBiggestSpace = SizedBox(height: 60.h);
  static final vLargeSpace = SizedBox(height: 70.h);
  static final vLargerSpace = SizedBox(height: 80.h);
  static final vLargestSpace = SizedBox(height: 90.h);
  static final vHugeSpace = SizedBox(height: 100.h);

  static final hSmallestSpace = SizedBox(width: 10.w);
  static final hSmallerSpace = SizedBox(width: 20.w);
  static final hSmallSpace = SizedBox(width: 30.w);
  static final hBigSpace = SizedBox(width: 40.w);
  static final hBiggerSpace = SizedBox(width: 50.w);
  static final hBiggestSpace = SizedBox(width: 60.w);
  static final hLargeSpace = SizedBox(width: 70.w);
  static final hLargerSpace = SizedBox(width: 80.w);
  static final hLargestSpace = SizedBox(width: 90.w);
  static final hHugeSpace = SizedBox(width: 100.w);

  static const divider = Divider(thickness: 10);
}
