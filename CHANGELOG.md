## 0.3.2

* Added `Twitch#searchChannels|searchGames|getChannelVideos`.
* Also significant API additions to `Channel`.

Special thanks to [@brianegan](https://github.com/brianegan) for this release!

## 0.3.1

Added `Twitch#getTopVideos`, returning videos sorted by current viewers:

```dart
abstract class Video {
 String get id;
 String get description;
 Channel get channel;
 String get game;
 String get title;
 String get url;
 TwitchCdnImage get preview;
}
```

Special thanks to [@brianegan](https://github.com/brianegan) for this release!

## 0.3.0

This should be the minimum amount of features implemented to easily create some
UI for [AngularDart](https://angulardart.org) or [Flutter](https://flutter.io).
If you like this package and want to see it grow, consider
[filing feature requests][features] or even better,
[contributing][contributing].

[features]: https://github.com/matanlurey/twitch.dart/issues/new
[contributing]: https://github.com/matanlurey/twitch.dart/pulls/new

- Added `TopGame`; see [games](https://dev.twitch.tv/docs/v5/reference/games/).
- Added a `TwitchCdnImage`, wrapper around Twitch's URL locations for an image.
- Added a `Response<T>`, which is an `Iterable<T>` with a `int total` field.
- Experimental `Twitch#getTopGames` stable, returns `Future<Response<TopGame>`:

```dart
abstract class TopGame {
  int get channels;
  int get viewers;
  int get popularity;
  int get id;
  String get name;

  TwitchCdnImage get box;
  TwitchCdnImage get logo;
}
```

## 0.2.0

- Remove the `json` (decoder) property from the `TwitchHttp` client.
- Added an `authorized` factory to `TwitchHttp`:
- Additionally, all of the parameters to `TwitchHttp` are now named parameters:

```dart
new TwitchHttp(
  clientID: '...',
)

new TwitchHttp.authorized(
  accessToken: '...',
  clientID: '...',
)
```

- Added a `Twitch` class for a high-level set of APIs on top of `TwitchHttp`:

```dart
final result = await twitch.getTopGames();
```

## 0.1.0+1

- A few fixes in documentation and the README.

## 0.1.0

- Initial commit.