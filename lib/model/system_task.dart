//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class SystemTask {
  /// Returns a new [SystemTask] instance.
  SystemTask({
    required this.id,
    required this.createdAt,
    this.createdBy = 0,
    this.createdByString = '',
    this.updatedAt = '',
    this.type,
    this.status,
    this.startedAt,
    this.endedAt,
    this.associatedEntityId,
    this.associatedEntityType,
    this.ranByUserId,
    this.resultDescription,
    this.childSystemTasks = const [],
  });

  int id;

  String createdAt;

  int createdBy;

  /// Created by entity's name
  String createdByString;

  String updatedAt;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  SystemTaskType? type;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  SystemTaskStatus? status;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? startedAt;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? endedAt;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? associatedEntityId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  AssociatedEntityType? associatedEntityType;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? ranByUserId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? resultDescription;

  List<SystemTask> childSystemTasks;

  @override
  bool operator ==(Object other) => identical(this, other) || other is SystemTask &&
     other.id == id &&
     other.createdAt == createdAt &&
     other.createdBy == createdBy &&
     other.createdByString == createdByString &&
     other.updatedAt == updatedAt &&
     other.type == type &&
     other.status == status &&
     other.startedAt == startedAt &&
     other.endedAt == endedAt &&
     other.associatedEntityId == associatedEntityId &&
     other.associatedEntityType == associatedEntityType &&
     other.ranByUserId == ranByUserId &&
     other.resultDescription == resultDescription &&
     other.childSystemTasks == childSystemTasks;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (createdAt.hashCode) +
    (createdBy.hashCode) +
    (createdByString.hashCode) +
    (updatedAt.hashCode) +
    (type == null ? 0 : type!.hashCode) +
    (status == null ? 0 : status!.hashCode) +
    (startedAt == null ? 0 : startedAt!.hashCode) +
    (endedAt == null ? 0 : endedAt!.hashCode) +
    (associatedEntityId == null ? 0 : associatedEntityId!.hashCode) +
    (associatedEntityType == null ? 0 : associatedEntityType!.hashCode) +
    (ranByUserId == null ? 0 : ranByUserId!.hashCode) +
    (resultDescription == null ? 0 : resultDescription!.hashCode) +
    (childSystemTasks.hashCode);

  @override
  String toString() => 'SystemTask[id=$id, createdAt=$createdAt, createdBy=$createdBy, createdByString=$createdByString, updatedAt=$updatedAt, type=$type, status=$status, startedAt=$startedAt, endedAt=$endedAt, associatedEntityId=$associatedEntityId, associatedEntityType=$associatedEntityType, ranByUserId=$ranByUserId, resultDescription=$resultDescription, childSystemTasks=$childSystemTasks]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'createdAt'] = this.createdAt;
      json[r'createdBy'] = this.createdBy;
      json[r'createdByString'] = this.createdByString;
      json[r'updatedAt'] = this.updatedAt;
    if (this.type != null) {
      json[r'type'] = this.type;
    } else {
      json[r'type'] = null;
    }
    if (this.status != null) {
      json[r'status'] = this.status;
    } else {
      json[r'status'] = null;
    }
    if (this.startedAt != null) {
      json[r'startedAt'] = this.startedAt;
    } else {
      json[r'startedAt'] = null;
    }
    if (this.endedAt != null) {
      json[r'endedAt'] = this.endedAt;
    } else {
      json[r'endedAt'] = null;
    }
    if (this.associatedEntityId != null) {
      json[r'associatedEntityId'] = this.associatedEntityId;
    } else {
      json[r'associatedEntityId'] = null;
    }
    if (this.associatedEntityType != null) {
      json[r'associatedEntityType'] = this.associatedEntityType;
    } else {
      json[r'associatedEntityType'] = null;
    }
    if (this.ranByUserId != null) {
      json[r'ranByUserId'] = this.ranByUserId;
    } else {
      json[r'ranByUserId'] = null;
    }
    if (this.resultDescription != null) {
      json[r'resultDescription'] = this.resultDescription;
    } else {
      json[r'resultDescription'] = null;
    }
      json[r'childSystemTasks'] = this.childSystemTasks;
    return json;
  }

  /// Returns a new [SystemTask] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static SystemTask? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "SystemTask[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "SystemTask[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return SystemTask(
        id: mapValueOfType<int>(json, r'id')!,
        createdAt: mapValueOfType<String>(json, r'createdAt')!,
        createdBy: mapValueOfType<int>(json, r'createdBy') ?? 0,
        createdByString: mapValueOfType<String>(json, r'createdByString') ?? '',
        updatedAt: mapValueOfType<String>(json, r'updatedAt') ?? '',
        type: SystemTaskType.fromJson(json[r'type']),
        status: SystemTaskStatus.fromJson(json[r'status']),
        startedAt: mapValueOfType<String>(json, r'startedAt'),
        endedAt: mapValueOfType<String>(json, r'endedAt'),
        associatedEntityId: mapValueOfType<int>(json, r'associatedEntityId'),
        associatedEntityType: AssociatedEntityType.fromJson(json[r'associatedEntityType']),
        ranByUserId: mapValueOfType<int>(json, r'ranByUserId'),
        resultDescription: mapValueOfType<String>(json, r'resultDescription'),
        childSystemTasks: SystemTask.listFromJson(json[r'childSystemTasks']) ?? const [],
      );
    }
    return null;
  }

  static List<SystemTask>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SystemTask>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SystemTask.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, SystemTask> mapFromJson(dynamic json) {
    final map = <String, SystemTask>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SystemTask.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of SystemTask-objects as value to a dart map
  static Map<String, List<SystemTask>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<SystemTask>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SystemTask.listFromJson(entry.value, growable: growable,);
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
  };
}

