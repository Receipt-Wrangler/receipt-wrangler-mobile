//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class UpsertSystemSettingsCommand {
  /// Returns a new [UpsertSystemSettingsCommand] instance.
  UpsertSystemSettingsCommand({
    this.enableLocalSignUp,
    this.debugOcr,
    this.numWorkers = 1,
    this.emailPollingInterval,
    this.receiptProcessingSettingsId,
    this.fallbackReceiptProcessingSettingsId,
  });

  /// Whether local sign up is enabled
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? enableLocalSignUp;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? debugOcr;

  /// Number of workers to use
  int numWorkers;

  /// Email polling interval
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? emailPollingInterval;

  /// Receipt processing settings foreign key
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? receiptProcessingSettingsId;

  /// Fallback receipt processing settings foreign key
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? fallbackReceiptProcessingSettingsId;

  @override
  bool operator ==(Object other) => identical(this, other) || other is UpsertSystemSettingsCommand &&
     other.enableLocalSignUp == enableLocalSignUp &&
     other.debugOcr == debugOcr &&
     other.numWorkers == numWorkers &&
     other.emailPollingInterval == emailPollingInterval &&
     other.receiptProcessingSettingsId == receiptProcessingSettingsId &&
     other.fallbackReceiptProcessingSettingsId == fallbackReceiptProcessingSettingsId;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (enableLocalSignUp == null ? 0 : enableLocalSignUp!.hashCode) +
    (debugOcr == null ? 0 : debugOcr!.hashCode) +
    (numWorkers.hashCode) +
    (emailPollingInterval == null ? 0 : emailPollingInterval!.hashCode) +
    (receiptProcessingSettingsId == null ? 0 : receiptProcessingSettingsId!.hashCode) +
    (fallbackReceiptProcessingSettingsId == null ? 0 : fallbackReceiptProcessingSettingsId!.hashCode);

  @override
  String toString() => 'UpsertSystemSettingsCommand[enableLocalSignUp=$enableLocalSignUp, debugOcr=$debugOcr, numWorkers=$numWorkers, emailPollingInterval=$emailPollingInterval, receiptProcessingSettingsId=$receiptProcessingSettingsId, fallbackReceiptProcessingSettingsId=$fallbackReceiptProcessingSettingsId]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.enableLocalSignUp != null) {
      json[r'enableLocalSignUp'] = this.enableLocalSignUp;
    } else {
      json[r'enableLocalSignUp'] = null;
    }
    if (this.debugOcr != null) {
      json[r'debugOcr'] = this.debugOcr;
    } else {
      json[r'debugOcr'] = null;
    }
      json[r'numWorkers'] = this.numWorkers;
    if (this.emailPollingInterval != null) {
      json[r'emailPollingInterval'] = this.emailPollingInterval;
    } else {
      json[r'emailPollingInterval'] = null;
    }
    if (this.receiptProcessingSettingsId != null) {
      json[r'receiptProcessingSettingsId'] = this.receiptProcessingSettingsId;
    } else {
      json[r'receiptProcessingSettingsId'] = null;
    }
    if (this.fallbackReceiptProcessingSettingsId != null) {
      json[r'fallbackReceiptProcessingSettingsId'] = this.fallbackReceiptProcessingSettingsId;
    } else {
      json[r'fallbackReceiptProcessingSettingsId'] = null;
    }
    return json;
  }

  /// Returns a new [UpsertSystemSettingsCommand] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UpsertSystemSettingsCommand? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "UpsertSystemSettingsCommand[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "UpsertSystemSettingsCommand[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return UpsertSystemSettingsCommand(
        enableLocalSignUp: mapValueOfType<bool>(json, r'enableLocalSignUp'),
        debugOcr: mapValueOfType<bool>(json, r'debugOcr'),
        numWorkers: mapValueOfType<int>(json, r'numWorkers') ?? 1,
        emailPollingInterval: mapValueOfType<int>(json, r'emailPollingInterval'),
        receiptProcessingSettingsId: mapValueOfType<int>(json, r'receiptProcessingSettingsId'),
        fallbackReceiptProcessingSettingsId: mapValueOfType<int>(json, r'fallbackReceiptProcessingSettingsId'),
      );
    }
    return null;
  }

  static List<UpsertSystemSettingsCommand>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UpsertSystemSettingsCommand>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UpsertSystemSettingsCommand.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UpsertSystemSettingsCommand> mapFromJson(dynamic json) {
    final map = <String, UpsertSystemSettingsCommand>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UpsertSystemSettingsCommand.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UpsertSystemSettingsCommand-objects as value to a dart map
  static Map<String, List<UpsertSystemSettingsCommand>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<UpsertSystemSettingsCommand>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UpsertSystemSettingsCommand.listFromJson(entry.value, growable: growable,);
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

