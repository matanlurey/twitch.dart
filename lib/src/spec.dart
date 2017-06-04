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
