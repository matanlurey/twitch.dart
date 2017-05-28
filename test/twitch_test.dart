// Copyright 2017, Google Inc.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@TestOn('vm')
import 'package:test/test.dart';
import 'package:twitch/twitch.dart';

import 'common.dart';

void main() {
  final http = new FakeTwitchHttp({
    'https://fake.api.twitch.tv/games/top?': jsonFile('games_top'),
  });

  final twitch = new Twitch(http);

  test('should fetch the top games', () async {
    final topGames = await twitch.getTopGames();
    expect(topGames, const isInstanceOf<Response<TopGame>>());
    expect(topGames, hasLength(1));

    final counterStrike = topGames.first;
    expect(counterStrike.channels, 953);
    expect(counterStrike.viewers, 171708);
    expect(counterStrike.name, 'Counter-Strike: Global Offensive');
    expect(counterStrike.popularity, 170487);
    expect(counterStrike.id, 32399);

    final logo = counterStrike.logo;
    expect(logo.large, endsWith('240x144.jpg'));
    expect(logo.medium, endsWith('120x72.jpg'));
    expect(logo.small, endsWith('60x36.jpg'));
    expect(logo.custom(width: 100, height: 100), endsWith('100x100.jpg'));
  });
}
