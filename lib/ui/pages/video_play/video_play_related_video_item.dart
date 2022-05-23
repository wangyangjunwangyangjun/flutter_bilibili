import 'package:flutter/material.dart';
import 'package:flutter_bilibili/core/extension/int_extension.dart';
import 'package:flutter_bilibili/ui/pages/video_play/video_play.dart';
import 'package:flutter_bilibili/ui/shared/app_theme.dart';

import '../../../core/model/archive_related_model.dart';
import '../../../core/model/video_model.dart';
import '../../shared/math_compute.dart';

final _radius = 6.px;
final _iconSize = 14.px;

class HYVideoPlayRelatedVideoItem extends StatefulWidget {
  HYVideoModel _video;

  HYVideoPlayRelatedVideoItem(this._video);

  @override
  State<HYVideoPlayRelatedVideoItem> createState() => _HYVideoPlayRelatedVideoItemState();
}

class _HYVideoPlayRelatedVideoItemState extends State<HYVideoPlayRelatedVideoItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(HYVideoPlayScreen.routeName, arguments: widget._video);
      },
      child: Stack(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(_radius),
                topRight: Radius.circular(_radius),
              ),
            ),
            child: Column(
              children: [
                Stack(
                  children: [
                    buildVideoPlayRelatedVideoItemCover(widget._video),
                    buildVideoPlayRelatedVideoItemInfo(widget._video, context),
                    buildVideoPlayRelatedVideoItemDuration(widget._video.durationText)
                  ],
                ),
                buildVideoPlayRelatedVideoItemTitle(context, widget._video.title),
              ],
            ),
          ),
          buildVideoPlayRelatedVideoBottomInfo(context, widget._video.owner.name),
          buildVideoPlayRelatedVideoMoreIcon()
        ],
      ),
    );
  }
}

//更多按钮
class buildVideoPlayRelatedVideoMoreIcon extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Image.asset(
        "assets/image/icon/video_more_custom.png",
        width: _iconSize,
        height: _iconSize,
      ),
      right: 8.px,
      bottom: 8.px,
    );
  }
}

//视频封面
Widget buildVideoPlayRelatedVideoItemCover(HYVideoModel video) {
  return ClipRRect(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(_radius),
      topRight: Radius.circular(_radius),
    ),
    child: Image.network(
      video.pic,
      width: double.infinity,
      height: 110.px,
      fit: BoxFit.fill,
    ),
  );
}

//视频时长
Widget buildVideoPlayRelatedVideoItemDuration(String duration) {
  return Positioned(
    right: 5.px,
    bottom: 3.px,
    child: Text(duration,
        style: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
            fontSize: HYAppTheme.xxSmallFontSize)),
  );
}

//视频播放量、评论数
Widget buildVideoPlayRelatedVideoItemInfo(HYVideoModel video, BuildContext context) {
  int? _view = video.stat["view"];
  int? _remark = video.stat["danmaku"];

  return Positioned(
    left: 5.px,
    bottom: 3.px,
    child: Row(
      children: [
        buildVideoPlayRelatedVideoIconInfoItem(
            "assets/image/icon/play_custom.png", _view!, context),
        SizedBox(
          width: 10.px,
        ),
        buildVideoPlayRelatedVideoIconInfoItem(
            "assets/image/icon/remark.png", _remark!, context),
      ],
    ),
  );
}

//视频的标题
Widget buildVideoPlayRelatedVideoItemTitle(BuildContext context, String videoTitle) {
  return Container(
    alignment: Alignment.topLeft,
    margin: EdgeInsets.symmetric(vertical: 8.px, horizontal: 8.px),
    child: Text(
      videoTitle,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(color: Colors.black, fontSize: 13.px),
    ),
  );
}

//视频up主及id名称
Widget buildVideoPlayRelatedVideoBottomInfo(BuildContext context, String info) {
  return Positioned(
    bottom: 8.px,
    left: 8.px,
    child: Row(
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Image.asset(
          "assets/image/icon/uper_custom.png",
          width: _iconSize,
          height: _iconSize,
        ),
        Container(
          margin: EdgeInsets.only(left: 6.px),
          child: Text(info,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Color.fromRGBO(149, 149, 149, 1))),
        ),
      ],
    ),
  );
}

//视频播放量和评论如果过万，就要显示多少万
Widget buildVideoPlayRelatedVideoIconInfoItem(String icon, int num, BuildContext context) {
  double _numDiv = num.toDouble();
  int _flag = 0;
  if (num > 10000) {
    _numDiv = num / 10000;
    _flag = 1;
  }
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(
        icon,
        width: 13.px,
        height: 13.px,
      ),
      Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.only(left: 5.px),
        child: Text(
            _flag == 1 ? formatNum(_numDiv, 1) + "万" : formatNum(_numDiv, -1),
            style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 1),
                fontSize: HYAppTheme.xxSmallFontSize)),
      )
    ],
  );
}