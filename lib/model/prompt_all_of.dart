//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PromptAllOf {
  /// Returns a new [PromptAllOf] instance.
  PromptAllOf({
    required this.name,
    this.description,
    required this.prompt,
  });

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
  bool operator ==(Object other) => identical(this, other) || other is PromptAllOf &&
     other.name == name &&
     other.description == description &&
     other.prompt == prompt;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (name.hashCode) +
    (description == null ? 0 : description!.hashCode) +
    (prompt.hashCode);

  @override
  String toString() => 'PromptAllOf[name=$name, description=$description, prompt=$prompt]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'name'] = this.name;
    if (this.description != null) {
      json[r'description'] = this.description;
    } else {
      json[r'description'] = null;
    }
      json[r'prompt'] = this.prompt;
    return json;
  }

  /// Returns a new [PromptAllOf] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PromptAllOf? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "PromptAllOf[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "PromptAllOf[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return PromptAllOf(
        name: mapValueOfType<String>(json, r'name')!,
        description: mapValueOfType<String>(json, r'description'),
        prompt: mapValueOfType<String>(json, r'prompt')!,
      );
    }
    return null;
  }

  static List<PromptAllOf>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <PromptAllOf>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PromptAllOf.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PromptAllOf> mapFromJson(dynamic json) {
    final map = <String, PromptAllOf>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PromptAllOf.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PromptAllOf-objects as value to a dart map
  static Map<String, List<PromptAllOf>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<PromptAllOf>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PromptAllOf.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'name',
    'prompt',
  };
}
