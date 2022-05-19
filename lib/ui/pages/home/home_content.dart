import 'package:flutter/material.dart';
import 'package:flutter_bilibili/core/extension/int_extension.dart';
import 'initialize_item.dart';

class HYHomeContent extends StatefulWidget {
  @override
  State<HYHomeContent> createState() => _HYHomeContentState();
}

class _HYHomeContentState extends State<HYHomeContent> {
  final String userLogo =
      "https://i1.hdslb.com/bfs/face/50ca9a7c8c8f11a007510c0e0a7eaea1c8167c54.jpg@240w_240h_1c_1s.webp";

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        //DefaultTabController用于tabbar和tabbarView
        length: tabTitle.length, //设置几个tabBarItem
        child: NestedScrollView(
            //上划
            headerSliverBuilder: (ctx, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  leading: buildHomeUserIcon(userLogo),
                  title: buildHomeSearch(),
                  actions: buildHomeActions(),
                  pinned: false,
                ),
                SliverAppBar(
                  title: buildHomeTabBar(),
                  pinned: true,
                ),
              ];
            },
            body: buildHomeTabBarView()));
  }
}

//圆形图标
Widget buildHomeUserIcon(String userLogo) {
  return Container(
    alignment: Alignment.centerRight,
    child: CircleAvatar(
      backgroundImage: NetworkImage(userLogo),
    ),
  );
}

//搜索
Widget buildHomeSearch() {
  return Row(
    children: [
      Expanded(
        child: Container(
          alignment: Alignment.centerLeft,
          child: Container(
              padding: EdgeInsets.only(left: 18.px, top: 10.px, bottom: 10.px),
              child: Image.asset("assets/image/icon/search_custom.png")),
          height: 35.px,
          decoration: BoxDecoration(  //圆角
              color: Color.fromRGBO(242, 243, 245, 1),
              borderRadius: BorderRadius.circular(180.px)),
        ),
      ),
    ],
  );
}

List<Widget> buildHomeActions() {
  return [
    IconButton(
        onPressed: () => print("game"),
        icon: Image.asset(
          "assets/image/icon/game_custom.png",
          width: iconSize,
          height: iconSize,
        )),
    IconButton(
        onPressed: () => print("more"),
        icon: Image.asset(
          "assets/image/icon/mail_custom.png",
          width: iconSize,
          height: iconSize,
        )),
  ];
}

//直播、推荐那个几个item的tabbar
TabBar buildHomeTabBar() {
  return TabBar(
    tabs: tabTitle.map((e) => Tab(text: e)).toList(),
    indicatorColor: Color.fromRGBO(253, 105, 155, 1),
    unselectedLabelColor: Color.fromRGBO(95, 95, 95, 1),
    labelColor: Color.fromRGBO(253, 105, 155, 1),
    indicatorSize: TabBarIndicatorSize.label,
    labelStyle: TextStyle(fontWeight: FontWeight.bold),
    unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
    indicatorWeight: 4.px,
    labelPadding: EdgeInsets.zero,
    indicatorPadding: EdgeInsets.only(bottom: 10.px),
  );
}

//home中主要显示的内容，与tabBar对应
Widget buildHomeTabBarView() {
  return TabBarView(
    children: tabTitle.map((e) {
      return ListView.builder(
        itemBuilder: (ctx, index) {
          return Text("123");
        },
        itemCount: 50,
      );
    }).toList(),
  );
}
