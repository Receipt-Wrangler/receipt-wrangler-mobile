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
    required this.createdAt,
    this.createdBy = 0,
    this.createdByString = '',
    this.updatedAt = '',
    required this.userId,
    this.quickScanDefaultGroupId = 0,
    this.quickScanDefaultPaidById = 0,
    this.quickScanDefaultStatus = const UserPreferencesQuickScanDefaultStatusEnum._('OPEN'),
  });

  /// User preferences id
  int id;

  String createdAt;

  int createdBy;

  /// Created by entity's name
  String createdByString;

  String updatedAt;

  /// User foreign key
  int userId;

  /// Group foreign key
  int quickScanDefaultGroupId;

  /// User foreign key
  int quickScanDefaultPaidById;

  /// Default quick scan status
  UserPreferencesQuickScanDefaultStatusEnum quickScanDefaultStatus;

  @override
  bool operator ==(Object other) => identical(this, other) || other is UserPreferences &&
    other.id == id &&
    other.createdAt == createdAt &&
    other.createdBy == createdBy &&
    other.createdByString == createdByString &&
    other.updatedAt == updatedAt &&
    other.userId == userId &&
    other.quickScanDefaultGroupId == quickScanDefaultGroupId &&
    other.quickScanDefaultPaidById == quickScanDefaultPaidById &&
    other.quickScanDefaultStatus == quickScanDefaultStatus;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (createdAt.hashCode) +
    (createdBy.hashCode) +
    (createdByString.hashCode) +
    (updatedAt.hashCode) +
    (userId.hashCode) +
    (quickScanDefaultGroupId.hashCode) +
    (quickScanDefaultPaidById.hashCode) +
    (quickScanDefaultStatus.hashCode);

  @override
  String toString() => 'UserPreferences[id=$id, createdAt=$createdAt, createdBy=$createdBy, createdByString=$createdByString, updatedAt=$updatedAt, userId=$userId, quickScanDefaultGroupId=$quickScanDefaultGroupId, quickScanDefaultPaidById=$quickScanDefaultPaidById, quickScanDefaultStatus=$quickScanDefaultStatus]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'createdAt'] = this.createdAt;
      json[r'createdBy'] = this.createdBy;
      json[r'createdByString'] = this.createdByString;
      json[r'updatedAt'] = this.updatedAt;
      json[r'userId'] = this.userId;
      json[r'quickScanDefaultGroupId'] = this.quickScanDefaultGroupId;
      json[r'quickScanDefaultPaidById'] = this.quickScanDefaultPaidById;
      json[r'quickScanDefaultStatus'] = this.quickScanDefaultStatus;
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
        createdAt: mapValueOfType<String>(json, r'createdAt')!,
        createdBy: mapValueOfType<int>(json, r'createdBy') ?? 0,
        createdByString: mapValueOfType<String>(json, r'createdByString') ?? '',
        updatedAt: mapValueOfType<String>(json, r'updatedAt') ?? '',
        userId: mapValueOfType<int>(json, r'userId')!,
        quickScanDefaultGroupId: mapValueOfType<int>(json, r'quickScanDefaultGroupId') ?? 0,
        quickScanDefaultPaidById: mapValueOfType<int>(json, r'quickScanDefaultPaidById') ?? 0,
        quickScanDefaultStatus: UserPreferencesQuickScanDefaultStatusEnum.fromJson(json[r'quickScanDefaultStatus']) ?? 'OPEN',
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
    'createdAt',
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


