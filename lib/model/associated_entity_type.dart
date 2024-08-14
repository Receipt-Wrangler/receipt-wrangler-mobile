//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class AssociatedEntityType {
  /// Instantiate a new enum with the provided [value].
  const AssociatedEntityType._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const NOOP_ENTITY_TYPE = AssociatedEntityType._(r'NOOP_ENTITY_TYPE');
  static const RECEIPT = AssociatedEntityType._(r'RECEIPT');
  static const SYSTEM_EMAIL = AssociatedEntityType._(r'SYSTEM_EMAIL');
  static const RECEIPT_PROCESSING_SETTINGS = AssociatedEntityType._(r'RECEIPT_PROCESSING_SETTINGS');
  static const PROMPT = AssociatedEntityType._(r'PROMPT');

  /// List of all possible values in this [enum][AssociatedEntityType].
  static const values = <AssociatedEntityType>[
    NOOP_ENTITY_TYPE,
    RECEIPT,
    SYSTEM_EMAIL,
    RECEIPT_PROCESSING_SETTINGS,
    PROMPT,
  ];

  static AssociatedEntityType? fromJson(dynamic value) => AssociatedEntityTypeTypeTransformer().decode(value);

  static List<AssociatedEntityType>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AssociatedEntityType>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AssociatedEntityType.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [AssociatedEntityType] to String,
/// and [decode] dynamic data back to [AssociatedEntityType].
class AssociatedEntityTypeTypeTransformer {
  factory AssociatedEntityTypeTypeTransformer() => _instance ??= const AssociatedEntityTypeTypeTransformer._();

  const AssociatedEntityTypeTypeTransformer._();

  String encode(AssociatedEntityType data) => data.value;

  /// Decodes a [dynamic value][data] to a AssociatedEntityType.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  AssociatedEntityType? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'NOOP_ENTITY_TYPE': return AssociatedEntityType.NOOP_ENTITY_TYPE;
        case r'RECEIPT': return AssociatedEntityType.RECEIPT;
        case r'SYSTEM_EMAIL': return AssociatedEntityType.SYSTEM_EMAIL;
        case r'RECEIPT_PROCESSING_SETTINGS': return AssociatedEntityType.RECEIPT_PROCESSING_SETTINGS;
        case r'PROMPT': return AssociatedEntityType.PROMPT;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [AssociatedEntityTypeTypeTransformer] instance.
  static AssociatedEntityTypeTypeTransformer? _instance;
}

