//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class FilterOperations {
  /// Instantiate a new enum with the provided [value].
  const FilterOperations._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const CONTAINS = FilterOperations._(r'CONTAINS');
  static const EQUALS = FilterOperations._(r'EQUALS');
  static const GREATER_THAN = FilterOperations._(r'GREATER_THAN');
  static const LESS_THAN = FilterOperations._(r'LESS_THAN');

  /// List of all possible values in this [enum][FilterOperations].
  static const values = <FilterOperations>[
    CONTAINS,
    EQUALS,
    GREATER_THAN,
    LESS_THAN,
  ];

  static FilterOperations? fromJson(dynamic value) => FilterOperationsTypeTransformer().decode(value);

  static List<FilterOperations> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <FilterOperations>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = FilterOperations.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [FilterOperations] to String,
/// and [decode] dynamic data back to [FilterOperations].
class FilterOperationsTypeTransformer {
  factory FilterOperationsTypeTransformer() => _instance ??= const FilterOperationsTypeTransformer._();

  const FilterOperationsTypeTransformer._();

  String encode(FilterOperations data) => data.value;

  /// Decodes a [dynamic value][data] to a FilterOperations.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  FilterOperations? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'CONTAINS': return FilterOperations.CONTAINS;
        case r'EQUALS': return FilterOperations.EQUALS;
        case r'GREATER_THAN': return FilterOperations.GREATER_THAN;
        case r'LESS_THAN': return FilterOperations.LESS_THAN;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [FilterOperationsTypeTransformer] instance.
  static FilterOperationsTypeTransformer? _instance;
}

