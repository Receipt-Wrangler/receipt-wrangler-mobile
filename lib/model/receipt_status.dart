//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

/// Status of a receipt
class ReceiptStatus {
  /// Instantiate a new enum with the provided [value].
  const ReceiptStatus._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const OPEN = ReceiptStatus._(r'OPEN');
  static const NEEDS_ATTENTION = ReceiptStatus._(r'NEEDS_ATTENTION');
  static const RESOLVED = ReceiptStatus._(r'RESOLVED');
  static const DRAFT = ReceiptStatus._(r'DRAFT');

  /// List of all possible values in this [enum][ReceiptStatus].
  static const values = <ReceiptStatus>[
    OPEN,
    NEEDS_ATTENTION,
    RESOLVED,
    DRAFT,
  ];

  static ReceiptStatus? fromJson(dynamic value) => ReceiptStatusTypeTransformer().decode(value);

  static List<ReceiptStatus>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ReceiptStatus>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ReceiptStatus.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [ReceiptStatus] to String,
/// and [decode] dynamic data back to [ReceiptStatus].
class ReceiptStatusTypeTransformer {
  factory ReceiptStatusTypeTransformer() => _instance ??= const ReceiptStatusTypeTransformer._();

  const ReceiptStatusTypeTransformer._();

  String encode(ReceiptStatus data) => data.value;

  /// Decodes a [dynamic value][data] to a ReceiptStatus.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ReceiptStatus? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'OPEN': return ReceiptStatus.OPEN;
        case r'NEEDS_ATTENTION': return ReceiptStatus.NEEDS_ATTENTION;
        case r'RESOLVED': return ReceiptStatus.RESOLVED;
        case r'DRAFT': return ReceiptStatus.DRAFT;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [ReceiptStatusTypeTransformer] instance.
  static ReceiptStatusTypeTransformer? _instance;
}

