//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class GroupStatus {
  /// Instantiate a new enum with the provided [value].
  const GroupStatus._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const ACTIVE = GroupStatus._(r'ACTIVE');
  static const ARCHIVED = GroupStatus._(r'ARCHIVED');

  /// List of all possible values in this [enum][GroupStatus].
  static const values = <GroupStatus>[
    ACTIVE,
    ARCHIVED,
  ];

  static GroupStatus? fromJson(dynamic value) => GroupStatusTypeTransformer().decode(value);

  static List<GroupStatus>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <GroupStatus>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = GroupStatus.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [GroupStatus] to String,
/// and [decode] dynamic data back to [GroupStatus].
class GroupStatusTypeTransformer {
  factory GroupStatusTypeTransformer() => _instance ??= const GroupStatusTypeTransformer._();

  const GroupStatusTypeTransformer._();

  String encode(GroupStatus data) => data.value;

  /// Decodes a [dynamic value][data] to a GroupStatus.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  GroupStatus? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'ACTIVE': return GroupStatus.ACTIVE;
        case r'ARCHIVED': return GroupStatus.ARCHIVED;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [GroupStatusTypeTransformer] instance.
  static GroupStatusTypeTransformer? _instance;
}

