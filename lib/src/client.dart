// Copyright 2017, Google Inc.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'http.dart';
import 'package:twitch/src/models/top_game.dart';
import 'package:twitch/src/models/video.dart';
import 'package:twitch/src/specs/top_games.dart';
import 'package:twitch/src/specs/top_videos.dart';
import 'spec.dart';

/// An client for [Twitch's API v5](https://dev.twitch.tv/docs).
class Twitch {
  final TwitchHttp _http;

  const Twitch(this._http);

  /// Returns games sorted by current viewers on Twitch, most popular first.
  ///
  /// * [API Reference](https://dev.twitch.tv/docs/v5/reference/games/).
  ///
  /// _Authentication is not required._
  Future<Response<TopGame>> getTopGames() => _http(const ['games', 'top'])
      .then((response) => new Response(const TopGamesSpec(), response));

  /// Returns videos sorted by current viewers on Twitch, most popular first.
  ///
  /// * [API Reference](https://dev.twitch.tv/docs/v5/reference/videos/).
  ///
  /// _Authentication is not required._
  Future<Response<Video>> getTopVideos() => _http(const ['videos', 'top'])
      .then((response) => new Response(const TopVideosSpec(), response));
}
