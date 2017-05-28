# twitch

Unofficial Twitch API for Dart and [Flutter].

[![pub package](https://img.shields.io/pub/v/twitch.svg)](https://pub.dartlang.org/packages/twitch)
[![Build Status](https://travis-ci.org/matanlurey/twitch.dart.svg)](https://travis-ci.org/matanlurey/twitch.dart)
[![Coverage Status](https://coveralls.io/repos/github/matanlurey/twitch.dart/badge.svg?branch=master)](https://coveralls.io/github/matanlurey/twitch.dart?branch=master)

[Flutter]: https://flutter.io

**NOTE**: This is not an official Google or Dart project.

## Installation

Simply add `twitch` to your `pubspec.yaml` file:

```yaml
dependencies:
  twitch: ^0.3.0
```

You'll need a Twitch API token (called a "client ID") for this to be useful.
Visit the [twitch developer site](https://dev.twitch.tv) to signup - it just
takes a minute or two.

**WARNING**: The default implementation only works in the command-line VM and
Flutter, and may not be loaded in the browser at all in Dart versions older
than `1.23.0`. Starting at `1.23.0` it's trivial to implement a browser version
of `TwitchHttp`, but this has not been yet. Consider [contributing][]!

## Usage

This API is incomplete, and currently supports a high-level `Twitch` class
(with a strongly-typed idiomatic Dart API) and a lower-level `TwitchHttp` class
that allows making _any_ call to the Twitch API server, provided you know the
URL endpoints ([see the API documentation][twitch_docs]).

For example, how to get the top played games on Twitch:

```dart
import 'dart:async';

import 'package:twitch/twitch.dart';

/// With a pre-authorized client ID, prints the top games on Twitch.
/// 
/// Assumes the environment variable `TWITCH_CLIENT_ID` to be set.
main() async {
  var http = new TwitchHttp.fromEnv();
  var twitch = new Twitch(http); 
  
  // Calls and decodes GET https://api.twitch.tv/kraken/games/top
  final result = await twitch.getTopGames();
   
  print('The top game on Twitch is currently: ${result.first.name}');
  http.close();
}
```

## Contributing

We welcome a diverse set of contributions, including, but not limited to:
* [Filing bugs and feature requests][file_issue]
* [Send a pull request][pull_request]
* Or, create something awesome using this API and share with us and others!

For the stability of the API and existing users, consider opening an issue
first before implementing a large new feature or breaking an API. For smaller
changes (like documentation, bug fixes), just send a pull request.

[contributing]: #contributing
[file_issue]: https://github.com/matanlurey/twitch.dart/issues/new
[pull_request]: https://github.com/matanlurey/twitch.dart/pulls/new
[twitch_docs]: https://dev.twitch.tv/docs