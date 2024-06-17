//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Prompt {
  /// Returns a new [Prompt] instance.
  Prompt({
    required this.id,
    required this.createdAt,
    this.createdBy = 0,
    this.createdByString = '',
    this.updatedAt = '',
    required this.name,
    this.description,
    required this.prompt,
  });

  int id;

  String createdAt;

  int createdBy;

  /// Created by entity's name
  String createdByString;

  String updatedAt;

  /// Prompt name
  String name;

  /// Prompt description
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? description;

  /// Prompt text
  String prompt;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Prompt &&
     other.id == id &&
     other.createdAt == createdAt &&
     other.createdBy == createdBy &&
     other.createdByString == createdByString &&
     other.updatedAt == updatedAt &&
     other.name == name &&
     other.description == description &&
     other.prompt == prompt;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (createdAt.hashCode) +
    (createdBy.hashCode) +
    (createdByString.hashCode) +
    (updatedAt.hashCode) +
    (name.hashCode) +
    (description == null ? 0 : description!.hashCode) +
    (prompt.hashCode);

  @override
  String toString() => 'Prompt[id=$id, createdAt=$createdAt, createdBy=$createdBy, createdByString=$createdByString, updatedAt=$updatedAt, name=$name, description=$description, prompt=$prompt]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'createdAt'] = this.createdAt;
      json[r'createdBy'] = this.createdBy;
      json[r'createdByString'] = this.createdByString;
      json[r'updatedAt'] = this.updatedAt;
      json[r'name'] = this.name;
    if (this.description != null) {
      json[r'description'] = this.description;
    } else {
      json[r'description'] = null;
    }
      json[r'prompt'] = this.prompt;
    return json;
  }

  /// Returns a new [Prompt] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Prompt? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "Prompt[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "Prompt[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return Prompt(
        id: mapValueOfType<int>(json, r'id')!,
        createdAt: mapValueOfType<String>(json, r'createdAt')!,
        createdBy: mapValueOfType<int>(json, r'createdBy') ?? 0,
        createdByString: mapValueOfType<String>(json, r'createdByString') ?? '',
        updatedAt: mapValueOfType<String>(json, r'updatedAt') ?? '',
        name: mapValueOfType<String>(json, r'name')!,
        description: mapValueOfType<String>(json, r'description'),
        prompt: mapValueOfType<String>(json, r'prompt')!,
      );
    }
    return null;
  }

  static List<Prompt>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Prompt>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Prompt.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Prompt> mapFromJson(dynamic json) {
    final map = <String, Prompt>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Prompt.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Prompt-objects as value to a dart map
  static Map<String, List<Prompt>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Prompt>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Prompt.listFromJson(entry.value, growable: growable,);
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
    'name',
    'prompt',
  };
}

