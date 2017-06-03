import 'package:meta/meta.dart';
import 'package:twitch/src/models/game.dart';

/// Holds information about a popular [Game].
///
/// * [API Reference](https://dev.twitch.tv/docs/v5/reference/games/).
@immutable
class TopGame {
  final int channels;
  final int viewers;
  final Game game;

  TopGame(
      {@required this.channels, @required this.viewers, @required this.game});

  static TopGame fromJson(Map<String, Object> json) {
    return new TopGame(
      channels: json['channels'] as int,
      viewers: json['viewers'] as int,
      game: Game.fromJson(json['game'] as Map<String, Object>),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TopGame &&
          runtimeType == other.runtimeType &&
          channels == other.channels &&
          viewers == other.viewers &&
          game == other.game;

  @override
  int get hashCode => channels.hashCode ^ viewers.hashCode ^ game.hashCode;

  @override
  String toString() {
    return 'TopGame{channels: $channels, viewers: $viewers, game: $game}';
  }
}
