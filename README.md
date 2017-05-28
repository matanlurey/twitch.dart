# twitch

Unofficial Twitch client for Dart and [Flutter].


[![pub package](https://img.shields.io/pub/v/twitch.svg)](https://pub.dartlang.org/packages/twitch)
[![Build Status](https://travis-ci.org/matanlurey/twitch.dart.svg)](https://travis-ci.org/matanlurey/twitch.dart)
[![Coverage Status](https://coveralls.io/repos/github/matanlurey/twitch.dart/badge.svg?branch=master)](https://coveralls.io/github/matanlurey/twitch.dart?branch=master)

[Flutter]: https://flutter.io

**Warning**: This is not an official Google or Dart project.

## Installation

```yaml
dependencies:
  twitch: ^0.1.0
```

## Usage

This API is incomplete, and currently only supports raw HTTP requests.

For example, how to get the top played games on Twitch:

```dart
import 'dart:async';
import 'dart:io';

import 'package:twitch/twitch.dart';

/// With a pre-authorized client ID, prints the top games on Twitch.
/// 
/// Assumes the environment variable `TWITCH_CLIENT_ID` to be set.
Future<Null> main() async {
  TwitchHttp http;
  try {
    http = new TwitchHttp.fromEnv();
    // GET https://api.twitch.tv/kraken/games/top
    final result = await http([
      'games',
      'top',
    ]);
    // Result is a JSON-decoded Dart Map. This will be strongly typed later.
    print(result);
    http.close();
  } catch (e, s) {
    print('Error: $e');
    print('Stack: $s');
    exitCode = 1;
  } finally {
    http?.close();
  }
}
```

See the [official API Overview](https://dev.twitch.tv/docs) for a full list of
supported API calls and documentation.
