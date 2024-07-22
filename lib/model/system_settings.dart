//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class SystemSettings {
  /// Returns a new [SystemSettings] instance.
  SystemSettings({
    required this.id,
    required this.createdAt,
    this.createdBy = 0,
    this.createdByString = '',
    this.updatedAt = '',
    this.enableLocalSignUp = false,
    this.currencyDisplay = '\$',
    this.debugOcr = false,
    this.numWorkers = 1,
    this.emailPollingInterval = 1800,
    this.receiptProcessingSettingsId,
    this.fallbackReceiptProcessingSettingsId,
  });

  int id;

  String createdAt;

  int createdBy;

  /// Created by entity's name
  String createdByString;

  String updatedAt;

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
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SystemSettings &&
          other.id == id &&
          other.createdAt == createdAt &&
          other.createdBy == createdBy &&
          other.createdByString == createdByString &&
          other.updatedAt == updatedAt &&
          other.enableLocalSignUp == enableLocalSignUp &&
          other.currencyDisplay == currencyDisplay &&
          other.debugOcr == debugOcr &&
          other.numWorkers == numWorkers &&
          other.emailPollingInterval == emailPollingInterval &&
          other.receiptProcessingSettingsId == receiptProcessingSettingsId &&
          other.fallbackReceiptProcessingSettingsId ==
              fallbackReceiptProcessingSettingsId;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (id.hashCode) +
      (createdAt.hashCode) +
      (createdBy.hashCode) +
      (createdByString.hashCode) +
      (updatedAt.hashCode) +
      (enableLocalSignUp.hashCode) +
      (currencyDisplay.hashCode) +
      (debugOcr.hashCode) +
      (numWorkers.hashCode) +
      (emailPollingInterval.hashCode) +
      (receiptProcessingSettingsId == null
          ? 0
          : receiptProcessingSettingsId!.hashCode) +
      (fallbackReceiptProcessingSettingsId == null
          ? 0
          : fallbackReceiptProcessingSettingsId!.hashCode);

  @override
  String toString() =>
      'SystemSettings[id=$id, createdAt=$createdAt, createdBy=$createdBy, createdByString=$createdByString, updatedAt=$updatedAt, enableLocalSignUp=$enableLocalSignUp, currencyDisplay=$currencyDisplay, debugOcr=$debugOcr, numWorkers=$numWorkers, emailPollingInterval=$emailPollingInterval, receiptProcessingSettingsId=$receiptProcessingSettingsId, fallbackReceiptProcessingSettingsId=$fallbackReceiptProcessingSettingsId]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'id'] = this.id;
    json[r'createdAt'] = this.createdAt;
    json[r'createdBy'] = this.createdBy;
    json[r'createdByString'] = this.createdByString;
    json[r'updatedAt'] = this.updatedAt;
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
      json[r'fallbackReceiptProcessingSettingsId'] =
          this.fallbackReceiptProcessingSettingsId;
    } else {
      json[r'fallbackReceiptProcessingSettingsId'] = null;
    }
    return json;
  }

  /// Returns a new [SystemSettings] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static SystemSettings? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "SystemSettings[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "SystemSettings[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return SystemSettings(
        id: mapValueOfType<int>(json, r'id')!,
        createdAt: mapValueOfType<String>(json, r'createdAt')!,
        createdBy: mapValueOfType<int>(json, r'createdBy') ?? 0,
        createdByString: mapValueOfType<String>(json, r'createdByString') ?? '',
        updatedAt: mapValueOfType<String>(json, r'updatedAt') ?? '',
        enableLocalSignUp:
            mapValueOfType<bool>(json, r'enableLocalSignUp') ?? false,
        currencyDisplay:
            mapValueOfType<String>(json, r'currencyDisplay') ?? '\$',
        debugOcr: mapValueOfType<bool>(json, r'debugOcr') ?? false,
        numWorkers: mapValueOfType<int>(json, r'numWorkers') ?? 1,
        emailPollingInterval:
            mapValueOfType<int>(json, r'emailPollingInterval') ?? 1800,
        receiptProcessingSettingsId:
            mapValueOfType<int>(json, r'receiptProcessingSettingsId'),
        fallbackReceiptProcessingSettingsId:
            mapValueOfType<int>(json, r'fallbackReceiptProcessingSettingsId'),
      );
    }
    return null;
  }

  static List<SystemSettings>? listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <SystemSettings>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SystemSettings.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, SystemSettings> mapFromJson(dynamic json) {
    final map = <String, SystemSettings>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SystemSettings.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of SystemSettings-objects as value to a dart map
  static Map<String, List<SystemSettings>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<SystemSettings>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SystemSettings.listFromJson(
          entry.value,
          growable: growable,
        );
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
