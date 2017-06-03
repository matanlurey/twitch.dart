import 'package:meta/meta.dart';

/// A basic Channel model
///
/// [API Reference](https://dev.twitch.tv/docs/v5/reference/channels/).
@immutable
class Channel {
  final int id;
  final String displayName;
  final String name;

  Channel({@required this.id, @required this.displayName, @required this.name});

  static Channel fromJson(Map<String, Object> json) {
    return new Channel(
        id: json['_id'] as int,
        displayName: json['display_name'] as String,
        name: json['name'] as String);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Channel &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              displayName == other.displayName &&
              name == other.name;

  @override
  int get hashCode =>
      id.hashCode ^
      displayName.hashCode ^
      name.hashCode;

  @override
  String toString() {
    return 'Channel{id: $id, displayName: $displayName, name: $name}';
  }
}
