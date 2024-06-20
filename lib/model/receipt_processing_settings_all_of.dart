//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ReceiptProcessingSettingsAllOf {
  /// Returns a new [ReceiptProcessingSettingsAllOf] instance.
  ReceiptProcessingSettingsAllOf({
    this.name,
    this.description,
    this.aiType,
    this.url,
    this.key,
    this.model,
    this.ocrEngine,
    this.prompt,
    this.promptId,
  });

  /// Name of the settings
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? name;

  /// Description of the settings
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? description;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  AiType? aiType;

  /// URL for custom endpoints
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? url;

  /// Key for endpoints that require authentication
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? key;

  /// LLM model
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? model;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  OcrEngine? ocrEngine;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  Prompt? prompt;

  /// Prompt foreign key
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? promptId;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ReceiptProcessingSettingsAllOf &&
     other.name == name &&
     other.description == description &&
     other.aiType == aiType &&
     other.url == url &&
     other.key == key &&
     other.model == model &&
     other.ocrEngine == ocrEngine &&
     other.prompt == prompt &&
     other.promptId == promptId;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (name == null ? 0 : name!.hashCode) +
    (description == null ? 0 : description!.hashCode) +
    (aiType == null ? 0 : aiType!.hashCode) +
    (url == null ? 0 : url!.hashCode) +
    (key == null ? 0 : key!.hashCode) +
    (model == null ? 0 : model!.hashCode) +
    (ocrEngine == null ? 0 : ocrEngine!.hashCode) +
    (prompt == null ? 0 : prompt!.hashCode) +
    (promptId == null ? 0 : promptId!.hashCode);

  @override
  String toString() => 'ReceiptProcessingSettingsAllOf[name=$name, description=$description, aiType=$aiType, url=$url, key=$key, model=$model, ocrEngine=$ocrEngine, prompt=$prompt, promptId=$promptId]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.name != null) {
      json[r'name'] = this.name;
    } else {
      json[r'name'] = null;
    }
    if (this.description != null) {
      json[r'description'] = this.description;
    } else {
      json[r'description'] = null;
    }
    if (this.aiType != null) {
      json[r'aiType'] = this.aiType;
    } else {
      json[r'aiType'] = null;
    }
    if (this.url != null) {
      json[r'url'] = this.url;
    } else {
      json[r'url'] = null;
    }
    if (this.key != null) {
      json[r'key'] = this.key;
    } else {
      json[r'key'] = null;
    }
    if (this.model != null) {
      json[r'model'] = this.model;
    } else {
      json[r'model'] = null;
    }
    if (this.ocrEngine != null) {
      json[r'ocrEngine'] = this.ocrEngine;
    } else {
      json[r'ocrEngine'] = null;
    }
    if (this.prompt != null) {
      json[r'prompt'] = this.prompt;
    } else {
      json[r'prompt'] = null;
    }
    if (this.promptId != null) {
      json[r'promptId'] = this.promptId;
    } else {
      json[r'promptId'] = null;
    }
    return json;
  }

  /// Returns a new [ReceiptProcessingSettingsAllOf] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ReceiptProcessingSettingsAllOf? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ReceiptProcessingSettingsAllOf[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ReceiptProcessingSettingsAllOf[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ReceiptProcessingSettingsAllOf(
        name: mapValueOfType<String>(json, r'name'),
        description: mapValueOfType<String>(json, r'description'),
        aiType: AiType.fromJson(json[r'aiType']),
        url: mapValueOfType<String>(json, r'url'),
        key: mapValueOfType<String>(json, r'key'),
        model: mapValueOfType<String>(json, r'model'),
        ocrEngine: OcrEngine.fromJson(json[r'ocrEngine']),
        prompt: Prompt.fromJson(json[r'prompt']),
        promptId: mapValueOfType<int>(json, r'promptId'),
      );
    }
    return null;
  }

  static List<ReceiptProcessingSettingsAllOf>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ReceiptProcessingSettingsAllOf>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ReceiptProcessingSettingsAllOf.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ReceiptProcessingSettingsAllOf> mapFromJson(dynamic json) {
    final map = <String, ReceiptProcessingSettingsAllOf>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ReceiptProcessingSettingsAllOf.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ReceiptProcessingSettingsAllOf-objects as value to a dart map
  static Map<String, List<ReceiptProcessingSettingsAllOf>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ReceiptProcessingSettingsAllOf>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ReceiptProcessingSettingsAllOf.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

