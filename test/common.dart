// Copyright 2017, Google Inc.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:twitch/twitch.dart';

String jsonFile(String nameWithoutExt) {
  return new File('test/_json/$nameWithoutExt.json').readAsStringSync();
}

class FakeTwitchHttp implements TwitchHttp {
  static final Uri _baseUrl = new Uri(
    scheme: 'https',
    host: 'fake.api.twitch.tv',
  );

  final Map<String, String> _responses;

  const FakeTwitchHttp(this._responses);

  @override
  Future<Map<String, Object>> call(
    Iterable<String> pathSegments, {
    Map<String, dynamic> queryParameters: const <String, dynamic>{},
  }) async {
    final uri = _baseUrl
        .replace(
          pathSegments: pathSegments.toList(),
          queryParameters: queryParameters,
        )
        .toString();
    final result = _responses[uri];
    if (result == null) {
      throw new StateError(''
          'No response recorded for: $uri.\n'
          'Recorded responses: ${_responses.keys.toList()}');
    }
    return JSON.decode(_responses[uri]) as Map<String, dynamic>;
  }

  @override
  void close() {}
}
