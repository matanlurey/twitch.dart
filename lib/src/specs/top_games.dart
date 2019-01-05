import 'package:twitch/src/models/top_game.dart';
import 'package:twitch/src/spec.dart';

class TopGamesSpec extends JsonResultsSpec<TopGame> {
  const TopGamesSpec();

  @override
  TopGame decode(Map<String, Object> json) => TopGame.fromJson(json);

  @override
  List<Map<String, Object>> items(Map<String, Object> json) {
    return List<Map<String, Object>>.from(json['top'] as List<dynamic>);
  }
}
