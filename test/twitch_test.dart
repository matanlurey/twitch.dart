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
    'https://fake.api.twitch.tv/search/channels?query=hi':
        jsonFile('search_channels'),
    'https://fake.api.twitch.tv/search/games?query=hi':
        jsonFile('search_games'),
    'https://fake.api.twitch.tv/channels/26991127/videos?':
        jsonFile('channels_26991127_videos'),
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
    expect(topVideos, hasLength(1));

    final Video topVideo = topVideos.first;
    expect(topVideo.id, "v140675974");
    expect(topVideo.description, "www.bayriffer.net");
    expect(topVideo.game, "Resident Evil 6");
    expect(topVideo.title, "Resident Evil 6 : Leon Chapter 1");
    expect(topVideo.url, "https://www.twitch.tv/videos/140675974");

    final preview = topVideo.preview;
    expect(preview.large, endsWith('640x360.png'));
    expect(preview.medium, endsWith('320x180.png'));
    expect(preview.small, endsWith('80x45.png'));
    expect(preview.custom(width: 100, height: 100), endsWith('100x100.png'));

    final channel = topVideo.channel;
    expect(channel.id, 110928620);
    expect(channel.name, "bayriffer");
  });

  test('should search for channels', () async {
    final channels = await twitch.searchChannels("hi");
    expect(channels, const isInstanceOf<Response<Channel>>());
    expect(channels, hasLength(1));
    expect(channels.total, 388015);

    final Channel channel = channels.first;
    expect(channel.mature, false);
    expect(channel.status,
        "hi!  |  http://www.designbyhumans.com/shop/hiko Follow @Hiko");
    expect(channel.broadcasterLanguage, "en");
    expect(channel.displayName, "Hiko");
    expect(channel.game, "Counter-Strike: Global Offensive");
    expect(channel.language, "en");
    expect(channel.id, 26991127);
    expect(channel.name, "hiko");
    expect(channel.createdAt, DateTime.parse("2011-12-23T17:36:09.142428Z"));
    expect(channel.updatedAt, DateTime.parse("2017-06-04T10:00:39.496137Z"));
    expect(channel.partner, false);
    expect(channel.logo,
        "https://static-cdn.jtvnw.net/jtv_user_pictures/hiko-profile_image-fa9474314cb6cafa-300x300.png");
    expect(channel.videoBanner,
        "https://static-cdn.jtvnw.net/jtv_user_pictures/hiko-channel_offline_image-269c30cc6d860b5c-1920x1080.png");
    expect(channel.profileBanner,
        "https://static-cdn.jtvnw.net/jtv_user_pictures/hiko-profile_banner-5deef30f2102cc79-480.png");
    expect(channel.profileBannerBackgroundColor, "");
    expect(channel.url, "https://www.twitch.tv/hiko");
    expect(channel.views, 15651912);
    expect(channel.followers, 484139);
    expect(channel.broadcasterType, "");
    expect(channel.description,
        "Average Gamer. CSGO Partnerships @ Twitch . Twitter @Hiko");
  });

  test('should search for games', () async {
    final games = await twitch.searchGames("hi");
    expect(games, const isInstanceOf<Response<Game>>());
    expect(games, hasLength(1));

    final Game game = games.first;
    expect(game.name, "HITMAN");
    expect(game.popularity, 18);
    expect(game.id, 491471);

    final box = game.box;
    expect(box.large, endsWith('272x380.jpg'));
    expect(box.medium, endsWith('136x190.jpg'));
    expect(box.small, endsWith('52x72.jpg'));
    expect(box.custom(width: 100, height: 100), endsWith('100x100.jpg'));

    final logo = game.logo;
    expect(logo.large, endsWith('240x144.jpg'));
    expect(logo.medium, endsWith('120x72.jpg'));
    expect(logo.small, endsWith('60x36.jpg'));
    expect(logo.custom(width: 100, height: 100), endsWith('100x100.jpg'));
  });

  test('should fetch videos for a given channel', () async {
    final videos = await twitch.getChannelVideos(26991127);
    expect(videos, const isInstanceOf<Response<Video>>());
    expect(videos, hasLength(1));

    expect(videos.first.id, "v147067595");
  });
}
