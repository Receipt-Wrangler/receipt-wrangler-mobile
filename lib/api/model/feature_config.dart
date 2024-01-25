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
    required this.aiPoweredReceipts,
    required this.enableLocalSignUp,
  });

  /// Whether AI powered receipts are enabled
  bool aiPoweredReceipts;

  /// Whether local sign up is enabled
  bool enableLocalSignUp;

  @override
  bool operator ==(Object other) => identical(this, other) || other is FeatureConfig &&
    other.aiPoweredReceipts == aiPoweredReceipts &&
    other.enableLocalSignUp == enableLocalSignUp;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (aiPoweredReceipts.hashCode) +
    (enableLocalSignUp.hashCode);

  @override
  String toString() => 'FeatureConfig[aiPoweredReceipts=$aiPoweredReceipts, enableLocalSignUp=$enableLocalSignUp]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'aiPoweredReceipts'] = this.aiPoweredReceipts;
      json[r'enableLocalSignUp'] = this.enableLocalSignUp;
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
        aiPoweredReceipts: mapValueOfType<bool>(json, r'aiPoweredReceipts')!,
        enableLocalSignUp: mapValueOfType<bool>(json, r'enableLocalSignUp')!,
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
    'aiPoweredReceipts',
    'enableLocalSignUp',
  };
}

