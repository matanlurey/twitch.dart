// Copyright 2017, Google Inc.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:stack_trace/stack_trace.dart';
import 'package:twitch/twitch.dart';

/// With a pre-authorized client ID, prints the top games on Twitch.
///
/// Assumes the environment variable `TWITCH_CLIENT_ID` to be set.
///
/// Otherwise fails with an [exitCode] of `1`. This is used as a (very) simple
/// test to ensure that nothing horrible broke with our code that connects to
/// the Twitch API server.
Future<Null> main() async {
  TwitchHttp http;
  try {
    http = new TwitchHttp.fromEnv();
    final twitch = new Twitch(http);
    final result = await twitch.getTopGames();
    print(result);
    http.close();
  } catch (e, s) {
    print('Error: $e');
    print('Stack: ${new Trace.from(s).terse}');
    exitCode = 1;
  } finally {
    http?.close();
  }
}
