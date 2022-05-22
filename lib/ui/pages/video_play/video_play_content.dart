import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bilibili/core/extension/int_extension.dart';
import 'package:flutter_bilibili/core/model/video_model.dart';
import 'package:flutter_bilibili/ui/pages/video_play/video_play_comments.dart';
import 'package:flutter_bilibili/ui/pages/video_play/video_play_initialize_item.dart';
import 'package:flutter_bilibili/ui/pages/video_play/video_play_profile.dart';
import 'package:flutter_bilibili/ui/shared/app_theme.dart';

import '../../widgets/bilibiliFijkPanel.dart';

class HYVideoPlayContent extends StatefulWidget {
  HYVideoModel video;

  HYVideoPlayContent(this.video);

  @override
  State<HYVideoPlayContent> createState() => _HYVideoPlayContentState();
}

class _HYVideoPlayContentState extends State<HYVideoPlayContent> {
  var tabTitle = ['简介', '评论'];
  final FijkPlayer player = FijkPlayer();

  @override
  void initState() {
    super.initState();
    player.setDataSource(
        "https://static.ybhospital.net/" + widget.video.videoData.videoURL,
        // autoPlay: true,
        showCover: true);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabTitle.length,
      child: NestedScrollView(
        headerSliverBuilder: (ctx, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: Color.fromRGBO(253, 105, 155, 1),
              pinned: true,
              toolbarHeight: 70.px,
              expandedHeight:
                  widget.video.videoData.videoHeightType == 0 ? 280.px : 600.px,
              //长视频和短视频采用不同的高度
              collapsedHeight: 100.px,
              //收缩后的高度
              leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Image.asset(
                    "assets/image/icon/back_custom.png",
                    width: iconSize,
                    height: iconSize,
                  )),
              actions: buildVideoPlayActions(),
              flexibleSpace: buildVideoPlayVideoPlayer(),
              bottom: buildVideoPlayTabBar(context),
            ),
          ];
        },
        body: buildVideoPlayTabBarView(),
      ),
      initialIndex: 0,
    );
  }

  @override
  void dispose() {
    super.dispose();
    player.release();
  }

  //home中主要显示的内容，与tabBar对应
  Widget buildVideoPlayTabBarView() {
    return TabBarView(
      children: tabTitle.map((e) {
        if (e == "简介") {
          return HYVideoPlayProfile();
        } else {
          return HYVideoPlayComments();
        }
      }).toList(),
    );
  }

  PreferredSizeWidget buildVideoPlayTabBar(BuildContext context) {
    return PreferredSize(
        //tab设置底色
        preferredSize: Size.fromHeight(20),
        child: Material(
          color: Colors.white,
          child: TabBar(
            tabs: tabTitle.map((e) => Tab(text: e)).toList(),
            indicatorColor: Color.fromRGBO(253, 105, 155, 1),
            unselectedLabelColor: Color.fromRGBO(95, 95, 95, 1),
            labelColor: Color.fromRGBO(253, 105, 155, 1),
            indicatorSize: TabBarIndicatorSize.label,
            labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: HYAppTheme.xxSmallFontSize),
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: HYAppTheme.xxSmallFontSize),
            indicatorWeight: 4.px,
            labelPadding: EdgeInsets.zero,
            indicatorPadding: EdgeInsets.only(bottom: 10.px),
          ),
        ));
  }

  List<Widget> buildVideoPlayActions() {
    return [
      IconButton(
          onPressed: () => print("mini_window_custom"),
          icon: Image.asset(
            "assets/image/icon/mini_window_custom.png",
            width: iconSize,
            height: iconSize,
          )),
      IconButton(
          onPressed: () => print("tv_play_custom"),
          icon: Image.asset(
            "assets/image/icon/tv_play_custom.png",
            width: iconSize,
            height: iconSize,
          )),
      IconButton(
          onPressed: () => print("video_player_more_custom"),
          icon: Image.asset(
            "assets/image/icon/video_player_more_custom.png",
            width: iconSize,
            height: iconSize,
          )),
    ];
  }

  Widget buildVideoPlayVideoPlayer() {
    return FlexibleSpaceBar(
      background: Padding(
        padding: EdgeInsets.only(bottom: 48.px),
        child: FijkView(
          color: Colors.black,
          player: player,
          fit: widget.video.videoData.videoHeightType == 0 ? FijkFit.fill : FijkFit.contain,
          panelBuilder: (player, data, ctx, viewSize, texturePos) {
            return BilibiliFijkPanel(
                player: player,
                buildContext: ctx,
                viewSize: viewSize,
                texturePos: texturePos);
          },
        ),
      ),
    );
  }
}
