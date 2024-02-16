//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class LogoutCommand {
  /// Returns a new [LogoutCommand] instance.
  LogoutCommand({
    required this.refreshToken,
  });

  /// Refresh token
  String refreshToken;

  @override
  bool operator ==(Object other) => identical(this, other) || other is LogoutCommand &&
    other.refreshToken == refreshToken;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (refreshToken.hashCode);

  @override
  String toString() => 'LogoutCommand[refreshToken=$refreshToken]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'refreshToken'] = this.refreshToken;
    return json;
  }

  /// Returns a new [LogoutCommand] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static LogoutCommand? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "LogoutCommand[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "LogoutCommand[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return LogoutCommand(
        refreshToken: mapValueOfType<String>(json, r'refreshToken')!,
      );
    }
    return null;
  }

  static List<LogoutCommand> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <LogoutCommand>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = LogoutCommand.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, LogoutCommand> mapFromJson(dynamic json) {
    final map = <String, LogoutCommand>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = LogoutCommand.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of LogoutCommand-objects as value to a dart map
  static Map<String, List<LogoutCommand>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<LogoutCommand>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = LogoutCommand.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'refreshToken',
  };
}

