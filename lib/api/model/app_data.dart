//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AppData {
  /// Returns a new [AppData] instance.
  AppData({
    required this.claims,
    this.groups = const [],
    this.users = const [],
    this.userPreferences = const [],
    this.jwt,
    this.refreshToken,
  });

  /// User's claims
  Object claims;

  /// Groups in the system
  List<Group> groups;

  /// Users in the system
  List<UserView> users;

  /// User preferences in the system
  List<UserPreferences> userPreferences;

  /// JWT token
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? jwt;

  /// Refresh token
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? refreshToken;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AppData &&
    other.claims == claims &&
    _deepEquality.equals(other.groups, groups) &&
    _deepEquality.equals(other.users, users) &&
    _deepEquality.equals(other.userPreferences, userPreferences) &&
    other.jwt == jwt &&
    other.refreshToken == refreshToken;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (claims.hashCode) +
    (groups.hashCode) +
    (users.hashCode) +
    (userPreferences.hashCode) +
    (jwt == null ? 0 : jwt!.hashCode) +
    (refreshToken == null ? 0 : refreshToken!.hashCode);

  @override
  String toString() => 'AppData[claims=$claims, groups=$groups, users=$users, userPreferences=$userPreferences, jwt=$jwt, refreshToken=$refreshToken]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'claims'] = this.claims;
      json[r'groups'] = this.groups;
      json[r'users'] = this.users;
      json[r'userPreferences'] = this.userPreferences;
    if (this.jwt != null) {
      json[r'jwt'] = this.jwt;
    } else {
      json[r'jwt'] = null;
    }
    if (this.refreshToken != null) {
      json[r'refreshToken'] = this.refreshToken;
    } else {
      json[r'refreshToken'] = null;
    }
    return json;
  }

  /// Returns a new [AppData] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AppData? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "AppData[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "AppData[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return AppData(
        claims: mapValueOfType<Object>(json, r'claims')!,
        groups: Group.listFromJson(json[r'groups']),
        users: UserView.listFromJson(json[r'users']),
        userPreferences: UserPreferences.listFromJson(json[r'userPreferences']),
        jwt: mapValueOfType<String>(json, r'jwt'),
        refreshToken: mapValueOfType<String>(json, r'refreshToken'),
      );
    }
    return null;
  }

  static List<AppData> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AppData>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AppData.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AppData> mapFromJson(dynamic json) {
    final map = <String, AppData>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AppData.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AppData-objects as value to a dart map
  static Map<String, List<AppData>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AppData>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AppData.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'claims',
    'groups',
    'users',
    'userPreferences',
  };
}
