import 'package:twitch/src/models/game.dart';
import 'package:twitch/src/spec.dart';

class SearchGamesSpec extends JsonResultsSpec<Game> {
  const SearchGamesSpec();

  @override
  Game decode(Map<String, Object> json) => Game.fromJson(json);

  @override
  List<Map<String, Object>> items(Map<String, Object> json) {
    return List<Map<String, Object>>.from(json['games'] as List<dynamic>);
  }
}
