// Copyright 2017, Google Inc.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';
import 'package:twitch/twitch.dart';

import 'common.dart';

void main() {
  final http = const FakeTwitchHttp(const {
    'https://fake.api.twitch.tv/games/top?': r'''
      {
         "_total": 1157,
         "top": [
            {
               "channels": 953,
               "viewers": 171708,
               "game": {
                  "_id": 32399,
                  "box": {
                     "large": "https://static-cdn.jtvnw.net/ttv-boxart/Counter-Strike:%20Global%20Offensive-272x380.jpg",
                     "medium": "https://static-cdn.jtvnw.net/ttv-boxart/Counter-Strike:%20Global%20Offensive-136x190.jpg",
                     "small": "https://static-cdn.jtvnw.net/ttv-boxart/Counter-Strike:%20Global%20Offensive-52x72.jpg",
                     "template": "https://static-cdn.jtvnw.net/ttv-boxart/Counter-Strike:%20Global%20Offensive-{width}x{height}.jpg"
                  },
                  "giantbomb_id": 36113,
                  "logo": {
                     "large": "https://static-cdn.jtvnw.net/ttv-logoart/Counter-Strike:%20Global%20Offensive-240x144.jpg",
                     "medium": "https://static-cdn.jtvnw.net/ttv-logoart/Counter-Strike:%20Global%20Offensive-120x72.jpg",
                     "small": "https://static-cdn.jtvnw.net/ttv-logoart/Counter-Strike:%20Global%20Offensive-60x36.jpg",
                     "template": "https://static-cdn.jtvnw.net/ttv-logoart/Counter-Strike:%20Global%20Offensive-{width}x{height}.jpg"
                  },
                  "name": "Counter-Strike: Global Offensive",
                  "popularity": 170487
               }
            }
         ]
      }
    ''',
  });

  final twitch = new Twitch(http);

  test('should fetch the top games', () async {
    expect(await twitch.getTopGames(), isNotNull);
  });
}
