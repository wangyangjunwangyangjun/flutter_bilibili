import '../../model/video_model.dart';
import '../utils/http_request.dart';

class HYHomeRequest {
  static Future<List<HYVideoModel>> getVideoData(int rid, int pn, int ps) async {
    /**
     * rid为分区编号，必填
     * pn为页数
     * ps为一页几项video数据
     */
    final url = "?rid=$rid&pn=$pn&ps=$ps";
    print(url);
    final result = await HttpRequest.request(url);
    final videoArray = result["data"]["archives"];
    List<HYVideoModel> videos = [];
    for (var json in videoArray) {
      videos.add(HYVideoModel.fromJson(json));
    }
    return videos;
  }
}
