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