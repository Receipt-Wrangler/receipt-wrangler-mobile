//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class User {
  /// Returns a new [User] instance.
  User({
    this.password,
    required this.username,
    this.createdAt,
    this.createdBy,
    this.defaultAvatarColor,
    required this.displayName,
    required this.id,
    required this.isDummyUser,
    this.updatedAt,
    required this.userRole,
  });

  /// User's password
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? password;

  /// User's username used to login
  String username;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? createdAt;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? createdBy;

  /// Default avatar color
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? defaultAvatarColor;

  /// Display name
  String displayName;

  int id;

  /// Is dummy user
  bool isDummyUser;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? updatedAt;

  UserRole userRole;

  @override
  bool operator ==(Object other) => identical(this, other) || other is User &&
    other.password == password &&
    other.username == username &&
    other.createdAt == createdAt &&
    other.createdBy == createdBy &&
    other.defaultAvatarColor == defaultAvatarColor &&
    other.displayName == displayName &&
    other.id == id &&
    other.isDummyUser == isDummyUser &&
    other.updatedAt == updatedAt &&
    other.userRole == userRole;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (password == null ? 0 : password!.hashCode) +
    (username.hashCode) +
    (createdAt == null ? 0 : createdAt!.hashCode) +
    (createdBy == null ? 0 : createdBy!.hashCode) +
    (defaultAvatarColor == null ? 0 : defaultAvatarColor!.hashCode) +
    (displayName.hashCode) +
    (id.hashCode) +
    (isDummyUser.hashCode) +
    (updatedAt == null ? 0 : updatedAt!.hashCode) +
    (userRole.hashCode);

  @override
  String toString() => 'User[password=$password, username=$username, createdAt=$createdAt, createdBy=$createdBy, defaultAvatarColor=$defaultAvatarColor, displayName=$displayName, id=$id, isDummyUser=$isDummyUser, updatedAt=$updatedAt, userRole=$userRole]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.password != null) {
      json[r'password'] = this.password;
    } else {
      json[r'password'] = null;
    }
      json[r'username'] = this.username;
    if (this.createdAt != null) {
      json[r'createdAt'] = this.createdAt;
    } else {
      json[r'createdAt'] = null;
    }
    if (this.createdBy != null) {
      json[r'createdBy'] = this.createdBy;
    } else {
      json[r'createdBy'] = null;
    }
    if (this.defaultAvatarColor != null) {
      json[r'defaultAvatarColor'] = this.defaultAvatarColor;
    } else {
      json[r'defaultAvatarColor'] = null;
    }
      json[r'displayName'] = this.displayName;
      json[r'id'] = this.id;
      json[r'isDummyUser'] = this.isDummyUser;
    if (this.updatedAt != null) {
      json[r'updatedAt'] = this.updatedAt;
    } else {
      json[r'updatedAt'] = null;
    }
      json[r'userRole'] = this.userRole;
    return json;
  }

  /// Returns a new [User] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static User? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "User[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "User[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return User(
        password: mapValueOfType<String>(json, r'password'),
        username: mapValueOfType<String>(json, r'username')!,
        createdAt: mapValueOfType<String>(json, r'createdAt'),
        createdBy: mapValueOfType<int>(json, r'createdBy'),
        defaultAvatarColor: mapValueOfType<String>(json, r'defaultAvatarColor'),
        displayName: mapValueOfType<String>(json, r'displayName')!,
        id: mapValueOfType<int>(json, r'id')!,
        isDummyUser: mapValueOfType<bool>(json, r'isDummyUser')!,
        updatedAt: mapValueOfType<String>(json, r'updatedAt'),
        userRole: UserRole.fromJson(json[r'userRole'])!,
      );
    }
    return null;
  }

  static List<User> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <User>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = User.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, User> mapFromJson(dynamic json) {
    final map = <String, User>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = User.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of User-objects as value to a dart map
  static Map<String, List<User>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<User>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = User.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'username',
    'displayName',
    'id',
    'isDummyUser',
    'userRole',
  };
}

