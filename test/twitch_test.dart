// Copyright 2017, Google Inc.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@TestOn('vm')
import 'package:test/test.dart';
import 'package:twitch/src/models/video.dart';
import 'package:twitch/twitch.dart';

import 'common.dart';

void main() {
  final http = new FakeTwitchHttp({
    'https://fake.api.twitch.tv/games/top?': jsonFile('games_top'),
    'https://fake.api.twitch.tv/videos/top?': jsonFile('videos_top'),
  });

  final twitch = new Twitch(http);

  test('should fetch the top games', () async {
    final topGames = await twitch.getTopGames();
    expect(topGames, const isInstanceOf<Response<Game>>());
    expect(topGames, hasLength(1));

    final counterStrike = topGames.first;
    expect(counterStrike.channels, 953);
    expect(counterStrike.viewers, 171708);

    final game = counterStrike.game;
    expect(game.name, 'Counter-Strike: Global Offensive');
    expect(game.popularity, 170487);
    expect(game.id, 32399);

    final logo = game.logo;
    expect(logo.large, endsWith('240x144.jpg'));
    expect(logo.medium, endsWith('120x72.jpg'));
    expect(logo.small, endsWith('60x36.jpg'));
    expect(logo.custom(width: 100, height: 100), endsWith('100x100.jpg'));
  });

  test('should fetch the top videos', () async {
    final topVideos = await twitch.getTopVideos();
    expect(topVideos, const isInstanceOf<Response<Video>>());
    expect(topVideos, hasLength(10));

    final Video topVideo = topVideos.first;
    expect(topVideo.id, "v140675974");
    expect(topVideo.description, "www.bayriffer.net");
    expect(topVideo.game, "Resident Evil 6");
    expect(topVideo.title, "Resident Evil 6 : Leon Chapter 1");
    expect(topVideo.url, "https://www.twitch.tv/videos/140675974");

    final channel = topVideo.channel;
    expect(channel.name, "bayriffer");
    expect(channel.displayName, "bayriffer");

    final preview = topVideo.preview;
    expect(preview.large, endsWith('640x360.png'));
    expect(preview.medium, endsWith('320x180.png'));
    expect(preview.small, endsWith('80x45.png'));
    expect(preview.custom(width: 100, height: 100), endsWith('100x100.png'));
  });
}
