//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Dashboard {
  /// Returns a new [Dashboard] instance.
  Dashboard({
    this.createdAt,
    this.createdBy,
    required this.id,
    required this.name,
    this.groupId,
    required this.userId,
    this.updatedAt,
    this.widgets = const [],
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

  int id;

  /// Dashboard name
  String name;

  /// Group foreign key
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? groupId;

  /// User foreign key
  int userId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? updatedAt;

  /// Widgets associated to dashboard
  List<Widget> widgets;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Dashboard &&
    other.createdAt == createdAt &&
    other.createdBy == createdBy &&
    other.id == id &&
    other.name == name &&
    other.groupId == groupId &&
    other.userId == userId &&
    other.updatedAt == updatedAt &&
    _deepEquality.equals(other.widgets, widgets);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (createdAt == null ? 0 : createdAt!.hashCode) +
    (createdBy == null ? 0 : createdBy!.hashCode) +
    (id.hashCode) +
    (name.hashCode) +
    (groupId == null ? 0 : groupId!.hashCode) +
    (userId.hashCode) +
    (updatedAt == null ? 0 : updatedAt!.hashCode) +
    (widgets.hashCode);

  @override
  String toString() => 'Dashboard[createdAt=$createdAt, createdBy=$createdBy, id=$id, name=$name, groupId=$groupId, userId=$userId, updatedAt=$updatedAt, widgets=$widgets]';

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
      json[r'id'] = this.id;
      json[r'name'] = this.name;
    if (this.groupId != null) {
      json[r'groupId'] = this.groupId;
    } else {
      json[r'groupId'] = null;
    }
      json[r'userId'] = this.userId;
    if (this.updatedAt != null) {
      json[r'updatedAt'] = this.updatedAt;
    } else {
      json[r'updatedAt'] = null;
    }
      json[r'widgets'] = this.widgets;
    return json;
  }

  /// Returns a new [Dashboard] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Dashboard? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "Dashboard[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "Dashboard[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return Dashboard(
        createdAt: mapValueOfType<String>(json, r'createdAt'),
        createdBy: mapValueOfType<int>(json, r'createdBy'),
        id: mapValueOfType<int>(json, r'id')!,
        name: mapValueOfType<String>(json, r'name')!,
        groupId: mapValueOfType<int>(json, r'groupId'),
        userId: mapValueOfType<int>(json, r'userId')!,
        updatedAt: mapValueOfType<String>(json, r'updatedAt'),
        widgets: Widget.listFromJson(json[r'widgets']),
      );
    }
    return null;
  }

  static List<Dashboard> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Dashboard>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Dashboard.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Dashboard> mapFromJson(dynamic json) {
    final map = <String, Dashboard>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Dashboard.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Dashboard-objects as value to a dart map
  static Map<String, List<Dashboard>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Dashboard>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Dashboard.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'name',
    'userId',
  };
}

