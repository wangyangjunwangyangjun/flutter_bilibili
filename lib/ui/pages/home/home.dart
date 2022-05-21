import 'package:flutter/material.dart';
import 'home_content.dart';

class HYHomeScreen extends StatelessWidget {
  static const String routeName = "/home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea( //防止被遮挡
          child: HYHomeContent()),
    );
  }
}
