//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class SystemTaskStatus {
  /// Instantiate a new enum with the provided [value].
  const SystemTaskStatus._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const SUCCEEDED = SystemTaskStatus._(r'SUCCEEDED');
  static const FAILED = SystemTaskStatus._(r'FAILED');

  /// List of all possible values in this [enum][SystemTaskStatus].
  static const values = <SystemTaskStatus>[
    SUCCEEDED,
    FAILED,
  ];

  static SystemTaskStatus? fromJson(dynamic value) => SystemTaskStatusTypeTransformer().decode(value);

  static List<SystemTaskStatus>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SystemTaskStatus>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SystemTaskStatus.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [SystemTaskStatus] to String,
/// and [decode] dynamic data back to [SystemTaskStatus].
class SystemTaskStatusTypeTransformer {
  factory SystemTaskStatusTypeTransformer() => _instance ??= const SystemTaskStatusTypeTransformer._();

  const SystemTaskStatusTypeTransformer._();

  String encode(SystemTaskStatus data) => data.value;

  /// Decodes a [dynamic value][data] to a SystemTaskStatus.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  SystemTaskStatus? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'SUCCEEDED': return SystemTaskStatus.SUCCEEDED;
        case r'FAILED': return SystemTaskStatus.FAILED;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [SystemTaskStatusTypeTransformer] instance.
  static SystemTaskStatusTypeTransformer? _instance;
}

