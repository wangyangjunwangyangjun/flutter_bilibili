import 'package:flutter/material.dart';
import 'package:flutter_bilibili/ui/shared/app_theme.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '哔哩哔哩',
      theme: HYAppTheme.norTheme,
    );
  }
}
