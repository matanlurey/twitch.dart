// Copyright 2017, Google Inc.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:meta/meta.dart';

import 'http.dart';

/// An client for [Twitch's API v5](https://dev.twitch.tv/docs).
class Twitch {
  // ignore: unused_field
  final TwitchHttp _http;

  const Twitch(this._http);

  /// Returns games sorted by current viewers on Twitch, most popular first.
  ///
  /// _Authentication is not required._
  ///
  /// **EXPERIMENTAL**: May change without a sem-ver breaking change.
  @experimental
  Future<Map<String, Object>> getTopGames() => _http(const ['games', 'top']);
}
