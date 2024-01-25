//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class GroupSettings {
  /// Returns a new [GroupSettings] instance.
  GroupSettings({
    required this.id,
    required this.groupId,
    this.emailIntegrationEnabled,
    this.emailToRead,
    this.subjectLineRegexes = const [],
    this.emailWhiteList = const [],
    this.emailDefaultReceiptStatus,
    this.emailDefaultReceiptPaidById,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
  });

  /// Group settings id
  int id;

  /// Group foreign key
  int groupId;

  /// Whether email integration is enabled
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? emailIntegrationEnabled;

  /// Email to read
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? emailToRead;

  /// Subject line regexes
  List<SubjectLineRegex> subjectLineRegexes;

  /// Email white list
  List<GroupSettingsWhiteListEmail> emailWhiteList;

  /// Default receipt status
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? emailDefaultReceiptStatus;

  /// User foreign key
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? emailDefaultReceiptPaidById;

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

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? updatedAt;

  @override
  bool operator ==(Object other) => identical(this, other) || other is GroupSettings &&
    other.id == id &&
    other.groupId == groupId &&
    other.emailIntegrationEnabled == emailIntegrationEnabled &&
    other.emailToRead == emailToRead &&
    _deepEquality.equals(other.subjectLineRegexes, subjectLineRegexes) &&
    _deepEquality.equals(other.emailWhiteList, emailWhiteList) &&
    other.emailDefaultReceiptStatus == emailDefaultReceiptStatus &&
    other.emailDefaultReceiptPaidById == emailDefaultReceiptPaidById &&
    other.createdAt == createdAt &&
    other.createdBy == createdBy &&
    other.updatedAt == updatedAt;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (groupId.hashCode) +
    (emailIntegrationEnabled == null ? 0 : emailIntegrationEnabled!.hashCode) +
    (emailToRead == null ? 0 : emailToRead!.hashCode) +
    (subjectLineRegexes.hashCode) +
    (emailWhiteList.hashCode) +
    (emailDefaultReceiptStatus == null ? 0 : emailDefaultReceiptStatus!.hashCode) +
    (emailDefaultReceiptPaidById == null ? 0 : emailDefaultReceiptPaidById!.hashCode) +
    (createdAt == null ? 0 : createdAt!.hashCode) +
    (createdBy == null ? 0 : createdBy!.hashCode) +
    (updatedAt == null ? 0 : updatedAt!.hashCode);

  @override
  String toString() => 'GroupSettings[id=$id, groupId=$groupId, emailIntegrationEnabled=$emailIntegrationEnabled, emailToRead=$emailToRead, subjectLineRegexes=$subjectLineRegexes, emailWhiteList=$emailWhiteList, emailDefaultReceiptStatus=$emailDefaultReceiptStatus, emailDefaultReceiptPaidById=$emailDefaultReceiptPaidById, createdAt=$createdAt, createdBy=$createdBy, updatedAt=$updatedAt]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'groupId'] = this.groupId;
    if (this.emailIntegrationEnabled != null) {
      json[r'emailIntegrationEnabled'] = this.emailIntegrationEnabled;
    } else {
      json[r'emailIntegrationEnabled'] = null;
    }
    if (this.emailToRead != null) {
      json[r'emailToRead'] = this.emailToRead;
    } else {
      json[r'emailToRead'] = null;
    }
      json[r'subjectLineRegexes'] = this.subjectLineRegexes;
      json[r'emailWhiteList'] = this.emailWhiteList;
    if (this.emailDefaultReceiptStatus != null) {
      json[r'emailDefaultReceiptStatus'] = this.emailDefaultReceiptStatus;
    } else {
      json[r'emailDefaultReceiptStatus'] = null;
    }
    if (this.emailDefaultReceiptPaidById != null) {
      json[r'emailDefaultReceiptPaidById'] = this.emailDefaultReceiptPaidById;
    } else {
      json[r'emailDefaultReceiptPaidById'] = null;
    }
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
    if (this.updatedAt != null) {
      json[r'updatedAt'] = this.updatedAt;
    } else {
      json[r'updatedAt'] = null;
    }
    return json;
  }

  /// Returns a new [GroupSettings] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static GroupSettings? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "GroupSettings[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "GroupSettings[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return GroupSettings(
        id: mapValueOfType<int>(json, r'id')!,
        groupId: mapValueOfType<int>(json, r'groupId')!,
        emailIntegrationEnabled: mapValueOfType<bool>(json, r'emailIntegrationEnabled'),
        emailToRead: mapValueOfType<String>(json, r'emailToRead'),
        subjectLineRegexes: SubjectLineRegex.listFromJson(json[r'subjectLineRegexes']),
        emailWhiteList: GroupSettingsWhiteListEmail.listFromJson(json[r'emailWhiteList']),
        emailDefaultReceiptStatus: mapValueOfType<String>(json, r'emailDefaultReceiptStatus'),
        emailDefaultReceiptPaidById: mapValueOfType<int>(json, r'emailDefaultReceiptPaidById'),
        createdAt: mapValueOfType<String>(json, r'createdAt'),
        createdBy: mapValueOfType<int>(json, r'createdBy'),
        updatedAt: mapValueOfType<String>(json, r'updatedAt'),
      );
    }
    return null;
  }

  static List<GroupSettings> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <GroupSettings>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = GroupSettings.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, GroupSettings> mapFromJson(dynamic json) {
    final map = <String, GroupSettings>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = GroupSettings.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of GroupSettings-objects as value to a dart map
  static Map<String, List<GroupSettings>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<GroupSettings>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = GroupSettings.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'groupId',
  };
}

