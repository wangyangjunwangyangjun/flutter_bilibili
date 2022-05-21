import 'package:flutter_bilibili/core/service/request/home_request.dart';

import '../../../core/model/video_model.dart';
import '../../../core/viewmodel/video_view_model.dart';

void loadMoreVideosData(HYVideoViewModel videoVM) {
  //下拉请求数据
  HYHomeRequest.getVideoData(videoVM.baseDataVM.rid, videoVM.baseDataVM.pn, videoVM.baseDataVM.ps).then((res) {
    videoVM.videos.addAll(res);
  });
}

void refreshVideosData(HYVideoViewModel videoVM) {
  //上拉请求数据
  HYHomeRequest.getVideoData(videoVM.baseDataVM.rid, videoVM.baseDataVM.pn, videoVM.baseDataVM.ps).then((res) {
    videoVM.videos = videoVM.videos.reversed.toList();
    videoVM.videos.addAll(res);
    videoVM.videos = videoVM.videos.reversed.toList();
  });
}