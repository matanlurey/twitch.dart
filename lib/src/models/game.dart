import 'package:meta/meta.dart';
import 'package:twitch/src/models/twitch_cdn_image.dart';

/// A basic Game model
///
/// * [API Reference](https://dev.twitch.tv/docs/v5/reference/games/).
@immutable
class Game {
  final int id;
  final String name;
  final int popularity;
  final TwitchCdnImage box;
  final TwitchCdnImage logo;

  const Game({
    @required this.id,
    @required this.name,
    @required this.popularity,
    @required this.box,
    @required this.logo,
  });

  static Game fromJson(Map<String, Object> json) {
    return new Game(
      popularity: json['popularity'] as int,
      id: json['_id'] as int,
      name: json['name'] as String,
      box: TwitchCdnImage.fromJson(json['box'] as Map<String, Object>),
      logo: TwitchCdnImage.fromJson(json['logo'] as Map<String, Object>),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Game &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          popularity == other.popularity &&
          box == other.box &&
          logo == other.logo;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      popularity.hashCode ^
      box.hashCode ^
      logo.hashCode;

  @override
  String toString() {
    return 'Game{id: $id, name: $name, popularity: $popularity, box: $box, logo: $logo}';
  }
}
