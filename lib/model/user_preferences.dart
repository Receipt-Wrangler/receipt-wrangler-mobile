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
    this.quickScanDefaultStatus,
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

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  ReceiptStatus? quickScanDefaultStatus;

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
    (quickScanDefaultStatus == null ? 0 : quickScanDefaultStatus!.hashCode);

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
        createdAt: mapValueOfType<String>(json, r'createdAt')!,
        createdBy: mapValueOfType<int>(json, r'createdBy') ?? 0,
        createdByString: mapValueOfType<String>(json, r'createdByString') ?? '',
        updatedAt: mapValueOfType<String>(json, r'updatedAt') ?? '',
        userId: mapValueOfType<int>(json, r'userId')!,
        quickScanDefaultGroupId: mapValueOfType<int>(json, r'quickScanDefaultGroupId') ?? 0,
        quickScanDefaultPaidById: mapValueOfType<int>(json, r'quickScanDefaultPaidById') ?? 0,
        quickScanDefaultStatus: ReceiptStatus.fromJson(json[r'quickScanDefaultStatus']),
      );
    }
    return null;
  }

  static List<UserPreferences>? listFromJson(dynamic json, {bool growable = false,}) {
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
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UserPreferences.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
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

