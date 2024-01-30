//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class UserRole {
  /// Instantiate a new enum with the provided [value].
  const UserRole._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const ADMIN = UserRole._(r'ADMIN');
  static const USER = UserRole._(r'USER');

  /// List of all possible values in this [enum][UserRole].
  static const values = <UserRole>[
    ADMIN,
    USER,
  ];

  static UserRole? fromJson(dynamic value) => UserRoleTypeTransformer().decode(value);

  static List<UserRole> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UserRole>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UserRole.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [UserRole] to String,
/// and [decode] dynamic data back to [UserRole].
class UserRoleTypeTransformer {
  factory UserRoleTypeTransformer() => _instance ??= const UserRoleTypeTransformer._();

  const UserRoleTypeTransformer._();

  String encode(UserRole data) => data.value;

  /// Decodes a [dynamic value][data] to a UserRole.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  UserRole? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'ADMIN': return UserRole.ADMIN;
        case r'USER': return UserRole.USER;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [UserRoleTypeTransformer] instance.
  static UserRoleTypeTransformer? _instance;
}

