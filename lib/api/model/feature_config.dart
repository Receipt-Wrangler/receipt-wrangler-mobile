//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class FeatureConfig {
  /// Returns a new [FeatureConfig] instance.
  FeatureConfig({
    this.aiPoweredReceipts,
    this.enableLocalSignUp,
  });

  /// Whether AI powered receipts are enabled
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? aiPoweredReceipts;

  /// Whether local sign up is enabled
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? enableLocalSignUp;

  @override
  bool operator ==(Object other) => identical(this, other) || other is FeatureConfig &&
    other.aiPoweredReceipts == aiPoweredReceipts &&
    other.enableLocalSignUp == enableLocalSignUp;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (aiPoweredReceipts == null ? 0 : aiPoweredReceipts!.hashCode) +
    (enableLocalSignUp == null ? 0 : enableLocalSignUp!.hashCode);

  @override
  String toString() => 'FeatureConfig[aiPoweredReceipts=$aiPoweredReceipts, enableLocalSignUp=$enableLocalSignUp]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.aiPoweredReceipts != null) {
      json[r'AiPoweredReceipts'] = this.aiPoweredReceipts;
    } else {
      json[r'AiPoweredReceipts'] = null;
    }
    if (this.enableLocalSignUp != null) {
      json[r'EnableLocalSignUp'] = this.enableLocalSignUp;
    } else {
      json[r'EnableLocalSignUp'] = null;
    }
    return json;
  }

  /// Returns a new [FeatureConfig] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static FeatureConfig? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "FeatureConfig[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "FeatureConfig[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return FeatureConfig(
        aiPoweredReceipts: mapValueOfType<bool>(json, r'AiPoweredReceipts'),
        enableLocalSignUp: mapValueOfType<bool>(json, r'EnableLocalSignUp'),
      );
    }
    return null;
  }

  static List<FeatureConfig> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <FeatureConfig>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = FeatureConfig.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, FeatureConfig> mapFromJson(dynamic json) {
    final map = <String, FeatureConfig>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = FeatureConfig.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of FeatureConfig-objects as value to a dart map
  static Map<String, List<FeatureConfig>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<FeatureConfig>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = FeatureConfig.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

