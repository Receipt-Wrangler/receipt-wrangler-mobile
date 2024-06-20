//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class AssociatedGroup {
  /// Instantiate a new enum with the provided [value].
  const AssociatedGroup._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const MINE = AssociatedGroup._(r'MINE');
  static const ALL = AssociatedGroup._(r'ALL');

  /// List of all possible values in this [enum][AssociatedGroup].
  static const values = <AssociatedGroup>[
    MINE,
    ALL,
  ];

  static AssociatedGroup? fromJson(dynamic value) => AssociatedGroupTypeTransformer().decode(value);

  static List<AssociatedGroup>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AssociatedGroup>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AssociatedGroup.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [AssociatedGroup] to String,
/// and [decode] dynamic data back to [AssociatedGroup].
class AssociatedGroupTypeTransformer {
  factory AssociatedGroupTypeTransformer() => _instance ??= const AssociatedGroupTypeTransformer._();

  const AssociatedGroupTypeTransformer._();

  String encode(AssociatedGroup data) => data.value;

  /// Decodes a [dynamic value][data] to a AssociatedGroup.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  AssociatedGroup? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'MINE': return AssociatedGroup.MINE;
        case r'ALL': return AssociatedGroup.ALL;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [AssociatedGroupTypeTransformer] instance.
  static AssociatedGroupTypeTransformer? _instance;
}

