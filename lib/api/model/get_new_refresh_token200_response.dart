//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class GetNewRefreshToken200Response {
  /// Returns a new [GetNewRefreshToken200Response] instance.
  GetNewRefreshToken200Response({
    required this.jwt,
    required this.refreshToken,
    required this.userId,
    required this.userRole,
    required this.displayName,
    required this.defaultAvatarColor,
    required this.username,
    required this.iss,
    this.sub,
    this.aud = const [],
    required this.exp,
    this.nbf,
    this.iat,
    this.jti,
  });

  /// JWT token
  String jwt;

  /// Refresh token
  String refreshToken;

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
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? sub;

  /// Audience
  List<String> aud;

  /// Expiration time
  int exp;

  /// Not before
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? nbf;

  /// Issued at
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? iat;

  /// JWT ID
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? jti;

  @override
  bool operator ==(Object other) => identical(this, other) || other is GetNewRefreshToken200Response &&
    other.jwt == jwt &&
    other.refreshToken == refreshToken &&
    other.userId == userId &&
    other.userRole == userRole &&
    other.displayName == displayName &&
    other.defaultAvatarColor == defaultAvatarColor &&
    other.username == username &&
    other.iss == iss &&
    other.sub == sub &&
    _deepEquality.equals(other.aud, aud) &&
    other.exp == exp &&
    other.nbf == nbf &&
    other.iat == iat &&
    other.jti == jti;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (jwt.hashCode) +
    (refreshToken.hashCode) +
    (userId.hashCode) +
    (userRole.hashCode) +
    (displayName.hashCode) +
    (defaultAvatarColor.hashCode) +
    (username.hashCode) +
    (iss.hashCode) +
    (sub == null ? 0 : sub!.hashCode) +
    (aud.hashCode) +
    (exp.hashCode) +
    (nbf == null ? 0 : nbf!.hashCode) +
    (iat == null ? 0 : iat!.hashCode) +
    (jti == null ? 0 : jti!.hashCode);

  @override
  String toString() => 'GetNewRefreshToken200Response[jwt=$jwt, refreshToken=$refreshToken, userId=$userId, userRole=$userRole, displayName=$displayName, defaultAvatarColor=$defaultAvatarColor, username=$username, iss=$iss, sub=$sub, aud=$aud, exp=$exp, nbf=$nbf, iat=$iat, jti=$jti]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'jwt'] = this.jwt;
      json[r'refreshToken'] = this.refreshToken;
      json[r'userId'] = this.userId;
      json[r'userRole'] = this.userRole;
      json[r'displayName'] = this.displayName;
      json[r'defaultAvatarColor'] = this.defaultAvatarColor;
      json[r'username'] = this.username;
      json[r'iss'] = this.iss;
    if (this.sub != null) {
      json[r'sub'] = this.sub;
    } else {
      json[r'sub'] = null;
    }
      json[r'aud'] = this.aud;
      json[r'exp'] = this.exp;
    if (this.nbf != null) {
      json[r'nbf'] = this.nbf;
    } else {
      json[r'nbf'] = null;
    }
    if (this.iat != null) {
      json[r'iat'] = this.iat;
    } else {
      json[r'iat'] = null;
    }
    if (this.jti != null) {
      json[r'jti'] = this.jti;
    } else {
      json[r'jti'] = null;
    }
    return json;
  }

  /// Returns a new [GetNewRefreshToken200Response] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static GetNewRefreshToken200Response? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "GetNewRefreshToken200Response[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "GetNewRefreshToken200Response[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return GetNewRefreshToken200Response(
        jwt: mapValueOfType<String>(json, r'jwt')!,
        refreshToken: mapValueOfType<String>(json, r'refreshToken')!,
        userId: mapValueOfType<int>(json, r'userId')!,
        userRole: UserRole.fromJson(json[r'userRole'])!,
        displayName: mapValueOfType<String>(json, r'displayName')!,
        defaultAvatarColor: mapValueOfType<String>(json, r'defaultAvatarColor')!,
        username: mapValueOfType<String>(json, r'username')!,
        iss: mapValueOfType<String>(json, r'iss')!,
        sub: mapValueOfType<String>(json, r'sub'),
        aud: json[r'aud'] is Iterable
            ? (json[r'aud'] as Iterable).cast<String>().toList(growable: false)
            : const [],
        exp: mapValueOfType<int>(json, r'exp')!,
        nbf: mapValueOfType<int>(json, r'nbf'),
        iat: mapValueOfType<int>(json, r'iat'),
        jti: mapValueOfType<String>(json, r'jti'),
      );
    }
    return null;
  }

  static List<GetNewRefreshToken200Response> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <GetNewRefreshToken200Response>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = GetNewRefreshToken200Response.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, GetNewRefreshToken200Response> mapFromJson(dynamic json) {
    final map = <String, GetNewRefreshToken200Response>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = GetNewRefreshToken200Response.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of GetNewRefreshToken200Response-objects as value to a dart map
  static Map<String, List<GetNewRefreshToken200Response>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<GetNewRefreshToken200Response>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = GetNewRefreshToken200Response.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'jwt',
    'refreshToken',
    'userId',
    'userRole',
    'displayName',
    'defaultAvatarColor',
    'username',
    'iss',
    'exp',
  };
}

