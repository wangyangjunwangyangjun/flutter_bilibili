import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bilibili/core/extension/int_extension.dart';
import 'package:flutter_bilibili/core/model/tag_archive_tags_model.dart';
import 'package:flutter_bilibili/core/model/video_model.dart';
import 'package:flutter_bilibili/core/service/request/video_play_request.dart';
import 'package:flutter_bilibili/ui/shared/app_theme.dart';
import 'package:flutter_bilibili/ui/shared/math_compute.dart';

import '../home/home_video_item.dart';

TextStyle _textStyle = const TextStyle(
    color: Color.fromRGBO(159, 159, 159, 1),
    fontSize: HYAppTheme.xxSmallFontSize);

class buildVideoPlayVideoInfo extends StatefulWidget {
  HYVideoModel video;

  buildVideoPlayVideoInfo(this.video, {Key? key}) : super(key: key);

  @override
  State<buildVideoPlayVideoInfo> createState() =>
      _buildVideoPlayVideoInfoState();
}

class _buildVideoPlayVideoInfoState extends State<buildVideoPlayVideoInfo> {
  String _followers = "粉丝";
  int _videos = 0;
  List<HYTagArchiveTagsModel> tags = [];
  List<Widget> tagWidgets = [];

  @override
  void initState() {
    super.initState();
    HYVideoRequestRequest.getRelationStatData(widget.video.owner.mid)
        .then((value) {
      _followers = value.data.followerText;
      setState(() {});
    });
    HYVideoRequestRequest.getSpaceNavNumData(widget.video.owner.mid)
        .then((value) {
      _videos = value.data.video;
      setState(() {});
    });
    HYVideoRequestRequest.getTagArchiveTagsData(widget.video.aid).then((value) {
      tags.clear();
      tags.addAll(value);
      for (HYTagArchiveTagsModel tag in tags) {
        tagWidgets.add(buildVideoTag(tag.tagName));
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.px, horizontal: 20.px),
      child: Column(
        children: [
          buildVideoPlayVideoInfoOwnerInfo(
              widget.video.owner.face, widget.video.owner.name),
          SizedBox(height: 15.px,),
          buildVideoPlayVideoInfoVideoTitle(),
          SizedBox(height: 5.px,),
          buildVideoPlayVideoInfoVideoDetails(),
          SizedBox(height: 35.px,),
          buildVideoPlayVideoInfoButtonBanner(),
        ],
      ),
    );
  }

  Widget buildVideoPlayVideoInfoOwnerInfo(String ownerIcon, String ownerName) {
    return Row(
      children: [
        buildVideoPlayUserIcon(ownerIcon),
        Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.px),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ownerName,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: HYAppTheme.norTextColors),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$_followers粉丝",
                    style: _textStyle,
                  ),
                  SizedBox(width: 10.px),
                  Text(
                    "$_videos视频",
                    style: _textStyle,
                  )
                ],
              )
            ],
          ),
        )),
        TextButton(
          child: const Text("+  关注",),
          onPressed: () {

          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 13.px),
            backgroundColor: HYAppTheme.norTextColors,
            textStyle: TextStyle(fontSize: 13.px, color: Colors.white)
          ),
        )
      ],
    );
  }

  //圆形图标
  Widget buildVideoPlayUserIcon(String userLogo) {
    return Container(
      alignment: Alignment.centerLeft,
      child: CircleAvatar(
        backgroundImage: NetworkImage(userLogo),
      ),
    );
  }

  Widget buildVideoPlayVideoInfoVideoTitle() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                widget.video.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.black, fontSize: 17.px),
              ),
            ),
            GestureDetector(child: Image.asset("assets/image/icon/expanded_custom.png", width: 23.px,height: 23.px,)),
          ],
        ),
        SizedBox(height: 10.px,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildVideoPlayIconInfo("assets/image/icon/play_custom02.png",
                changeToWan(widget.video.stat["view"] ?? 0)),
            SizedBox(width: 10.px,),
            buildVideoPlayIconInfo("assets/image/icon/remark_custom02.png",
                changeToWan(widget.video.stat["danmaku"] ?? 0)),
            SizedBox(width: 10.px,),
            Text(
              getPubDataText(widget.video.pubdate),
              style: _textStyle,
            )
          ],
        ),
      ],
    );
  }

  Widget buildVideoPlayIconInfo(String icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          icon,
          width: 16.px,
          height: 16.px,
        ),
        Container(
          margin: EdgeInsets.only(left: 5.px),
          child: Text(
            text,
            style: _textStyle,
          ),
        )
      ],
    );
  }

  Widget buildVideoPlayVideoInfoVideoDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              widget.video.bvid,
              style: _textStyle,
            ),
            SizedBox(width: 8.px,),
            buildVideoPlayIconInfo(
                "assets/image/icon/ban_custom.png", "未经作者授权禁止转载"),
          ],
        ),
        SizedBox(height: 8.px,),
        Text(
          widget.video.desc,
          style: _textStyle,
        ),
        SizedBox(height: 30.px),
        Wrap(
          spacing: 10.px,
          runSpacing: 15.px,
          alignment: WrapAlignment.start,
          children: tagWidgets,
        )
      ],
    );
  }

  Widget buildVideoTag(String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6.px, horizontal: 12.px),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.px),
          color: Color.fromRGBO(246, 247, 249, 1)),
      child: Text(
        text,
        style: TextStyle(color: Color.fromRGBO(100, 101, 103, 1)),
      ),
    );
  }

  Widget buildVideoPlayVideoInfoButtonBanner() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        buildVideoPlayIconButton("assets/image/icon/like_custom.png",
            changeToWan(widget.video.stat["like"] ?? 0)),
        buildVideoPlayIconButton("assets/image/icon/dislike_custom.png", "不喜欢"),
        buildVideoPlayIconButton("assets/image/icon/coin_custom.png",
            changeToWan(widget.video.stat["coin"] ?? 0)),
        buildVideoPlayIconButton("assets/image/icon/collect_custom.png",
            changeToWan(widget.video.stat["favorite"] ?? 0)),
        buildVideoPlayIconButton("assets/image/icon/share_custom.png",
            changeToWan(widget.video.stat["share"] ?? 0)),
      ],
    );
  }

  Widget buildVideoPlayIconButton(String icon, String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          icon,
          width: 27.px,
          height: 27.px,
          color: Color.fromRGBO(95, 103, 106, 1),
        ),
        SizedBox(height: 10.px),
        Text(
          text,
          style: _textStyle,
        )
      ],
    );
  }
}
