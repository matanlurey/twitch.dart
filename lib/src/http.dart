// Copyright 2017, Google Inc.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:meta/meta.dart';

/// A lightweight HTTP shim that is simple to implement.
///
/// A goal is to support alternative implementations (like in the browser)
/// without making the rest of the API incur heavy dependencies or abstractions.
///
/// Most users should directly use the high-level `Twitch` class for actual API
/// calls. For example, you might create a [TwitchHttp] at startup based on
/// credentials:
/// ```dart
/// main() {
///   final http = new TwitchHttp.fromEnv();
///   final client = new Twitch(http);
/// }
/// ```
///
/// _This class should only be implemented, not extended or mixed-in._
@Immutable(r'''
  This class is immutable, and a new instance is needed to change state:
    * To use an existing authorization token, use the `authorized` factory.
''')
class TwitchHttp {
  static const String _acceptValue = 'application/vnd.twitchtv.v5+json';
  static const String _basePath = 'kraken';
  static const String _clientId = 'Client-Id';

  static final Uri _baseUrl = new Uri(
    scheme: 'https',
    host: 'api.twitch.tv',
  );

  // TODO: Add methods that use authorization.
  // ignore: unused_field
  final String _accessToken;
  final String _clientIdValue;
  final HttpClient _http;

  /// Create a new [TwitchHttp] client with provided client ID.
  ///
  /// In a typical application flow you'll redirect to a web browser for them to
  /// login, and the web browser will redirect back to your site or application
  /// in order to receive an authorization code.
  ///
  /// Developers may want to use an environment variable instead. See `fromEnv`.
  factory TwitchHttp({
    @required String clientId,
    HttpClient http,
  }) =>
      new TwitchHttp._(clientId, null, http);

  /// Create a new [TwitchHttp] client with provided client ID and access token.
  ///
  /// Developers may want to use an environment variable instead. See `fromEnv`.
  factory TwitchHttp.authorized({
    String clientId,
    String accessToken,
    HttpClient http,
  }) =>
      new TwitchHttp._(clientId, accessToken, http);

  /// Create a new [TwitchHttp] client with a client ID from [clientKey].
  ///
  /// Optionally may also read [accessKey].
  ///
  /// Throws [StateError] if a client ID key is not found.
  factory TwitchHttp.fromEnv({
    String clientKey: 'TWITCH_CLIENT_ID',
    String accessKey: 'TWITCH_ACCESS_TOKEN',
    HttpClient http,
  }) {
    final clientId = Platform.environment[clientKey];
    final accessToken = Platform.environment[accessKey];
    if (clientId == null) {
      throw new StateError('Could not read "$clientKey".');
    }
    return new TwitchHttp._(clientId, accessToken, http);
  }

  // Private.
  TwitchHttp._(this._clientIdValue, this._accessToken, [HttpClient http])
      : _http = http ?? new HttpClient();

  /// Closes the HTTP client, terminating all connections.
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
          .then((string) => JSON.decode(string) as Map<String, Object>);
}
