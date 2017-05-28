// Copyright 2017, Google Inc.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:meta/meta.dart';

/// **INTERNAL ONLY**: Specification details on going from JSON -> `T`.
///
/// Many methods in the Twitch public API return _results_, or a list of JSON
/// objects, often with common elements like the total number of results on the
/// server, and the ability to page through the results.
///
/// [JsonResultsSpec] defines decoding procedures for a specific response type.
@immutable
@visibleForTesting
abstract class JsonResultsSpec<T> {
  const JsonResultsSpec();

  /// Decodes a [json] result as a strongly typed object `T`.
  T decode(Map<String, Object> json);

  /// Returns the JSON object items in the [json] response.
  List<Map<String, Object>> items(Map<String, Object> json);

  /// Returns the total number of results on the server in the [json] response.
  ///
  /// By default, checks the `_total` field, and falls back to `items.length`.
  int total(Map<String, Object> json) {
    final total = json['_total'];
    return (total ?? items(json).length) as int;
  }
}

/// Represents a response of results from the server.
///
/// Like [Iterable], but includes a [total] (on the server) amount.
@immutable
class Response<T> extends Iterable<T> {
  final JsonResultsSpec<T> _spec;
  final Map<String, Object> _json;

  const Response(this._spec, this._json);

  @override
  Iterator<T> get iterator => _spec.items(_json).map(_spec.decode).iterator;

  /// Total results, which may differ from [length] for paginated results.
  int get total => _spec.total(_json);
}

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
