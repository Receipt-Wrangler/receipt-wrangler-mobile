//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class SignUpCommand {
  /// Returns a new [SignUpCommand] instance.
  SignUpCommand({
    required this.username,
    required this.password,
    this.displayName,
    this.isDummyUser,
    this.userRole,
  });

  /// User's username
  String username;

  /// User's password
  String password;

  /// User's displayname
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? displayName;

  /// Whether the user is a dummy user
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? isDummyUser;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  UserRole? userRole;

  @override
  bool operator ==(Object other) => identical(this, other) || other is SignUpCommand &&
     other.username == username &&
     other.password == password &&
     other.displayName == displayName &&
     other.isDummyUser == isDummyUser &&
     other.userRole == userRole;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (username.hashCode) +
    (password.hashCode) +
    (displayName == null ? 0 : displayName!.hashCode) +
    (isDummyUser == null ? 0 : isDummyUser!.hashCode) +
    (userRole == null ? 0 : userRole!.hashCode);

  @override
  String toString() => 'SignUpCommand[username=$username, password=$password, displayName=$displayName, isDummyUser=$isDummyUser, userRole=$userRole]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'username'] = this.username;
      json[r'password'] = this.password;
    if (this.displayName != null) {
      json[r'displayName'] = this.displayName;
    } else {
      json[r'displayName'] = null;
    }
    if (this.isDummyUser != null) {
      json[r'isDummyUser'] = this.isDummyUser;
    } else {
      json[r'isDummyUser'] = null;
    }
    if (this.userRole != null) {
      json[r'userRole'] = this.userRole;
    } else {
      json[r'userRole'] = null;
    }
    return json;
  }

  /// Returns a new [SignUpCommand] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static SignUpCommand? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "SignUpCommand[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "SignUpCommand[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return SignUpCommand(
        username: mapValueOfType<String>(json, r'username')!,
        password: mapValueOfType<String>(json, r'password')!,
        displayName: mapValueOfType<String>(json, r'displayName'),
        isDummyUser: mapValueOfType<bool>(json, r'isDummyUser'),
        userRole: UserRole.fromJson(json[r'userRole']),
      );
    }
    return null;
  }

  static List<SignUpCommand>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SignUpCommand>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SignUpCommand.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, SignUpCommand> mapFromJson(dynamic json) {
    final map = <String, SignUpCommand>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SignUpCommand.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of SignUpCommand-objects as value to a dart map
  static Map<String, List<SignUpCommand>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<SignUpCommand>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SignUpCommand.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'username',
    'password',
  };
}

