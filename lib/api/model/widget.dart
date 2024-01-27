//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Widget {
  /// Returns a new [Widget] instance.
  Widget({
    this.createdAt,
    this.createdBy,
    required this.id,
    this.name,
    required this.dashboardId,
    this.updatedAt,
    this.widgetType,
    this.configuration = const {},
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? createdAt;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? createdBy;

  int id;

  /// Widget name
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? name;

  /// Dashboard foreign key
  int dashboardId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? updatedAt;

  /// Type of widget
  WidgetWidgetTypeEnum? widgetType;

  /// Configuration of widget
  Map<String, Object> configuration;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Widget &&
    other.createdAt == createdAt &&
    other.createdBy == createdBy &&
    other.id == id &&
    other.name == name &&
    other.dashboardId == dashboardId &&
    other.updatedAt == updatedAt &&
    other.widgetType == widgetType &&
    _deepEquality.equals(other.configuration, configuration);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (createdAt == null ? 0 : createdAt!.hashCode) +
    (createdBy == null ? 0 : createdBy!.hashCode) +
    (id.hashCode) +
    (name == null ? 0 : name!.hashCode) +
    (dashboardId.hashCode) +
    (updatedAt == null ? 0 : updatedAt!.hashCode) +
    (widgetType == null ? 0 : widgetType!.hashCode) +
    (configuration.hashCode);

  @override
  String toString() => 'Widget[createdAt=$createdAt, createdBy=$createdBy, id=$id, name=$name, dashboardId=$dashboardId, updatedAt=$updatedAt, widgetType=$widgetType, configuration=$configuration]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.createdAt != null) {
      json[r'createdAt'] = this.createdAt;
    } else {
      json[r'createdAt'] = null;
    }
    if (this.createdBy != null) {
      json[r'createdBy'] = this.createdBy;
    } else {
      json[r'createdBy'] = null;
    }
      json[r'id'] = this.id;
    if (this.name != null) {
      json[r'name'] = this.name;
    } else {
      json[r'name'] = null;
    }
      json[r'dashboardId'] = this.dashboardId;
    if (this.updatedAt != null) {
      json[r'updatedAt'] = this.updatedAt;
    } else {
      json[r'updatedAt'] = null;
    }
    if (this.widgetType != null) {
      json[r'widgetType'] = this.widgetType;
    } else {
      json[r'widgetType'] = null;
    }
      json[r'configuration'] = this.configuration;
    return json;
  }

  /// Returns a new [Widget] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Widget? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "Widget[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "Widget[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return Widget(
        createdAt: mapValueOfType<String>(json, r'createdAt'),
        createdBy: mapValueOfType<int>(json, r'createdBy'),
        id: mapValueOfType<int>(json, r'id')!,
        name: mapValueOfType<String>(json, r'name'),
        dashboardId: mapValueOfType<int>(json, r'dashboardId')!,
        updatedAt: mapValueOfType<String>(json, r'updatedAt'),
        widgetType: WidgetWidgetTypeEnum.fromJson(json[r'widgetType']),
        configuration: mapCastOfType<String, Object>(json, r'configuration') ?? const {},
      );
    }
    return null;
  }

  static List<Widget> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Widget>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Widget.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Widget> mapFromJson(dynamic json) {
    final map = <String, Widget>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Widget.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Widget-objects as value to a dart map
  static Map<String, List<Widget>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Widget>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Widget.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'dashboardId',
  };
}

/// Type of widget
class WidgetWidgetTypeEnum {
  /// Instantiate a new enum with the provided [value].
  const WidgetWidgetTypeEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const GROUP_SUMMARY = WidgetWidgetTypeEnum._(r'GROUP_SUMMARY');
  static const FILTERED_RECEIPTS = WidgetWidgetTypeEnum._(r'FILTERED_RECEIPTS');

  /// List of all possible values in this [enum][WidgetWidgetTypeEnum].
  static const values = <WidgetWidgetTypeEnum>[
    GROUP_SUMMARY,
    FILTERED_RECEIPTS,
  ];

  static WidgetWidgetTypeEnum? fromJson(dynamic value) => WidgetWidgetTypeEnumTypeTransformer().decode(value);

  static List<WidgetWidgetTypeEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <WidgetWidgetTypeEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = WidgetWidgetTypeEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [WidgetWidgetTypeEnum] to String,
/// and [decode] dynamic data back to [WidgetWidgetTypeEnum].
class WidgetWidgetTypeEnumTypeTransformer {
  factory WidgetWidgetTypeEnumTypeTransformer() => _instance ??= const WidgetWidgetTypeEnumTypeTransformer._();

  const WidgetWidgetTypeEnumTypeTransformer._();

  String encode(WidgetWidgetTypeEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a WidgetWidgetTypeEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  WidgetWidgetTypeEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'GROUP_SUMMARY': return WidgetWidgetTypeEnum.GROUP_SUMMARY;
        case r'FILTERED_RECEIPTS': return WidgetWidgetTypeEnum.FILTERED_RECEIPTS;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [WidgetWidgetTypeEnumTypeTransformer] instance.
  static WidgetWidgetTypeEnumTypeTransformer? _instance;
}


