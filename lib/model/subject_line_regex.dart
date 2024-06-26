//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class SubjectLineRegex {
  /// Returns a new [SubjectLineRegex] instance.
  SubjectLineRegex({
    required this.id,
    required this.groupSettingsId,
    required this.regex,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
  });

  /// Subject line regex id
  int id;

  /// Group settings foreign key
  int groupSettingsId;

  /// Regex to match subject line
  String regex;

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
  bool operator ==(Object other) => identical(this, other) || other is SubjectLineRegex &&
     other.id == id &&
     other.groupSettingsId == groupSettingsId &&
     other.regex == regex &&
     other.createdAt == createdAt &&
     other.createdBy == createdBy &&
     other.updatedAt == updatedAt;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (groupSettingsId.hashCode) +
    (regex.hashCode) +
    (createdAt == null ? 0 : createdAt!.hashCode) +
    (createdBy == null ? 0 : createdBy!.hashCode) +
    (updatedAt == null ? 0 : updatedAt!.hashCode);

  @override
  String toString() => 'SubjectLineRegex[id=$id, groupSettingsId=$groupSettingsId, regex=$regex, createdAt=$createdAt, createdBy=$createdBy, updatedAt=$updatedAt]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'groupSettingsId'] = this.groupSettingsId;
      json[r'regex'] = this.regex;
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

  /// Returns a new [SubjectLineRegex] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static SubjectLineRegex? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "SubjectLineRegex[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "SubjectLineRegex[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return SubjectLineRegex(
        id: mapValueOfType<int>(json, r'id')!,
        groupSettingsId: mapValueOfType<int>(json, r'groupSettingsId')!,
        regex: mapValueOfType<String>(json, r'regex')!,
        createdAt: mapValueOfType<String>(json, r'createdAt'),
        createdBy: mapValueOfType<int>(json, r'createdBy'),
        updatedAt: mapValueOfType<String>(json, r'updatedAt'),
      );
    }
    return null;
  }

  static List<SubjectLineRegex>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SubjectLineRegex>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SubjectLineRegex.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, SubjectLineRegex> mapFromJson(dynamic json) {
    final map = <String, SubjectLineRegex>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SubjectLineRegex.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of SubjectLineRegex-objects as value to a dart map
  static Map<String, List<SubjectLineRegex>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<SubjectLineRegex>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SubjectLineRegex.listFromJson(entry.value, growable: growable,);
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
    'groupSettingsId',
    'regex',
  };
}

