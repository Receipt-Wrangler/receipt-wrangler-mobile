//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class AiType {
  /// Instantiate a new enum with the provided [value].
  const AiType._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const OPEN_AI_CUSTOM = AiType._(r'OPEN_AI_CUSTOM');
  static const OPEN_AI = AiType._(r'OPEN_AI');
  static const GEMINI = AiType._(r'GEMINI');
  static const OLLAMA = AiType._(r'OLLAMA');

  /// List of all possible values in this [enum][AiType].
  static const values = <AiType>[
    OPEN_AI_CUSTOM,
    OPEN_AI,
    GEMINI,
    OLLAMA,
  ];

  static AiType? fromJson(dynamic value) => AiTypeTypeTransformer().decode(value);

  static List<AiType>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AiType>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AiType.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [AiType] to String,
/// and [decode] dynamic data back to [AiType].
class AiTypeTypeTransformer {
  factory AiTypeTypeTransformer() => _instance ??= const AiTypeTypeTransformer._();

  const AiTypeTypeTransformer._();

  String encode(AiType data) => data.value;

  /// Decodes a [dynamic value][data] to a AiType.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  AiType? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'OPEN_AI_CUSTOM': return AiType.OPEN_AI_CUSTOM;
        case r'OPEN_AI': return AiType.OPEN_AI;
        case r'GEMINI': return AiType.GEMINI;
        case r'OLLAMA': return AiType.OLLAMA;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [AiTypeTypeTransformer] instance.
  static AiTypeTypeTransformer? _instance;
}

