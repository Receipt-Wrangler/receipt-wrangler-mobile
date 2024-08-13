//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class UserPreferencesAllOf {
  /// Returns a new [UserPreferencesAllOf] instance.
  UserPreferencesAllOf({
    required this.id,
    required this.userId,
    this.quickScanDefaultGroupId = 0,
    this.quickScanDefaultPaidById = 0,
    this.quickScanDefaultStatus,
    this.showLargeImagePreviews = false,
  });

  /// User preferences id
  int id;

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

  /// Whether to show large image previews
  bool showLargeImagePreviews;

  @override
  bool operator ==(Object other) => identical(this, other) || other is UserPreferencesAllOf &&
     other.id == id &&
     other.userId == userId &&
     other.quickScanDefaultGroupId == quickScanDefaultGroupId &&
     other.quickScanDefaultPaidById == quickScanDefaultPaidById &&
     other.quickScanDefaultStatus == quickScanDefaultStatus &&
     other.showLargeImagePreviews == showLargeImagePreviews;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (userId.hashCode) +
    (quickScanDefaultGroupId.hashCode) +
    (quickScanDefaultPaidById.hashCode) +
    (quickScanDefaultStatus == null ? 0 : quickScanDefaultStatus!.hashCode) +
    (showLargeImagePreviews.hashCode);

  @override
  String toString() => 'UserPreferencesAllOf[id=$id, userId=$userId, quickScanDefaultGroupId=$quickScanDefaultGroupId, quickScanDefaultPaidById=$quickScanDefaultPaidById, quickScanDefaultStatus=$quickScanDefaultStatus, showLargeImagePreviews=$showLargeImagePreviews]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'userId'] = this.userId;
      json[r'quickScanDefaultGroupId'] = this.quickScanDefaultGroupId;
      json[r'quickScanDefaultPaidById'] = this.quickScanDefaultPaidById;
    if (this.quickScanDefaultStatus != null) {
      json[r'quickScanDefaultStatus'] = this.quickScanDefaultStatus;
    } else {
      json[r'quickScanDefaultStatus'] = null;
    }
      json[r'showLargeImagePreviews'] = this.showLargeImagePreviews;
    return json;
  }

  /// Returns a new [UserPreferencesAllOf] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UserPreferencesAllOf? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "UserPreferencesAllOf[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "UserPreferencesAllOf[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return UserPreferencesAllOf(
        id: mapValueOfType<int>(json, r'id')!,
        userId: mapValueOfType<int>(json, r'userId')!,
        quickScanDefaultGroupId: mapValueOfType<int>(json, r'quickScanDefaultGroupId') ?? 0,
        quickScanDefaultPaidById: mapValueOfType<int>(json, r'quickScanDefaultPaidById') ?? 0,
        quickScanDefaultStatus: ReceiptStatus.fromJson(json[r'quickScanDefaultStatus']),
        showLargeImagePreviews: mapValueOfType<bool>(json, r'showLargeImagePreviews') ?? false,
      );
    }
    return null;
  }

  static List<UserPreferencesAllOf>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UserPreferencesAllOf>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UserPreferencesAllOf.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UserPreferencesAllOf> mapFromJson(dynamic json) {
    final map = <String, UserPreferencesAllOf>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UserPreferencesAllOf.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UserPreferencesAllOf-objects as value to a dart map
  static Map<String, List<UserPreferencesAllOf>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<UserPreferencesAllOf>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UserPreferencesAllOf.listFromJson(entry.value, growable: growable,);
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
    'userId',
  };
}

