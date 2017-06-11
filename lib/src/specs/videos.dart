import 'package:twitch/src/models/video.dart';
import 'package:twitch/src/spec.dart';

class VideosSpec extends JsonResultsSpec<Video> {
  const VideosSpec();

  @override
  Video decode(Map<String, Object> json) => Video.fromJson(json);

  @override
  List<Map<String, Object>> items(Map<String, Object> json) {
    return json['videos'] as List<Map<String, Object>>;
  }
}
