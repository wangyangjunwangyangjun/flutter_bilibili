import 'package:flutter/material.dart';
import 'package:flutter_bilibili/core/model/video_model.dart';
import 'package:flutter_bilibili/ui/pages/video_play/video_play_content.dart';

class HYVideoPlayScreen extends StatelessWidget {
  static const String routeName = "/video_play";

  @override
  Widget build(BuildContext context) {
    HYVideoModel video =
        ModalRoute.of(context)?.settings.arguments as HYVideoModel;
    return SafeArea(
      child: Scaffold(
        body: HYVideoPlayContent(video),
      ),
    );
  }
}
