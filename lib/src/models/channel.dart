import 'package:meta/meta.dart';

/// A basic Channel model
///
/// [API Reference](https://dev.twitch.tv/docs/v5/reference/channels/).
@immutable
class Channel {
  final int id;
  final bool mature;
  final String status;
  final String broadcasterLanguage;
  final String displayName;
  final String game;
  final String language;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool partner;
  final String logo;
  final String videoBanner;
  final String profileBanner;
  final String profileBannerBackgroundColor;
  final String url;
  final int views;
  final int followers;
  final String broadcasterType;
  final String description;

  Channel(
      {@required this.id,
      @required this.mature,
      @required this.status,
      @required this.broadcasterLanguage,
      @required this.displayName,
      @required this.game,
      @required this.language,
      @required this.name,
      @required this.createdAt,
      @required this.updatedAt,
      @required this.partner,
      @required this.logo,
      @required this.videoBanner,
      @required this.profileBanner,
      @required this.profileBannerBackgroundColor,
      @required this.url,
      @required this.views,
      @required this.followers,
      @required this.broadcasterType,
      @required this.description});

  static Channel fromJson(Map<String, Object> json) {
    return new Channel(
        id: json['_id'] as int,
        mature: json['mature'] as bool,
        status: json['status'] as String,
        broadcasterLanguage: json['broadcaster_language'] as String,
        displayName: json['display_name'] as String,
        game: json['game'] as String,
        language: json['language'] as String,
        name: json['name'] as String,
        createdAt: DateTime.parse(json['created_at'] as String),
        updatedAt: DateTime.parse(json['updated_at'] as String),
        partner: json['partner'] as bool,
        logo: json['logo'] as String,
        videoBanner: json['video_banner'] as String,
        profileBanner: json['profile_banner'] as String,
        profileBannerBackgroundColor:
            json['profile_banner_background_color'] as String,
        url: json['url'] as String,
        views: json['views'] as int,
        followers: json['followers'] as int,
        broadcasterType: json['broadcaster_type'] as String,
        description: json['description'] as String);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Channel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          mature == other.mature &&
          status == other.status &&
          broadcasterLanguage == other.broadcasterLanguage &&
          displayName == other.displayName &&
          game == other.game &&
          language == other.language &&
          name == other.name &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt &&
          partner == other.partner &&
          logo == other.logo &&
          videoBanner == other.videoBanner &&
          profileBanner == other.profileBanner &&
          profileBannerBackgroundColor == other.profileBannerBackgroundColor &&
          url == other.url &&
          views == other.views &&
          followers == other.followers &&
          broadcasterType == other.broadcasterType &&
          description == other.description;

  @override
  int get hashCode =>
      id.hashCode ^
      mature.hashCode ^
      status.hashCode ^
      broadcasterLanguage.hashCode ^
      displayName.hashCode ^
      game.hashCode ^
      language.hashCode ^
      name.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      partner.hashCode ^
      logo.hashCode ^
      videoBanner.hashCode ^
      profileBanner.hashCode ^
      profileBannerBackgroundColor.hashCode ^
      url.hashCode ^
      views.hashCode ^
      followers.hashCode ^
      broadcasterType.hashCode ^
      description.hashCode;

  @override
  String toString() {
    return 'Channel{id: $id, mature: $mature, status: $status, broadcasterLanguage: $broadcasterLanguage, displayName: $displayName, game: $game, language: $language, name: $name, createdAt: $createdAt, updatedAt: $updatedAt, partner: $partner, logo: $logo, videoBanner: $videoBanner, profileBanner: $profileBanner, profileBannerBackgroundColor: $profileBannerBackgroundColor, url: $url, views: $views, followers: $followers, broadcasterType: $broadcasterType, description: $description}';
  }
}
