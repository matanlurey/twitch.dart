// Copyright 2017, Google Inc.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:meta/meta.dart';

import 'http.dart';
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
      .then((response) => new Response(const _TopGamesSpec(), response));
}

/// TODO: Document.
///
/// * [API Reference](https://dev.twitch.tv/docs/v5/reference/games/).
class TopGame {
  final int channels;
  final int viewers;
  final int popularity;
  final int id;
  final String name;

  final TwitchCdnImage box;
  final TwitchCdnImage logo;

  const TopGame({
    @required this.channels,
    @required this.viewers,
    @required this.popularity,
    @required this.id,
    @required this.name,
    @required this.box,
    @required this.logo,
  });
}

class _TopGamesSpec extends JsonResultsSpec<TopGame> {
  const _TopGamesSpec();

  @override
  TopGame decode(Map<String, Object> json) {
    final game = json['game'] as Map<String, Object>;
    return new TopGame(
      channels: json['channels'] as int,
      viewers: json['viewers'] as int,
      popularity: game['popularity'] as int,
      id: game['_id'] as int,
      name: game['name'] as String,
      box: TwitchCdnImage.fromJson(game['box'] as Map<String, Object>),
      logo: TwitchCdnImage.fromJson(game['logo'] as Map<String, Object>),
    );
  }

  @override
  List<Map<String, Object>> items(Map<String, Object> json) {
    return json['top'] as List<Map<String, Object>>;
  }
}
