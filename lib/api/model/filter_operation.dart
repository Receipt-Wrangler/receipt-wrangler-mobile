//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class FilterOperation {
  /// Instantiate a new enum with the provided [value].
  const FilterOperation._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const CONTAINS = FilterOperation._(r'CONTAINS');
  static const EQUALS = FilterOperation._(r'EQUALS');
  static const GREATER_THAN = FilterOperation._(r'GREATER_THAN');
  static const LESS_THAN = FilterOperation._(r'LESS_THAN');

  /// List of all possible values in this [enum][FilterOperation].
  static const values = <FilterOperation>[
    CONTAINS,
    EQUALS,
    GREATER_THAN,
    LESS_THAN,
  ];

  static FilterOperation? fromJson(dynamic value) => FilterOperationTypeTransformer().decode(value);

  static List<FilterOperation> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <FilterOperation>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = FilterOperation.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [FilterOperation] to String,
/// and [decode] dynamic data back to [FilterOperation].
class FilterOperationTypeTransformer {
  factory FilterOperationTypeTransformer() => _instance ??= const FilterOperationTypeTransformer._();

  const FilterOperationTypeTransformer._();

  String encode(FilterOperation data) => data.value;

  /// Decodes a [dynamic value][data] to a FilterOperation.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  FilterOperation? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'CONTAINS': return FilterOperation.CONTAINS;
        case r'EQUALS': return FilterOperation.EQUALS;
        case r'GREATER_THAN': return FilterOperation.GREATER_THAN;
        case r'LESS_THAN': return FilterOperation.LESS_THAN;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [FilterOperationTypeTransformer] instance.
  static FilterOperationTypeTransformer? _instance;
}

