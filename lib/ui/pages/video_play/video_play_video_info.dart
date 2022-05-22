import 'package:flutter/material.dart';
class buildVideoPlayVideoInfo extends StatelessWidget {
  const buildVideoPlayVideoInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 100,
          itemBuilder: (ctx,index) {
        return ListTile(
          title: Text("data"),
        );
      }),
    );
  }
}
