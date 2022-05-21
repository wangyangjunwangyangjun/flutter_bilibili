import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bilibili/core/extension/int_extension.dart';
import 'package:flutter_bilibili/core/model/video_model.dart';

import '../../../core/viewmodel/video_view_model.dart';
import 'home_video_item.dart';

class HYHomeRefreshItem extends StatefulWidget {
  int mode;  //上拉还是下拉
  List<HYVideoModel> videos = [];

  HYHomeRefreshItem(this.mode, this.videos);

  @override
  State<HYHomeRefreshItem> createState() => _HYHomeRefreshItemState();
}

//上拉刷新的出来布局
class _HYHomeRefreshItemState extends State<HYHomeRefreshItem> {
  @override
  Widget build(BuildContext context) {
    //上拉
    if(widget.mode == 0) {
      return Column(
        children: random2(
            buildHYHomeRefreshItemVideos(widget.videos.sublist(0, 10)),
            buildHYHomeRefreshItemOneVideo(widget.videos[10])),
      );
    }else {
      //下拉
      return Column(
        children: random2(
            buildHYHomeRefreshItemVideos(widget.videos.sublist(widget.videos.length-11, widget.videos.length-1)),
            buildHYHomeRefreshItemOneVideo(widget.videos[widget.videos.length-1])),
      );
    }

  }

  Widget buildHYHomeRefreshItemVideos(List<HYVideoModel> videos) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: videos.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 0.9
          ),
      itemBuilder: (ctx, index) {
        return HYHomeVideoItem(videos[index]);
      },
    );
  }

  Widget buildHYHomeRefreshItemOneVideo(HYVideoModel video) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4.px),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.px),
        height: 190.px,
        width: double.infinity,
        child: Image.network(
          video.pic,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  //随机布局，如果是0就A在前B在后；反之则B在前，A在后
  List<Widget> random2(Widget widgetA, Widget widgetB) {
    int randomNum = Random().nextInt(2);
    if (randomNum == 0) {
      return [widgetA, widgetB];
    }
    return [widgetB, widgetA];
  }
}
