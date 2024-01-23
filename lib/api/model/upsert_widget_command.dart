//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class UpsertWidgetCommand {
  /// Returns a new [UpsertWidgetCommand] instance.
  UpsertWidgetCommand({
    this.name,
    required this.widgetType,
    this.configuration = const {},
  });

  /// Widget name
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? name;

  /// Type of widget
  UpsertWidgetCommandWidgetTypeEnum widgetType;

  /// Configuration of widget
  Map<String, Object> configuration;

  @override
  bool operator ==(Object other) => identical(this, other) || other is UpsertWidgetCommand &&
    other.name == name &&
    other.widgetType == widgetType &&
    _deepEquality.equals(other.configuration, configuration);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (name == null ? 0 : name!.hashCode) +
    (widgetType.hashCode) +
    (configuration.hashCode);

  @override
  String toString() => 'UpsertWidgetCommand[name=$name, widgetType=$widgetType, configuration=$configuration]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.name != null) {
      json[r'name'] = this.name;
    } else {
      json[r'name'] = null;
    }
      json[r'widgetType'] = this.widgetType;
      json[r'configuration'] = this.configuration;
    return json;
  }

  /// Returns a new [UpsertWidgetCommand] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UpsertWidgetCommand? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "UpsertWidgetCommand[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "UpsertWidgetCommand[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return UpsertWidgetCommand(
        name: mapValueOfType<String>(json, r'name'),
        widgetType: UpsertWidgetCommandWidgetTypeEnum.fromJson(json[r'widgetType'])!,
        configuration: mapCastOfType<String, Object>(json, r'configuration') ?? const {},
      );
    }
    return null;
  }

  static List<UpsertWidgetCommand> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UpsertWidgetCommand>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UpsertWidgetCommand.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UpsertWidgetCommand> mapFromJson(dynamic json) {
    final map = <String, UpsertWidgetCommand>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UpsertWidgetCommand.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UpsertWidgetCommand-objects as value to a dart map
  static Map<String, List<UpsertWidgetCommand>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<UpsertWidgetCommand>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = UpsertWidgetCommand.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'widgetType',
  };
}

/// Type of widget
class UpsertWidgetCommandWidgetTypeEnum {
  /// Instantiate a new enum with the provided [value].
  const UpsertWidgetCommandWidgetTypeEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const GROUP_SUMMARY = UpsertWidgetCommandWidgetTypeEnum._(r'GROUP_SUMMARY');
  static const FILTERED_RECEIPTS = UpsertWidgetCommandWidgetTypeEnum._(r'FILTERED_RECEIPTS');

  /// List of all possible values in this [enum][UpsertWidgetCommandWidgetTypeEnum].
  static const values = <UpsertWidgetCommandWidgetTypeEnum>[
    GROUP_SUMMARY,
    FILTERED_RECEIPTS,
  ];

  static UpsertWidgetCommandWidgetTypeEnum? fromJson(dynamic value) => UpsertWidgetCommandWidgetTypeEnumTypeTransformer().decode(value);

  static List<UpsertWidgetCommandWidgetTypeEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UpsertWidgetCommandWidgetTypeEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UpsertWidgetCommandWidgetTypeEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [UpsertWidgetCommandWidgetTypeEnum] to String,
/// and [decode] dynamic data back to [UpsertWidgetCommandWidgetTypeEnum].
class UpsertWidgetCommandWidgetTypeEnumTypeTransformer {
  factory UpsertWidgetCommandWidgetTypeEnumTypeTransformer() => _instance ??= const UpsertWidgetCommandWidgetTypeEnumTypeTransformer._();

  const UpsertWidgetCommandWidgetTypeEnumTypeTransformer._();

  String encode(UpsertWidgetCommandWidgetTypeEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a UpsertWidgetCommandWidgetTypeEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  UpsertWidgetCommandWidgetTypeEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'GROUP_SUMMARY': return UpsertWidgetCommandWidgetTypeEnum.GROUP_SUMMARY;
        case r'FILTERED_RECEIPTS': return UpsertWidgetCommandWidgetTypeEnum.FILTERED_RECEIPTS;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [UpsertWidgetCommandWidgetTypeEnumTypeTransformer] instance.
  static UpsertWidgetCommandWidgetTypeEnumTypeTransformer? _instance;
}


