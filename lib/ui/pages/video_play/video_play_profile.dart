import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bilibili/core/extension/int_extension.dart';
import 'package:flutter_bilibili/core/model/video_model.dart';
import 'package:flutter_bilibili/ui/pages/video_play/video_play_related_video_item.dart';
import 'package:flutter_bilibili/ui/pages/video_play/video_play_video_info.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import '../../../core/model/archive_related_model.dart';
import '../../../core/service/request/video_play_request.dart';

class HYVideoPlayProfile extends StatefulWidget {
  HYVideoModel video;
  List<HYVideoModel> relatedVideos = [];
  List<HYVideoModel> allRelatedVideos = []; //最多40条，这个api没有分页的设置，就全加载进来
  int pageIndex = 1;
  int pageSize = 10;

  HYVideoPlayProfile(this.video);

  @override
  State<HYVideoPlayProfile> createState() => _HYVideoPlayProfileState();
}

class _HYVideoPlayProfileState extends State<HYVideoPlayProfile> {
  List<Widget> widgets = [];

  @override
  void initState() {
    super.initState();
    HYVideoRequestRequest.getArchiveRelatedData(widget.video.aid).then((value) {
      widget.allRelatedVideos.addAll(value);
      widget.relatedVideos.addAll(widget.allRelatedVideos
          .sublist(0, widget.pageIndex * widget.pageSize));
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      onLoad: () async {
        await Future.delayed(Duration(seconds: 1)).then((value) {
          setState(() {
            //每次获取新的4条数据
            widget.relatedVideos.addAll(widget.allRelatedVideos.sublist(widget.pageIndex * widget.pageSize, (++widget.pageIndex) * widget.pageSize));
          });
        });
      },
      child: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildVideoPlayVideoInfo(widget.video),
              buildHYVideoPlayRelatedVideos()
            ],
          ),
        ),
      ),
    );
  }

  /**
   * relatedVideos要放在widget里，而不是state里，否则这里的的length始终为0
   */
  Widget buildHYVideoPlayRelatedVideos() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.px, vertical: 40.px),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: widget.relatedVideos.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 0.9),
        itemBuilder: (ctx, index) {
          return HYVideoPlayRelatedVideoItem(widget.relatedVideos[index]);
        },
      ),
    );
  }
}
