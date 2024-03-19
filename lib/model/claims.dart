//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Claims {
  /// Returns a new [Claims] instance.
  Claims({
    this.userId = 0,
    required this.userRole,
    this.displayName = '',
    this.defaultAvatarColor = '',
    this.username = '',
    this.iss = '',
    this.sub = '',
    this.aud = const [],
    this.exp = 0,
    this.nbf = 0,
    this.iat = 0,
    this.jti = '',
  });

  /// User foreign key
  int userId;

  UserRole userRole;

  /// Display name
  String displayName;

  /// Default avatar color
  String defaultAvatarColor;

  /// User's username used to login
  String username;

  /// Issuer
  String iss;

  /// Subject
  String sub;

  /// Audience
  List<String> aud;

  /// Expiration time
  int exp;

  /// Not before
  int nbf;

  /// Issued at
  int iat;

  /// JWT ID
  String jti;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Claims &&
     other.userId == userId &&
     other.userRole == userRole &&
     other.displayName == displayName &&
     other.defaultAvatarColor == defaultAvatarColor &&
     other.username == username &&
     other.iss == iss &&
     other.sub == sub &&
     other.aud == aud &&
     other.exp == exp &&
     other.nbf == nbf &&
     other.iat == iat &&
     other.jti == jti;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (userId.hashCode) +
    (userRole.hashCode) +
    (displayName.hashCode) +
    (defaultAvatarColor.hashCode) +
    (username.hashCode) +
    (iss.hashCode) +
    (sub.hashCode) +
    (aud.hashCode) +
    (exp.hashCode) +
    (nbf.hashCode) +
    (iat.hashCode) +
    (jti.hashCode);

  @override
  String toString() => 'Claims[userId=$userId, userRole=$userRole, displayName=$displayName, defaultAvatarColor=$defaultAvatarColor, username=$username, iss=$iss, sub=$sub, aud=$aud, exp=$exp, nbf=$nbf, iat=$iat, jti=$jti]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'userId'] = this.userId;
      json[r'userRole'] = this.userRole;
      json[r'displayName'] = this.displayName;
      json[r'defaultAvatarColor'] = this.defaultAvatarColor;
      json[r'username'] = this.username;
      json[r'iss'] = this.iss;
      json[r'sub'] = this.sub;
      json[r'aud'] = this.aud;
      json[r'exp'] = this.exp;
      json[r'nbf'] = this.nbf;
      json[r'iat'] = this.iat;
      json[r'jti'] = this.jti;
    return json;
  }

  /// Returns a new [Claims] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Claims? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "Claims[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "Claims[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return Claims(
        userId: mapValueOfType<int>(json, r'userId')!,
        userRole: UserRole.fromJson(json[r'userRole'])!,
        displayName: mapValueOfType<String>(json, r'displayName')!,
        defaultAvatarColor: mapValueOfType<String>(json, r'defaultAvatarColor')!,
        username: mapValueOfType<String>(json, r'username')!,
        iss: mapValueOfType<String>(json, r'iss')!,
        sub: mapValueOfType<String>(json, r'sub') ?? '',
        aud: json[r'aud'] is List
            ? (json[r'aud'] as List).cast<String>()
            : const [],
        exp: mapValueOfType<int>(json, r'exp')!,
        nbf: mapValueOfType<int>(json, r'nbf') ?? 0,
        iat: mapValueOfType<int>(json, r'iat') ?? 0,
        jti: mapValueOfType<String>(json, r'jti') ?? '',
      );
    }
    return null;
  }

  static List<Claims>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Claims>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Claims.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Claims> mapFromJson(dynamic json) {
    final map = <String, Claims>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Claims.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Claims-objects as value to a dart map
  static Map<String, List<Claims>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Claims>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Claims.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'userId',
    'userRole',
    'displayName',
    'defaultAvatarColor',
    'username',
    'iss',
    'exp',
  };
}

