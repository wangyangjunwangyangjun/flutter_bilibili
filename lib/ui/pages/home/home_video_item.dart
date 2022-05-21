import 'package:flutter/material.dart';
import 'package:flutter_bilibili/core/extension/int_extension.dart';
import 'package:flutter_bilibili/core/model/video_model.dart';
import 'package:flutter_bilibili/ui/shared/app_theme.dart';
import 'package:flutter_bilibili/ui/shared/number_compute.dart';

final _radius = 6.px;
final _iconSize = 14.px;

class HYHomeVideoItem extends StatefulWidget {
  HYVideoModel _video;

  HYHomeVideoItem(this._video);

  @override
  State<HYHomeVideoItem> createState() => _HYHomeVideoItemState();
}

class _HYHomeVideoItemState extends State<HYHomeVideoItem> {
  @override
  Widget build(BuildContext context) {
    return Stack(
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
                  buildHomeVideoItemCover(widget._video),
                  buildHomeVideoItemInfo(widget._video, context),
                  buildHomeVideoItemDuration(widget._video.durationText)
                ],
              ),
              buildHomeVideoItemTitle(context, widget._video.title),
            ],
          ),
        ),
        buildHomeVideoBottomInfo(context, widget._video.owner.name),
        buildHomeVideoMoreIcon()
      ],
    );
  }
}

//更多按钮
class buildHomeVideoMoreIcon extends StatelessWidget {
  const buildHomeVideoMoreIcon({
    Key? key,
  }) : super(key: key);

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
Widget buildHomeVideoItemCover(HYVideoModel video) {
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
Widget buildHomeVideoItemDuration(String duration) {
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
Widget buildHomeVideoItemInfo(HYVideoModel video, BuildContext context) {
  int? _view = video.stat["view"];
  int? _remark = video.stat["danmaku"];

  return Positioned(
    left: 5.px,
    bottom: 3.px,
    child: Row(
      children: [
        buildHomeVideoIconInfoItem(
            "assets/image/icon/play_custom.png", _view!, context),
        SizedBox(
          width: 10.px,
        ),
        buildHomeVideoIconInfoItem(
            "assets/image/icon/remark.png", _remark!, context),
      ],
    ),
  );
}

//视频的标题
Widget buildHomeVideoItemTitle(BuildContext context, String videoTitle) {
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
Widget buildHomeVideoBottomInfo(BuildContext context, String info) {
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
Widget buildHomeVideoIconInfoItem(String icon, int num, BuildContext context) {
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
