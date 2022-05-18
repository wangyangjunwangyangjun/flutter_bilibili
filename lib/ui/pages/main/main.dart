import 'package:flutter/material.dart';
import 'package:flutter_bilibili/core/extension/int_extension.dart';
import 'package:flutter_bilibili/ui/pages/main/initialize_items.dart';

class HYMainScreen extends StatefulWidget {
  static const String routeName = "/"; //起始路由

  @override
  State<HYMainScreen> createState() => _HYMainScreenState();
}

class _HYMainScreenState extends State<HYMainScreen> {
  int _currentIndex = 0; //当前显示的page编号
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 11.px,
        unselectedFontSize: 10.px,
        selectedItemColor: Color.fromRGBO(210, 83, 125, 1),
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        items: items,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}