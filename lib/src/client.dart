// Copyright 2017, Google Inc.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:twitch/src/models/channel.dart';
import 'package:twitch/src/models/game.dart';
import 'package:twitch/src/models/top_game.dart';
import 'package:twitch/src/models/video.dart';
import 'package:twitch/src/specs/search_channels.dart';
import 'package:twitch/src/specs/search_games.dart';
import 'package:twitch/src/specs/top_games.dart';
import 'package:twitch/src/specs/top_videos.dart';
import 'package:twitch/src/specs/videos.dart';
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
      .then((response) => new Response(const TopGamesSpec(), response));

  /// Returns videos sorted by current viewers on Twitch, most popular first.
  ///
  /// * [API Reference](https://dev.twitch.tv/docs/v5/reference/videos/).
  ///
  /// _Authentication is not required._
  Future<Response<Video>> getTopVideos() => _http(const ['videos', 'top'])
      .then((response) => new Response(const TopVideosSpec(), response));

  /// Returns a list of channels sorted by relevancy
  ///
  /// * [API Reference](https://dev.twitch.tv/docs/v5/reference/search/#search-channels).
  ///
  /// _Authentication is not required._
  Future<Response<Channel>> searchChannels(String query) async {
    final response = await _http(const ['search', 'channels'],
        queryParameters: {'query': query});

    return new Response(const SearchChannelsSpec(), response);
  }

  /// Returns a list of games sorted by relevancy
  ///
  /// * [API Reference](https://dev.twitch.tv/docs/v5/reference/search/#search-games).
  ///
  /// _Authentication is not required._
  Future<Response<Game>> searchGames(String query) async {
    final response = await _http(const ['search', 'games'],
        queryParameters: {'query': query});

    return new Response(const SearchGamesSpec(), response);
  }

  /// Returns a list of videos from a Channel
  ///
  /// * [API Reference](https://dev.twitch.tv/docs/v5/reference/channels/#get-channel-videos).
  ///
  /// _Authentication is not required._
  Future<Response<Video>> getChannelVideos(int id) async {
    final response = await _http(['channels', id.toString(), 'videos']);

    return new Response(const VideosSpec(), response);
  }
}
