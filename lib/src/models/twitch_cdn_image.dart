import 'package:meta/meta.dart';

/// Represents an image stored on Twitch's CDN.
@immutable
class TwitchCdnImage {
  /// Returns a [TwitchCdnImage] decoded from a [json] map.
  static TwitchCdnImage fromJson(Map<String, Object> json) {
    if (json == null) {
      throw new ArgumentError.notNull('json');
    }
    return new TwitchCdnImage(
      large: json['large'] as String,
      medium: json['medium'] as String,
      small: json['small'] as String,
      template: json['template'] as String,
    );
  }

  /// A "large" format image.
  final String large;

  /// A "medium" format image.
  final String medium;

  /// A "small" format image.
  final String small;

  /// A template URL for custom dimensions.
  ///
  /// See the [custom] function for a helper.
  final String template;

  const TwitchCdnImage({
    this.large,
    this.medium,
    this.small,
    this.template,
  });

  @override
  bool operator ==(Object o) {
    if (o is TwitchCdnImage) {
      return o.template == template;
    }
    return false;
  }

  @override
  int get hashCode => template.hashCode;

  /// Returns a custom image URL based on [width] and [height].
  String custom({
    @required int width,
    @required int height,
  }) =>
      template
          .replaceAll('{width}', '$width')
          .replaceAll('{height}', '$height');
}
