import 'package:flutter_bilibili/core/model/relation_stat_model_model.dart';
import 'package:flutter_bilibili/core/model/space_nav_num_model.dart';
import 'package:flutter_bilibili/core/model/tag_archive_tags_model.dart';
import 'package:flutter_bilibili/core/model/video_model.dart';

import '../../model/archive_related_model.dart';
import '../utils/http_request.dart';

class HYVideoRequestRequest {
  static Future<HYRelationStatModel> getRelationStatData(int mid) async {
    final url = "/relation/stat?vmid=$mid&jsonp=jsonp";
    final result = await HttpRequest.request(url);
    return HYRelationStatModel.fromJson(result);
  }
  static Future<HYSpaceNavNumModel> getSpaceNavNumData(int mid) async {
    final url = "/space/navnum?mid=$mid";
    final result = await HttpRequest.request(url);
    return HYSpaceNavNumModel.fromJson(result);
  }
  static Future<List<HYTagArchiveTagsModel>> getTagArchiveTagsData(int aid) async {
    final url = "/tag/archive/tags?aid=$aid";
    final result = await HttpRequest.request(url);
    final tagArray = result["data"];
    final List<HYTagArchiveTagsModel> tags = [];
    for(var json in tagArray) {
      tags.add(HYTagArchiveTagsModel.fromJson(json));
    }
    return tags;
  }
  static Future<List<HYVideoModel>> getArchiveRelatedData(int aid) async {
    final url = "/web-interface/archive/related?aid=$aid";
    final result = await HttpRequest.request(url);
    final relatedVideoArray = result["data"];
    final List<HYVideoModel> relatedVideos = [];
    for(var json in relatedVideoArray) {
      relatedVideos.add(HYVideoModel.fromJson(json));
    }
    return relatedVideos;
  }
}
