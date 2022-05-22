import 'package:flutter/material.dart';
import 'package:flutter_bilibili/ui/pages/video_play/video_play_recommend.dart';
import 'package:flutter_bilibili/ui/pages/video_play/video_play_video_info.dart';
class HYVideoPlayProfile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildVideoPlayVideoInfo(),
        buildVideoPlayRecommend()
      ],
    );
  }
}
