//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class CheckEmailConnectivityCommand {
  /// Returns a new [CheckEmailConnectivityCommand] instance.
  CheckEmailConnectivityCommand({
    this.id,
    this.host,
    this.port,
    this.username,
    this.password,
  });

  /// System email id
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? id;

  /// IMAP host
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? host;

  /// IMAP port
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? port;

  /// IMAP username
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? username;

  /// IMAP password
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? password;

  @override
  bool operator ==(Object other) => identical(this, other) || other is CheckEmailConnectivityCommand &&
     other.id == id &&
     other.host == host &&
     other.port == port &&
     other.username == username &&
     other.password == password;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id == null ? 0 : id!.hashCode) +
    (host == null ? 0 : host!.hashCode) +
    (port == null ? 0 : port!.hashCode) +
    (username == null ? 0 : username!.hashCode) +
    (password == null ? 0 : password!.hashCode);

  @override
  String toString() => 'CheckEmailConnectivityCommand[id=$id, host=$host, port=$port, username=$username, password=$password]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.id != null) {
      json[r'id'] = this.id;
    } else {
      json[r'id'] = null;
    }
    if (this.host != null) {
      json[r'host'] = this.host;
    } else {
      json[r'host'] = null;
    }
    if (this.port != null) {
      json[r'port'] = this.port;
    } else {
      json[r'port'] = null;
    }
    if (this.username != null) {
      json[r'username'] = this.username;
    } else {
      json[r'username'] = null;
    }
    if (this.password != null) {
      json[r'password'] = this.password;
    } else {
      json[r'password'] = null;
    }
    return json;
  }

  /// Returns a new [CheckEmailConnectivityCommand] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static CheckEmailConnectivityCommand? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "CheckEmailConnectivityCommand[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "CheckEmailConnectivityCommand[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return CheckEmailConnectivityCommand(
        id: mapValueOfType<int>(json, r'id'),
        host: mapValueOfType<String>(json, r'host'),
        port: mapValueOfType<int>(json, r'port'),
        username: mapValueOfType<String>(json, r'username'),
        password: mapValueOfType<String>(json, r'password'),
      );
    }
    return null;
  }

  static List<CheckEmailConnectivityCommand>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CheckEmailConnectivityCommand>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CheckEmailConnectivityCommand.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, CheckEmailConnectivityCommand> mapFromJson(dynamic json) {
    final map = <String, CheckEmailConnectivityCommand>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CheckEmailConnectivityCommand.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of CheckEmailConnectivityCommand-objects as value to a dart map
  static Map<String, List<CheckEmailConnectivityCommand>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<CheckEmailConnectivityCommand>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CheckEmailConnectivityCommand.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

