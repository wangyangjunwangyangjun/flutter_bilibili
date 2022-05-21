import 'package:flutter/material.dart';
import 'package:flutter_bilibili/core/viewmodel/video_view_model.dart';
import 'package:flutter_bilibili/ui/shared/app_theme.dart';
import 'package:flutter_bilibili/ui/shared/size_fit.dart';
import 'package:provider/provider.dart';

import 'core/router/router.dart';
import 'core/viewmodel/base_data_view_model.dart';

main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (ctx) => HYBaseDataViewModel()),
      ChangeNotifierProxyProvider<HYBaseDataViewModel, HYVideoViewModel>(
          create: (cts) => HYVideoViewModel(),
          update: (ctx, baseDataVM, videoVM) {
            videoVM?.updateBaseData(baseDataVM);
            return videoVM as HYVideoViewModel;
          })
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HYSizeFit.initialize(); //初始化屏幕适配
    return MaterialApp(
      title: '哔哩哔哩',
      theme: HYAppTheme.norTheme,
      //主题
      initialRoute: HYRouter.initialRoute,
      //起始路由
      routes: HYRouter.routes,
      //对应的路由
      onGenerateRoute: HYRouter.generateRoute,
      //后面再改
      onUnknownRoute: HYRouter.unKnowRoute, //未找到也面跳转至该页
    );
  }
}
