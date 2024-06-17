//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class CheckReceiptProcessingSettingsConnectivityCommand {
  /// Returns a new [CheckReceiptProcessingSettingsConnectivityCommand] instance.
  CheckReceiptProcessingSettingsConnectivityCommand({
    this.id,
    this.name,
    this.aiType,
    this.url,
    this.key,
    this.model,
    this.numWorkers,
    this.ocrEngine,
    this.promptId,
  });

  /// Receipt processing settings id
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? id;

  /// Name of the settings
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? name;

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

  /// Number of workers to use
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? numWorkers;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  OcrEngine? ocrEngine;

  /// Prompt foreign key
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? promptId;

  @override
  bool operator ==(Object other) => identical(this, other) || other is CheckReceiptProcessingSettingsConnectivityCommand &&
     other.id == id &&
     other.name == name &&
     other.aiType == aiType &&
     other.url == url &&
     other.key == key &&
     other.model == model &&
     other.numWorkers == numWorkers &&
     other.ocrEngine == ocrEngine &&
     other.promptId == promptId;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id == null ? 0 : id!.hashCode) +
    (name == null ? 0 : name!.hashCode) +
    (aiType == null ? 0 : aiType!.hashCode) +
    (url == null ? 0 : url!.hashCode) +
    (key == null ? 0 : key!.hashCode) +
    (model == null ? 0 : model!.hashCode) +
    (numWorkers == null ? 0 : numWorkers!.hashCode) +
    (ocrEngine == null ? 0 : ocrEngine!.hashCode) +
    (promptId == null ? 0 : promptId!.hashCode);

  @override
  String toString() => 'CheckReceiptProcessingSettingsConnectivityCommand[id=$id, name=$name, aiType=$aiType, url=$url, key=$key, model=$model, numWorkers=$numWorkers, ocrEngine=$ocrEngine, promptId=$promptId]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.id != null) {
      json[r'id'] = this.id;
    } else {
      json[r'id'] = null;
    }
    if (this.name != null) {
      json[r'name'] = this.name;
    } else {
      json[r'name'] = null;
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
    if (this.numWorkers != null) {
      json[r'numWorkers'] = this.numWorkers;
    } else {
      json[r'numWorkers'] = null;
    }
    if (this.ocrEngine != null) {
      json[r'ocrEngine'] = this.ocrEngine;
    } else {
      json[r'ocrEngine'] = null;
    }
    if (this.promptId != null) {
      json[r'promptId'] = this.promptId;
    } else {
      json[r'promptId'] = null;
    }
    return json;
  }

  /// Returns a new [CheckReceiptProcessingSettingsConnectivityCommand] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static CheckReceiptProcessingSettingsConnectivityCommand? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "CheckReceiptProcessingSettingsConnectivityCommand[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "CheckReceiptProcessingSettingsConnectivityCommand[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return CheckReceiptProcessingSettingsConnectivityCommand(
        id: mapValueOfType<int>(json, r'id'),
        name: mapValueOfType<String>(json, r'name'),
        aiType: AiType.fromJson(json[r'aiType']),
        url: mapValueOfType<String>(json, r'url'),
        key: mapValueOfType<String>(json, r'key'),
        model: mapValueOfType<String>(json, r'model'),
        numWorkers: mapValueOfType<int>(json, r'numWorkers'),
        ocrEngine: OcrEngine.fromJson(json[r'ocrEngine']),
        promptId: mapValueOfType<int>(json, r'promptId'),
      );
    }
    return null;
  }

  static List<CheckReceiptProcessingSettingsConnectivityCommand>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CheckReceiptProcessingSettingsConnectivityCommand>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CheckReceiptProcessingSettingsConnectivityCommand.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, CheckReceiptProcessingSettingsConnectivityCommand> mapFromJson(dynamic json) {
    final map = <String, CheckReceiptProcessingSettingsConnectivityCommand>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CheckReceiptProcessingSettingsConnectivityCommand.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of CheckReceiptProcessingSettingsConnectivityCommand-objects as value to a dart map
  static Map<String, List<CheckReceiptProcessingSettingsConnectivityCommand>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<CheckReceiptProcessingSettingsConnectivityCommand>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CheckReceiptProcessingSettingsConnectivityCommand.listFromJson(entry.value, growable: growable,);
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

