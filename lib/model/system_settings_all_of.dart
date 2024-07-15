//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class SystemSettingsAllOf {
  /// Returns a new [SystemSettingsAllOf] instance.
  SystemSettingsAllOf({
    this.enableLocalSignUp = false,
    this.currencyDisplay = '$',
    this.debugOcr = false,
    this.numWorkers = 1,
    this.emailPollingInterval = 1800,
    this.receiptProcessingSettingsId,
    this.fallbackReceiptProcessingSettingsId,
  });

  /// Whether local sign up is enabled
  bool enableLocalSignUp;

  /// Currency display
  String currencyDisplay;

  /// Debug OCR
  bool debugOcr;

  /// Number of workers to use
  int numWorkers;

  /// Email polling interval
  int emailPollingInterval;

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
  bool operator ==(Object other) => identical(this, other) || other is SystemSettingsAllOf &&
     other.enableLocalSignUp == enableLocalSignUp &&
     other.currencyDisplay == currencyDisplay &&
     other.debugOcr == debugOcr &&
     other.numWorkers == numWorkers &&
     other.emailPollingInterval == emailPollingInterval &&
     other.receiptProcessingSettingsId == receiptProcessingSettingsId &&
     other.fallbackReceiptProcessingSettingsId == fallbackReceiptProcessingSettingsId;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (enableLocalSignUp.hashCode) +
    (currencyDisplay.hashCode) +
    (debugOcr.hashCode) +
    (numWorkers.hashCode) +
    (emailPollingInterval.hashCode) +
    (receiptProcessingSettingsId == null ? 0 : receiptProcessingSettingsId!.hashCode) +
    (fallbackReceiptProcessingSettingsId == null ? 0 : fallbackReceiptProcessingSettingsId!.hashCode);

  @override
  String toString() => 'SystemSettingsAllOf[enableLocalSignUp=$enableLocalSignUp, currencyDisplay=$currencyDisplay, debugOcr=$debugOcr, numWorkers=$numWorkers, emailPollingInterval=$emailPollingInterval, receiptProcessingSettingsId=$receiptProcessingSettingsId, fallbackReceiptProcessingSettingsId=$fallbackReceiptProcessingSettingsId]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'enableLocalSignUp'] = this.enableLocalSignUp;
      json[r'currencyDisplay'] = this.currencyDisplay;
      json[r'debugOcr'] = this.debugOcr;
      json[r'numWorkers'] = this.numWorkers;
      json[r'emailPollingInterval'] = this.emailPollingInterval;
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

  /// Returns a new [SystemSettingsAllOf] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static SystemSettingsAllOf? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "SystemSettingsAllOf[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "SystemSettingsAllOf[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return SystemSettingsAllOf(
        enableLocalSignUp: mapValueOfType<bool>(json, r'enableLocalSignUp') ?? false,
        currencyDisplay: mapValueOfType<String>(json, r'currencyDisplay') ?? '$',
        debugOcr: mapValueOfType<bool>(json, r'debugOcr') ?? false,
        numWorkers: mapValueOfType<int>(json, r'numWorkers') ?? 1,
        emailPollingInterval: mapValueOfType<int>(json, r'emailPollingInterval') ?? 1800,
        receiptProcessingSettingsId: mapValueOfType<int>(json, r'receiptProcessingSettingsId'),
        fallbackReceiptProcessingSettingsId: mapValueOfType<int>(json, r'fallbackReceiptProcessingSettingsId'),
      );
    }
    return null;
  }

  static List<SystemSettingsAllOf>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SystemSettingsAllOf>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SystemSettingsAllOf.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, SystemSettingsAllOf> mapFromJson(dynamic json) {
    final map = <String, SystemSettingsAllOf>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SystemSettingsAllOf.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of SystemSettingsAllOf-objects as value to a dart map
  static Map<String, List<SystemSettingsAllOf>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<SystemSettingsAllOf>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SystemSettingsAllOf.listFromJson(entry.value, growable: growable,);
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

