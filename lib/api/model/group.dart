//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Group {
  /// Returns a new [Group] instance.
  Group({
    this.createdAt,
    this.createdBy,
    this.groupSettings,
    this.groupMembers = const [],
    required this.id,
    this.isDefault,
    required this.name,
    required this.isAllGroup,
    required this.status,
    this.updatedAt,
  });

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
  GroupSettings? groupSettings;

  /// Members of the group
  List<GroupMember> groupMembers;

  int id;

  /// Is default group (not used yet)
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? isDefault;

  /// Name of the group
  String name;

  /// Is all group for user
  bool isAllGroup;

  String status;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? updatedAt;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Group &&
    other.createdAt == createdAt &&
    other.createdBy == createdBy &&
    other.groupSettings == groupSettings &&
    _deepEquality.equals(other.groupMembers, groupMembers) &&
    other.id == id &&
    other.isDefault == isDefault &&
    other.name == name &&
    other.isAllGroup == isAllGroup &&
    other.status == status &&
    other.updatedAt == updatedAt;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (createdAt == null ? 0 : createdAt!.hashCode) +
    (createdBy == null ? 0 : createdBy!.hashCode) +
    (groupSettings == null ? 0 : groupSettings!.hashCode) +
    (groupMembers.hashCode) +
    (id.hashCode) +
    (isDefault == null ? 0 : isDefault!.hashCode) +
    (name.hashCode) +
    (isAllGroup.hashCode) +
    (status.hashCode) +
    (updatedAt == null ? 0 : updatedAt!.hashCode);

  @override
  String toString() => 'Group[createdAt=$createdAt, createdBy=$createdBy, groupSettings=$groupSettings, groupMembers=$groupMembers, id=$id, isDefault=$isDefault, name=$name, isAllGroup=$isAllGroup, status=$status, updatedAt=$updatedAt]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
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
    if (this.groupSettings != null) {
      json[r'groupSettings'] = this.groupSettings;
    } else {
      json[r'groupSettings'] = null;
    }
      json[r'groupMembers'] = this.groupMembers;
      json[r'id'] = this.id;
    if (this.isDefault != null) {
      json[r'isDefault'] = this.isDefault;
    } else {
      json[r'isDefault'] = null;
    }
      json[r'name'] = this.name;
      json[r'isAllGroup'] = this.isAllGroup;
      json[r'status'] = this.status;
    if (this.updatedAt != null) {
      json[r'updatedAt'] = this.updatedAt;
    } else {
      json[r'updatedAt'] = null;
    }
    return json;
  }

  /// Returns a new [Group] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Group? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "Group[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "Group[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return Group(
        createdAt: mapValueOfType<String>(json, r'createdAt'),
        createdBy: mapValueOfType<int>(json, r'createdBy'),
        groupSettings: GroupSettings.fromJson(json[r'groupSettings']),
        groupMembers: GroupMember.listFromJson(json[r'groupMembers']),
        id: mapValueOfType<int>(json, r'id')!,
        isDefault: mapValueOfType<bool>(json, r'isDefault'),
        name: mapValueOfType<String>(json, r'name')!,
        isAllGroup: mapValueOfType<bool>(json, r'isAllGroup')!,
        status: mapValueOfType<String>(json, r'status')!,
        updatedAt: mapValueOfType<String>(json, r'updatedAt'),
      );
    }
    return null;
  }

  static List<Group> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Group>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Group.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Group> mapFromJson(dynamic json) {
    final map = <String, Group>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Group.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Group-objects as value to a dart map
  static Map<String, List<Group>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Group>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Group.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'groupMembers',
    'id',
    'name',
    'isAllGroup',
    'status',
  };
}

