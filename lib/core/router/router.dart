import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bilibili/ui/pages/dynamic_circle/dynamic_circle.dart';
import 'package:flutter_bilibili/ui/pages/home/home.dart';
import 'package:flutter_bilibili/ui/pages/main/main.dart';
import 'package:flutter_bilibili/ui/pages/mine/mine.dart';
import 'package:flutter_bilibili/ui/pages/video_play/video_play.dart';
import 'package:flutter_bilibili/ui/pages/vip_shop/vip_shop.dart';

class HYRouter {
  static const String initialRoute = HYMainScreen.routeName; //初始化路由
  static Map<String, WidgetBuilder> routes = {
    HYMainScreen.routeName: (ctx) =>HYMainScreen(),
    HYHomeScreen.routeName: (ctx) => HYHomeScreen(),
    HYDynamicCircleScreen.routeName: (ctx) => HYDynamicCircleScreen(),
    HYMineScreen.routeName: (ctx) => HYMineScreen(),
    HYVipShopScreen.routeName: (ctx) => HYVipShopScreen(),
    HYVideoPlayScreen.routeName: (ctx) => HYVideoPlayScreen(),
  };

  //后改
  static final RouteFactory generateRoute = (setting) {
    return null;
  };
  //找不到页面
  static final RouteFactory unKnowRoute = (setting) {
    return null;
  };
}
