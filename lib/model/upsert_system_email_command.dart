//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class UpsertSystemEmailCommand {
  /// Returns a new [UpsertSystemEmailCommand] instance.
  UpsertSystemEmailCommand({
    required this.host,
    required this.port,
    required this.username,
    required this.password,
  });

  /// IMAP host
  String host;

  /// IMAP port
  int port;

  /// IMAP username
  String username;

  /// IMAP password
  String password;

  @override
  bool operator ==(Object other) => identical(this, other) || other is UpsertSystemEmailCommand &&
     other.host == host &&
     other.port == port &&
     other.username == username &&
     other.password == password;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (host.hashCode) +
    (port.hashCode) +
    (username.hashCode) +
    (password.hashCode);

  @override
  String toString() => 'UpsertSystemEmailCommand[host=$host, port=$port, username=$username, password=$password]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'host'] = this.host;
      json[r'port'] = this.port;
      json[r'username'] = this.username;
      json[r'password'] = this.password;
    return json;
  }

  /// Returns a new [UpsertSystemEmailCommand] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UpsertSystemEmailCommand? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "UpsertSystemEmailCommand[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "UpsertSystemEmailCommand[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return UpsertSystemEmailCommand(
        host: mapValueOfType<String>(json, r'host')!,
        port: mapValueOfType<int>(json, r'port')!,
        username: mapValueOfType<String>(json, r'username')!,
        password: mapValueOfType<String>(json, r'password')!,
      );
    }
    return null;
  }

  static List<UpsertSystemEmailCommand>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UpsertSystemEmailCommand>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UpsertSystemEmailCommand.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UpsertSystemEmailCommand> mapFromJson(dynamic json) {
    final map = <String, UpsertSystemEmailCommand>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UpsertSystemEmailCommand.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UpsertSystemEmailCommand-objects as value to a dart map
  static Map<String, List<UpsertSystemEmailCommand>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<UpsertSystemEmailCommand>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UpsertSystemEmailCommand.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'host',
    'port',
    'username',
    'password',
  };
}

