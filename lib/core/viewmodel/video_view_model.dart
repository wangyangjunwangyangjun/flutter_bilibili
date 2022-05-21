import 'package:flutter/cupertino.dart';
import 'package:flutter_bilibili/core/model/video_model.dart';
import 'package:flutter_bilibili/core/viewmodel/base_data_view_model.dart';

import '../service/request/home_request.dart';

class HYVideoViewModel extends ChangeNotifier {
  List<HYVideoModel> _videos = [];

  HYBaseDataViewModel _baseDataVM = HYBaseDataViewModel();

  List<HYVideoModel> get videos => _videos;

  set videos(List<HYVideoModel> value) {
    _videos = value;
  }

  //更新basedata
  void updateBaseData(HYBaseDataViewModel baseDataVM) {
    _baseDataVM = baseDataVM;
  }

  HYVideoViewModel() {
    //请求数据
    HYHomeRequest.getVideoData(_baseDataVM.rid, _baseDataVM.pn, _baseDataVM.ps)
        .then((res) {
      _videos = res;
      notifyListeners();
    });
  }

  HYBaseDataViewModel get baseDataVM => _baseDataVM;

}
