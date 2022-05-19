import 'package:flutter/material.dart';
import 'package:flutter_bilibili/core/extension/int_extension.dart';
import 'package:flutter_bilibili/ui/pages/home/home.dart';
import '../dynamic_circle/dynamic_circle.dart';
import '../mine/mine.dart';
import '../vip_shop/vip_shop.dart';

final _iconSize = 18.px;
final _activeIcon = 18.px;

final List<Widget> pages = [
  HYHomeScreen(),
  HYDynamicCircleScreen(),
  HYVipShopScreen(),
  HYMineScreen()
];
final List<BottomNavigationBarItem> items = [
  buildBottomNavigationBarItem("首页", "home"),
  buildBottomNavigationBarItem("动态", "dynamic"),
  buildBottomNavigationBarItem("会员购", "vip"),
  buildBottomNavigationBarItem("我的", "mine"),
];

BottomNavigationBarItem buildBottomNavigationBarItem(
    String title, String iconName) {
  return BottomNavigationBarItem(
    label: title,
    icon: Image.asset(
      "assets/image/icon/${iconName}_custom.png",
      width: _iconSize,
      height: _iconSize,
      gaplessPlayback: true, //gaplessPlayback: 原图片保持不变，直到图片加载完成时替换图片，这样就不会出现闪烁
    ),
    activeIcon: Image.asset(
      "assets/image/icon/${iconName}_selected.png",
      width: _activeIcon,
      height: _activeIcon,
      gaplessPlayback: true,
    ),
  );
}
