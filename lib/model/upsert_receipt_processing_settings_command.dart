//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class UpsertReceiptProcessingSettingsCommand {
  /// Returns a new [UpsertReceiptProcessingSettingsCommand] instance.
  UpsertReceiptProcessingSettingsCommand({
    required this.name,
    this.description,
    required this.aiType,
    this.url,
    this.key,
    this.model,
    this.isVisionModel,
    required this.ocrEngine,
    required this.promptId,
  });

  /// Name of the settings
  String name;

  /// Description of the settings
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? description;

  AiType aiType;

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

  /// Is vision model
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? isVisionModel;

  OcrEngine ocrEngine;

  /// Prompt foreign key
  int promptId;

  @override
  bool operator ==(Object other) => identical(this, other) || other is UpsertReceiptProcessingSettingsCommand &&
     other.name == name &&
     other.description == description &&
     other.aiType == aiType &&
     other.url == url &&
     other.key == key &&
     other.model == model &&
     other.isVisionModel == isVisionModel &&
     other.ocrEngine == ocrEngine &&
     other.promptId == promptId;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (name.hashCode) +
    (description == null ? 0 : description!.hashCode) +
    (aiType.hashCode) +
    (url == null ? 0 : url!.hashCode) +
    (key == null ? 0 : key!.hashCode) +
    (model == null ? 0 : model!.hashCode) +
    (isVisionModel == null ? 0 : isVisionModel!.hashCode) +
    (ocrEngine.hashCode) +
    (promptId.hashCode);

  @override
  String toString() => 'UpsertReceiptProcessingSettingsCommand[name=$name, description=$description, aiType=$aiType, url=$url, key=$key, model=$model, isVisionModel=$isVisionModel, ocrEngine=$ocrEngine, promptId=$promptId]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'name'] = this.name;
    if (this.description != null) {
      json[r'description'] = this.description;
    } else {
      json[r'description'] = null;
    }
      json[r'aiType'] = this.aiType;
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
    if (this.isVisionModel != null) {
      json[r'isVisionModel'] = this.isVisionModel;
    } else {
      json[r'isVisionModel'] = null;
    }
      json[r'ocrEngine'] = this.ocrEngine;
      json[r'promptId'] = this.promptId;
    return json;
  }

  /// Returns a new [UpsertReceiptProcessingSettingsCommand] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UpsertReceiptProcessingSettingsCommand? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "UpsertReceiptProcessingSettingsCommand[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "UpsertReceiptProcessingSettingsCommand[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return UpsertReceiptProcessingSettingsCommand(
        name: mapValueOfType<String>(json, r'name')!,
        description: mapValueOfType<String>(json, r'description'),
        aiType: AiType.fromJson(json[r'aiType'])!,
        url: mapValueOfType<String>(json, r'url'),
        key: mapValueOfType<String>(json, r'key'),
        model: mapValueOfType<String>(json, r'model'),
        isVisionModel: mapValueOfType<bool>(json, r'isVisionModel'),
        ocrEngine: OcrEngine.fromJson(json[r'ocrEngine'])!,
        promptId: mapValueOfType<int>(json, r'promptId')!,
      );
    }
    return null;
  }

  static List<UpsertReceiptProcessingSettingsCommand>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UpsertReceiptProcessingSettingsCommand>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UpsertReceiptProcessingSettingsCommand.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UpsertReceiptProcessingSettingsCommand> mapFromJson(dynamic json) {
    final map = <String, UpsertReceiptProcessingSettingsCommand>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UpsertReceiptProcessingSettingsCommand.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UpsertReceiptProcessingSettingsCommand-objects as value to a dart map
  static Map<String, List<UpsertReceiptProcessingSettingsCommand>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<UpsertReceiptProcessingSettingsCommand>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UpsertReceiptProcessingSettingsCommand.listFromJson(entry.value, growable: growable,);
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
    'aiType',
    'ocrEngine',
    'promptId',
  };
}

