import 'package:meta/meta.dart';
import 'package:twitch/src/models/channel.dart';
import 'package:twitch/src/models/twitch_cdn_image.dart';

/// A basic Twitch Video model.
///
/// * [API Reference](https://dev.twitch.tv/docs/v5/reference/videos/).
@immutable
class Video {
  final String id;
  final String description;
  final Channel channel;
  final String game;
  final String title;
  final String url;
  final TwitchCdnImage preview;

  Video(
      {@required this.id,
      @required this.description,
      @required this.channel,
      @required this.game,
      @required this.title,
      @required this.url,
      @required this.preview});

  static Video fromJson(Map<String, Object> json) {
    return new Video(
        id: json['_id'] as String,
        description: json['description'] as String,
        channel: Channel.fromJson(json['channel'] as Map<String, Object>),
        game: json['game'] as String,
        title: json['title'] as String,
        url: json['url'] as String,
        preview:
            TwitchCdnImage.fromJson(json['preview'] as Map<String, Object>));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Video &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          description == other.description &&
          channel == other.channel &&
          game == other.game &&
          title == other.title &&
          url == other.url &&
          preview == other.preview;

  @override
  int get hashCode =>
      id.hashCode ^
      description.hashCode ^
      channel.hashCode ^
      game.hashCode ^
      title.hashCode ^
      url.hashCode ^
      preview.hashCode;

  @override
  String toString() {
    return 'Video{id: $id, description: $description, channel: $channel, game: $game, title: $title, url: $url, preview: $preview}';
  }
}
