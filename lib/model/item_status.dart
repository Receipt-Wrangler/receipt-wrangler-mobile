//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class ItemStatus {
  /// Instantiate a new enum with the provided [value].
  const ItemStatus._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const OPEN = ItemStatus._(r'OPEN');
  static const RESOLVED = ItemStatus._(r'RESOLVED');
  static const DRAFT = ItemStatus._(r'DRAFT');

  /// List of all possible values in this [enum][ItemStatus].
  static const values = <ItemStatus>[
    OPEN,
    RESOLVED,
    DRAFT,
  ];

  static ItemStatus? fromJson(dynamic value) => ItemStatusTypeTransformer().decode(value);

  static List<ItemStatus>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ItemStatus>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ItemStatus.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [ItemStatus] to String,
/// and [decode] dynamic data back to [ItemStatus].
class ItemStatusTypeTransformer {
  factory ItemStatusTypeTransformer() => _instance ??= const ItemStatusTypeTransformer._();

  const ItemStatusTypeTransformer._();

  String encode(ItemStatus data) => data.value;

  /// Decodes a [dynamic value][data] to a ItemStatus.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ItemStatus? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'OPEN': return ItemStatus.OPEN;
        case r'RESOLVED': return ItemStatus.RESOLVED;
        case r'DRAFT': return ItemStatus.DRAFT;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [ItemStatusTypeTransformer] instance.
  static ItemStatusTypeTransformer? _instance;
}
