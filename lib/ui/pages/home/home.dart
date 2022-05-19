import 'package:flutter/material.dart';
import 'package:flutter_bilibili/core/extension/int_extension.dart';

import 'home_content.dart';
import 'initialize_item.dart';

class HYHomeScreen extends StatelessWidget {
  static const String routeName = "/home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          //防止被手机顶部栏遮挡
          child: HYHomeContent()),
    );
  }
}
