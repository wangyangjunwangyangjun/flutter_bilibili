import 'package:flutter/material.dart';

//加载视频拿多少数量
class HYBaseDataViewModel extends ChangeNotifier {
  int _rid = 1;  //分区
  int _pn = 1;  //页数
  int _ps = 11;  //每页项数

  int get ps => _ps;

  set ps(int value) {
    _ps = value;
    notifyListeners();
  }

  int get pn => _pn;

  set pn(int value) {
    _pn = value;
    notifyListeners();
  }

  int get rid => _rid;

  set rid(int value) {
    _rid = value;
    notifyListeners();
  }
}