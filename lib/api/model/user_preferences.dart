//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class UserPreferences {
  /// Returns a new [UserPreferences] instance.
  UserPreferences({
    required this.id,
    required this.userId,
    this.quickScanDefaultGroupId,
    this.quickScanDefaultPaidById,
    this.quickScanDefaultStatus,
  });

  /// User preferences id
  int id;

  /// User foreign key
  int userId;

  /// Group foreign key
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? quickScanDefaultGroupId;

  /// User foreign key
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? quickScanDefaultPaidById;

  /// Default quick scan status
  UserPreferencesQuickScanDefaultStatusEnum? quickScanDefaultStatus;

  @override
  bool operator ==(Object other) => identical(this, other) || other is UserPreferences &&
    other.id == id &&
    other.userId == userId &&
    other.quickScanDefaultGroupId == quickScanDefaultGroupId &&
    other.quickScanDefaultPaidById == quickScanDefaultPaidById &&
    other.quickScanDefaultStatus == quickScanDefaultStatus;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (userId.hashCode) +
    (quickScanDefaultGroupId == null ? 0 : quickScanDefaultGroupId!.hashCode) +
    (quickScanDefaultPaidById == null ? 0 : quickScanDefaultPaidById!.hashCode) +
    (quickScanDefaultStatus == null ? 0 : quickScanDefaultStatus!.hashCode);

  @override
  String toString() => 'UserPreferences[id=$id, userId=$userId, quickScanDefaultGroupId=$quickScanDefaultGroupId, quickScanDefaultPaidById=$quickScanDefaultPaidById, quickScanDefaultStatus=$quickScanDefaultStatus]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'userId'] = this.userId;
    if (this.quickScanDefaultGroupId != null) {
      json[r'quickScanDefaultGroupId'] = this.quickScanDefaultGroupId;
    } else {
      json[r'quickScanDefaultGroupId'] = null;
    }
    if (this.quickScanDefaultPaidById != null) {
      json[r'quickScanDefaultPaidById'] = this.quickScanDefaultPaidById;
    } else {
      json[r'quickScanDefaultPaidById'] = null;
    }
    if (this.quickScanDefaultStatus != null) {
      json[r'quickScanDefaultStatus'] = this.quickScanDefaultStatus;
    } else {
      json[r'quickScanDefaultStatus'] = null;
    }
    return json;
  }

  /// Returns a new [UserPreferences] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UserPreferences? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "UserPreferences[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "UserPreferences[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return UserPreferences(
        id: mapValueOfType<int>(json, r'id')!,
        userId: mapValueOfType<int>(json, r'userId')!,
        quickScanDefaultGroupId: mapValueOfType<int>(json, r'quickScanDefaultGroupId'),
        quickScanDefaultPaidById: mapValueOfType<int>(json, r'quickScanDefaultPaidById'),
        quickScanDefaultStatus: UserPreferencesQuickScanDefaultStatusEnum.fromJson(json[r'quickScanDefaultStatus']),
      );
    }
    return null;
  }

  static List<UserPreferences> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UserPreferences>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UserPreferences.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UserPreferences> mapFromJson(dynamic json) {
    final map = <String, UserPreferences>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UserPreferences.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UserPreferences-objects as value to a dart map
  static Map<String, List<UserPreferences>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<UserPreferences>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = UserPreferences.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'userId',
  };
}

/// Default quick scan status
class UserPreferencesQuickScanDefaultStatusEnum {
  /// Instantiate a new enum with the provided [value].
  const UserPreferencesQuickScanDefaultStatusEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const OPEN = UserPreferencesQuickScanDefaultStatusEnum._(r'OPEN');
  static const NEEDS_ATTENTION = UserPreferencesQuickScanDefaultStatusEnum._(r'NEEDS_ATTENTION');
  static const RESOLVED = UserPreferencesQuickScanDefaultStatusEnum._(r'RESOLVED');
  static const DRAFT = UserPreferencesQuickScanDefaultStatusEnum._(r'DRAFT');

  /// List of all possible values in this [enum][UserPreferencesQuickScanDefaultStatusEnum].
  static const values = <UserPreferencesQuickScanDefaultStatusEnum>[
    OPEN,
    NEEDS_ATTENTION,
    RESOLVED,
    DRAFT,
  ];

  static UserPreferencesQuickScanDefaultStatusEnum? fromJson(dynamic value) => UserPreferencesQuickScanDefaultStatusEnumTypeTransformer().decode(value);

  static List<UserPreferencesQuickScanDefaultStatusEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UserPreferencesQuickScanDefaultStatusEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UserPreferencesQuickScanDefaultStatusEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [UserPreferencesQuickScanDefaultStatusEnum] to String,
/// and [decode] dynamic data back to [UserPreferencesQuickScanDefaultStatusEnum].
class UserPreferencesQuickScanDefaultStatusEnumTypeTransformer {
  factory UserPreferencesQuickScanDefaultStatusEnumTypeTransformer() => _instance ??= const UserPreferencesQuickScanDefaultStatusEnumTypeTransformer._();

  const UserPreferencesQuickScanDefaultStatusEnumTypeTransformer._();

  String encode(UserPreferencesQuickScanDefaultStatusEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a UserPreferencesQuickScanDefaultStatusEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  UserPreferencesQuickScanDefaultStatusEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'OPEN': return UserPreferencesQuickScanDefaultStatusEnum.OPEN;
        case r'NEEDS_ATTENTION': return UserPreferencesQuickScanDefaultStatusEnum.NEEDS_ATTENTION;
        case r'RESOLVED': return UserPreferencesQuickScanDefaultStatusEnum.RESOLVED;
        case r'DRAFT': return UserPreferencesQuickScanDefaultStatusEnum.DRAFT;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [UserPreferencesQuickScanDefaultStatusEnumTypeTransformer] instance.
  static UserPreferencesQuickScanDefaultStatusEnumTypeTransformer? _instance;
}


