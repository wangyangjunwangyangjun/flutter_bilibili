import 'package:flutter/material.dart';
import 'package:flutter_bilibili/core/extension/int_extension.dart';
import 'package:flutter_bilibili/ui/pages/home/home.dart';
import '../dynamic_circle/dynamic_circle.dart';
import '../mine/mine.dart';
import '../vip_shop/vip_shop.dart';

final _iconSize = 20.px;
final _activeIcon = 23.px;

final List<Widget> pages = [
  HYHomeScreen(),
  HYDynamicCircleScreen(),
  HYVipShopScreen(),
  HYMineScreen()
];
final List<BottomNavigationBarItem> items = [
  BottomNavigationBarItem(
    label: "首页",
    icon: Image.asset("assets/image/icon/home_custom.png", width: _iconSize, height: _iconSize),
    activeIcon: Image.asset("assets/image/icon/home_selected.png", width: _activeIcon, height: _activeIcon),
  ),
  BottomNavigationBarItem(
    label: "动态",
    icon: Image.asset("assets/image/icon/dynamic_custom.png", width: _iconSize, height: _iconSize),
    activeIcon: Image.asset("assets/image/icon/dynamic_selected.png", width: _activeIcon, height: _activeIcon),
  ),
  BottomNavigationBarItem(
    label: "会员购",
    icon: Image.asset("assets/image/icon/vip_custom.png", width: _iconSize, height: _iconSize),
    activeIcon: Image.asset("assets/image/icon/vip_selected.png", width: _activeIcon, height: _activeIcon),
  ),
  BottomNavigationBarItem(
    label: "我的",
    icon: Image.asset("assets/image/icon/mine_custom.png", width: _iconSize, height: _iconSize),
    activeIcon: Image.asset("assets/image/icon/mine_selected.png", width: _activeIcon, height: _activeIcon),
  ),
];
