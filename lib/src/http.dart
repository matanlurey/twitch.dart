// Copyright 2017, Google Inc.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:io';

/// A lightweight HTTP shim that is simple to implement.
///
/// A goal is to support alternative implementations (like in the browser)
/// without making the rest of the API incur heavy dependencies or abstractions.
class TwitchHttp {
  static const String _acceptValue = 'application/vnd.twitchtv.v5+json';
  static const String _basePath = 'kraken';
  static const String _clientId = 'Client-Id';

  static final Uri _baseUrl = new Uri(
    scheme: 'https',
    host: 'api.twitch.tv',
  );

  final String _clientIdValue;
  final HttpClient _http;
  final JsonDecoder _json;

  /// Create a new [TwitchHttp] client with the provided (authorized) client ID.
  ///
  /// In a typical application flow you'll redirect to a web browser for them to
  /// login, and the web browser will redirect back to your site or application
  /// in order to receive a client ID.
  ///
  /// Developers may want to use an environment variable instead. See `fromEnv`.
  TwitchHttp(
    this._clientIdValue, {
    HttpClient http,
    JsonDecoder json: const JsonDecoder(),
  })
      : _http = http ?? new HttpClient(),
        _json = json;

  /// Create a new [TwitchHttp] client with a client ID from [environmentKey].
  ///
  /// Throws [StateError] if the key is not found.
  factory TwitchHttp.fromEnv({
    String environmentKey: 'TWITCH_CLIENT_ID',
    HttpClient http,
    JsonDecoder json: const JsonDecoder(),
  }) {
    final clientId = Platform.environment[environmentKey];
    if (clientId == null) {
      throw new StateError('Could not read "$environmentKey".');
    }
    return new TwitchHttp(clientId, http: http, json: json);
  }

  /// Closes the HTTP client, terminating all clients.
  void close() => _http.close();

  /// Returns a JSON-decoded result from making an API call to [pathSegments].
  ///
  /// Optionally specify [queryParameters] to make as part of the HTTP call.
  Future<Map<String, Object>> call(
    Iterable<String> pathSegments, {
    Map<String, dynamic> queryParameters: const <String, dynamic>{},
  }) =>
      _http
          .getUrl(
            _baseUrl.replace(
              pathSegments: <String>[_basePath]..addAll(pathSegments),
              queryParameters: queryParameters,
            ),
          )
          .then((req) {
            req.headers
              ..add(HttpHeaders.ACCEPT, _acceptValue)
              ..add(_clientId, _clientIdValue);
            return req.close();
          })
          .then(UTF8.decodeStream)
          .then((string) => _json.convert(string) as Map<String, Object>);
}
