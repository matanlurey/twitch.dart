import 'package:twitch/src/models/video.dart';
import 'package:twitch/src/spec.dart';

class TopVideosSpec extends JsonResultsSpec<Video> {
  const TopVideosSpec();

  @override
  Video decode(Map<String, Object> json) => Video.fromJson(json);

  @override
  List<Map<String, Object>> items(Map<String, Object> json) {
    return json['vods'] as List<Map<String, Object>>;
  }
}
