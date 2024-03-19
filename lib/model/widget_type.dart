//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class WidgetType {
  /// Instantiate a new enum with the provided [value].
  const WidgetType._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const GROUP_SUMMARY = WidgetType._(r'GROUP_SUMMARY');
  static const FILTERED_RECEIPTS = WidgetType._(r'FILTERED_RECEIPTS');

  /// List of all possible values in this [enum][WidgetType].
  static const values = <WidgetType>[
    GROUP_SUMMARY,
    FILTERED_RECEIPTS,
  ];

  static WidgetType? fromJson(dynamic value) => WidgetTypeTypeTransformer().decode(value);

  static List<WidgetType>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <WidgetType>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = WidgetType.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [WidgetType] to String,
/// and [decode] dynamic data back to [WidgetType].
class WidgetTypeTypeTransformer {
  factory WidgetTypeTypeTransformer() => _instance ??= const WidgetTypeTypeTransformer._();

  const WidgetTypeTypeTransformer._();

  String encode(WidgetType data) => data.value;

  /// Decodes a [dynamic value][data] to a WidgetType.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  WidgetType? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'GROUP_SUMMARY': return WidgetType.GROUP_SUMMARY;
        case r'FILTERED_RECEIPTS': return WidgetType.FILTERED_RECEIPTS;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [WidgetTypeTypeTransformer] instance.
  static WidgetTypeTypeTransformer? _instance;
}

