import 'package:flutter/material.dart';

import 'create_material_color.dart';

class HYAppTheme {
  //共有属性
  static const double xxxSmallFontSize = 10;
  static const double xxSmallFontSize = 12;
  static const double xSmallFontSize = 14;
  static const double smallFontSize = 16;
  static const double normalFontSize = 22;
  static const double largeFontSize = 24;
  static const double xLargeFontSize = 26;

  //普通模式
  static const Color norTextColors = Colors.red;
  static final ThemeData norTheme = ThemeData(
    primarySwatch: createMaterialColor(Colors.white), //包含大部分颜色设置
    canvasColor: Color.fromRGBO(241, 242, 244, 1), //APP背景颜色
    textTheme: const TextTheme(
      bodySmall: TextStyle(fontSize: xSmallFontSize),
      displaySmall: TextStyle(fontSize: smallFontSize),
      displayMedium: TextStyle(fontSize: normalFontSize),
      displayLarge: TextStyle(fontSize: largeFontSize),
    ),
  );

  //暗黑模式
  static const Color darkTextColors = Colors.green;
  static final ThemeData darkTheme = ThemeData(
    primarySwatch: createMaterialColor(Color.fromRGBO(24, 25, 27, 1)),
    canvasColor: Color.fromRGBO(0, 0, 0, 1),
    textTheme: const TextTheme(
      bodySmall: TextStyle(fontSize: xSmallFontSize),
      displaySmall: TextStyle(fontSize: smallFontSize),
      displayMedium: TextStyle(fontSize: normalFontSize),
      displayLarge: TextStyle(fontSize: largeFontSize),
    ),
  );
}