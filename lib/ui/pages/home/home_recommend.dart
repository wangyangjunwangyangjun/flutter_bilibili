import 'package:flutter/material.dart';
import 'package:flutter_bilibili/core/extension/int_extension.dart';
import 'package:flutter_bilibili/core/model/video_model.dart';
import 'package:flutter_bilibili/core/viewmodel/video_view_model.dart';
import 'package:flutter_bilibili/ui/pages/home/home_video_item.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:provider/provider.dart';

import 'home_refresh_item.dart';
import 'load_more_videos_data.dart';

class HYHomeRecommendScreen extends StatefulWidget {
  @override
  State<HYHomeRecommendScreen> createState() => _HYHomeRecommendScreenState();
}

class _HYHomeRecommendScreenState extends State<HYHomeRecommendScreen> {
  List<Widget> widgets = [];
  @override
  Widget build(BuildContext context) {
    return Consumer<HYVideoViewModel>(
      builder: (ctx, videoVM, child) {
        if (videoVM.videos.isEmpty) {
          return Center(
            child: Text("网络故障"),
          );
        }
        if(widgets.isEmpty){
          widgets.addAll([
            buildHomeRecommendCarousel(videoVM.videos.sublist(0, 3)),
            buildHomeRecommendVideoCards(videoVM.videos.sublist(3)),
          ]);
        }
        return EasyRefresh(
          onRefresh: () async {
            refreshVideosData(videoVM); //耗时操作放前面,3秒内加载数据
            await Future.delayed(Duration(seconds: 3)).then((value) {
              setState(() {
                videoVM.baseDataVM.pn++; //页码加一，获取下一页的数据
                widgets.insert(0, HYHomeRefreshItem(0, videoVM.videos)); //需等待数据再执行
              });
            });
          },
          onLoad: () async {
            loadMoreVideosData(videoVM);
            await Future.delayed(Duration(seconds: 3)).then((value) {
              setState(() {
                videoVM.baseDataVM.pn++; //页码加一，获取下一页的数据
                widgets.add(HYHomeRefreshItem(1, videoVM.videos));
              });
            });
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  left: 8.px, right: 8.px, top: 4.px, bottom: 0),
              child: Column(
                children: widgets,
              ),
            ),
          ),
        );
      },
    );
  }

  //轮播图
  Widget buildHomeRecommendCarousel(List<HYVideoModel> data) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4.px),
      child: Container(
        margin: EdgeInsets.only(bottom: 8.px),
        height: 190.px, //这里的轮播图组件必须包裹在有高度的控件或者设置比例
        child: Swiper(
          itemBuilder: (ctx, index) {
            return Image.network(
              data[index].pic,
              fit: BoxFit.fill,
            );
          },
          itemCount: data.length,
          indicatorLayout: PageIndicatorLayout.SCALE,
          autoplayDelay: 3000,
          pagination: SwiperPagination(
              alignment: Alignment.bottomRight,
              margin:
                  EdgeInsets.only(left: 0, right: 8.px, bottom: 8.px, top: 0)),
          fade: 1.0,
          autoplay: true,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }

  Widget buildHomeRecommendVideoCards(List<HYVideoModel> data) {
    return GridView.builder(
      /**
       * 这里的shrinkWrap和physics必须设置，
       * 搭配SingleChildScrollView和column一起使用
       */
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: data.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 0.9 //这里的比例设置了，子widget高度属性就无效果了
          ),
      itemBuilder: (ctx, index) {
        return HYHomeVideoItem(data[index]);
      },
    );
  }

  Widget buildHomeRecommendOneVideo() {
    return Center(
      child: Text("data"),
    );
  }
}
