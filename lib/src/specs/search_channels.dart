import 'package:twitch/src/models/channel.dart';
import 'package:twitch/src/spec.dart';

class SearchChannelsSpec extends JsonResultsSpec<Channel> {
  const SearchChannelsSpec();

  @override
  Channel decode(Map<String, Object> json) => Channel.fromJson(json);

  @override
  List<Map<String, Object>> items(Map<String, Object> json) {
    return json['channels'] as List<Map<String, Object>>;
  }
}
