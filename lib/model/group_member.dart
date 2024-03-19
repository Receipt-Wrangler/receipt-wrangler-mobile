//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class GroupMember {
  /// Returns a new [GroupMember] instance.
  GroupMember({
    this.createdAt,
    required this.groupId,
    required this.groupRole,
    this.updatedAt,
    required this.userId,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? createdAt;

  /// Group compound primary key
  int groupId;

  GroupRole groupRole;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? updatedAt;

  /// User compound primary key
  int userId;

  @override
  bool operator ==(Object other) => identical(this, other) || other is GroupMember &&
     other.createdAt == createdAt &&
     other.groupId == groupId &&
     other.groupRole == groupRole &&
     other.updatedAt == updatedAt &&
     other.userId == userId;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (createdAt == null ? 0 : createdAt!.hashCode) +
    (groupId.hashCode) +
    (groupRole.hashCode) +
    (updatedAt == null ? 0 : updatedAt!.hashCode) +
    (userId.hashCode);

  @override
  String toString() => 'GroupMember[createdAt=$createdAt, groupId=$groupId, groupRole=$groupRole, updatedAt=$updatedAt, userId=$userId]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.createdAt != null) {
      json[r'createdAt'] = this.createdAt;
    } else {
      json[r'createdAt'] = null;
    }
      json[r'groupId'] = this.groupId;
      json[r'groupRole'] = this.groupRole;
    if (this.updatedAt != null) {
      json[r'updatedAt'] = this.updatedAt;
    } else {
      json[r'updatedAt'] = null;
    }
      json[r'userId'] = this.userId;
    return json;
  }

  /// Returns a new [GroupMember] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static GroupMember? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "GroupMember[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "GroupMember[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return GroupMember(
        createdAt: mapValueOfType<String>(json, r'createdAt'),
        groupId: mapValueOfType<int>(json, r'groupId')!,
        groupRole: GroupRole.fromJson(json[r'groupRole'])!,
        updatedAt: mapValueOfType<String>(json, r'updatedAt'),
        userId: mapValueOfType<int>(json, r'userId')!,
      );
    }
    return null;
  }

  static List<GroupMember>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <GroupMember>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = GroupMember.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, GroupMember> mapFromJson(dynamic json) {
    final map = <String, GroupMember>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = GroupMember.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of GroupMember-objects as value to a dart map
  static Map<String, List<GroupMember>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<GroupMember>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = GroupMember.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'groupId',
    'groupRole',
    'userId',
  };
}

