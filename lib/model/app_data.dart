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
    required this.userPreferences,
    required this.featureConfig,
    this.categories = const [],
    this.tags = const [],
    this.jwt,
    this.refreshToken,
    required this.currencyDisplay,
  });

  Claims claims;

  /// Groups in the system
  List<Group> groups;

  /// Users in the system
  List<UserView> users;

  UserPreferences userPreferences;

  FeatureConfig featureConfig;

  /// Categories in the system
  List<Category> categories;

  /// Tags in the system
  List<Tag> tags;

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

  /// Currency display
  String currencyDisplay;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AppData &&
     other.claims == claims &&
     other.groups == groups &&
     other.users == users &&
     other.userPreferences == userPreferences &&
     other.featureConfig == featureConfig &&
     other.categories == categories &&
     other.tags == tags &&
     other.jwt == jwt &&
     other.refreshToken == refreshToken &&
     other.currencyDisplay == currencyDisplay;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (claims.hashCode) +
    (groups.hashCode) +
    (users.hashCode) +
    (userPreferences.hashCode) +
    (featureConfig.hashCode) +
    (categories.hashCode) +
    (tags.hashCode) +
    (jwt == null ? 0 : jwt!.hashCode) +
    (refreshToken == null ? 0 : refreshToken!.hashCode) +
    (currencyDisplay.hashCode);

  @override
  String toString() => 'AppData[claims=$claims, groups=$groups, users=$users, userPreferences=$userPreferences, featureConfig=$featureConfig, categories=$categories, tags=$tags, jwt=$jwt, refreshToken=$refreshToken, currencyDisplay=$currencyDisplay]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'claims'] = this.claims;
      json[r'groups'] = this.groups;
      json[r'users'] = this.users;
      json[r'userPreferences'] = this.userPreferences;
      json[r'featureConfig'] = this.featureConfig;
      json[r'categories'] = this.categories;
      json[r'tags'] = this.tags;
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
      json[r'currencyDisplay'] = this.currencyDisplay;
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
        claims: Claims.fromJson(json[r'claims'])!,
        groups: Group.listFromJson(json[r'groups'])!,
        users: UserView.listFromJson(json[r'users'])!,
        userPreferences: UserPreferences.fromJson(json[r'userPreferences'])!,
        featureConfig: FeatureConfig.fromJson(json[r'featureConfig'])!,
        categories: Category.listFromJson(json[r'categories'])!,
        tags: Tag.listFromJson(json[r'tags'])!,
        jwt: mapValueOfType<String>(json, r'jwt'),
        refreshToken: mapValueOfType<String>(json, r'refreshToken'),
        currencyDisplay: mapValueOfType<String>(json, r'currencyDisplay')!,
      );
    }
    return null;
  }

  static List<AppData>? listFromJson(dynamic json, {bool growable = false,}) {
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
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AppData.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
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
    'featureConfig',
    'categories',
    'tags',
    'currencyDisplay',
  };
}

