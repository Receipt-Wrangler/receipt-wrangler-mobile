//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class ItemStatusEnum {
  /// Instantiate a new enum with the provided [value].
  const ItemStatusEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const OPEN = ItemStatusEnum._(r'OPEN');
  static const RESOLVED = ItemStatusEnum._(r'RESOLVED');
  static const DRAFT = ItemStatusEnum._(r'DRAFT');

  /// List of all possible values in this [enum][ItemStatusEnum].
  static const values = <ItemStatusEnum>[
    OPEN,
    RESOLVED,
    DRAFT,
  ];

  static ItemStatusEnum? fromJson(dynamic value) => ItemStatusEnumTypeTransformer().decode(value);

  static List<ItemStatusEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ItemStatusEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ItemStatusEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [ItemStatusEnum] to String,
/// and [decode] dynamic data back to [ItemStatusEnum].
class ItemStatusEnumTypeTransformer {
  factory ItemStatusEnumTypeTransformer() => _instance ??= const ItemStatusEnumTypeTransformer._();

  const ItemStatusEnumTypeTransformer._();

  String encode(ItemStatusEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a ItemStatusEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ItemStatusEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'OPEN': return ItemStatusEnum.OPEN;
        case r'RESOLVED': return ItemStatusEnum.RESOLVED;
        case r'DRAFT': return ItemStatusEnum.DRAFT;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [ItemStatusEnumTypeTransformer] instance.
  static ItemStatusEnumTypeTransformer? _instance;
}

