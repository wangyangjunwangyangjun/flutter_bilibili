import 'package:flutter/material.dart';
import 'package:flutter_bilibili/ui/shared/app_theme.dart';
import 'package:flutter_bilibili/ui/shared/size_fit.dart';

import 'core/router/router.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HYSizeFit.initialize();  //初始化屏幕适配
    return MaterialApp(
      title: '哔哩哔哩',
      theme: HYAppTheme.norTheme, //主题
      initialRoute: HYRouter.initialRoute, //起始路由
      routes: HYRouter.routes, //对应的路由
      onGenerateRoute: HYRouter.generateRoute, //后面再改
      onUnknownRoute: HYRouter.unKnowRoute, //未找到也面跳转至该页
    );
  }
}
