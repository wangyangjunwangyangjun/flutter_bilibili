import 'package:flutter/material.dart';

class HYAppTheme {
  //共有属性
  static const double xSmallFontSize = 14;
  static const double smallFontSize = 16;
  static const double normalFontSize = 22;
  static const double largeFontSize = 24;
  static const double xLargeFontSize = 24;

  //普通模式
  static const Color norTextColors = Colors.red;
  static final ThemeData norTheme = ThemeData(
    primarySwatch: Colors.amber, //包含大部分颜色设置
    canvasColor: Color.fromRGBO(255, 254, 222, 1), //APP背景颜色
    textTheme: const TextTheme(
      bodySmall: TextStyle(fontSize: xSmallFontSize),
      displaySmall: TextStyle(fontSize: smallFontSize, color: Colors.black),
      displayMedium: TextStyle(fontSize: normalFontSize),
      displayLarge: TextStyle(fontSize: largeFontSize),
    ),
  );

  //暗黑模式
  static const Color darkTextColors = Colors.green;
  static final ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.grey,
    textTheme: const TextTheme(
      bodyText1: TextStyle(
        fontSize: normalFontSize,
        color: darkTextColors,
      ),
    ),
  );
}
