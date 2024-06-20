//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class OcrEngine {
  /// Instantiate a new enum with the provided [value].
  const OcrEngine._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const TESSERACT = OcrEngine._(r'TESSERACT');
  static const EASY_OCR = OcrEngine._(r'EASY_OCR');

  /// List of all possible values in this [enum][OcrEngine].
  static const values = <OcrEngine>[
    TESSERACT,
    EASY_OCR,
  ];

  static OcrEngine? fromJson(dynamic value) => OcrEngineTypeTransformer().decode(value);

  static List<OcrEngine>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <OcrEngine>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = OcrEngine.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [OcrEngine] to String,
/// and [decode] dynamic data back to [OcrEngine].
class OcrEngineTypeTransformer {
  factory OcrEngineTypeTransformer() => _instance ??= const OcrEngineTypeTransformer._();

  const OcrEngineTypeTransformer._();

  String encode(OcrEngine data) => data.value;

  /// Decodes a [dynamic value][data] to a OcrEngine.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  OcrEngine? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'TESSERACT': return OcrEngine.TESSERACT;
        case r'EASY_OCR': return OcrEngine.EASY_OCR;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [OcrEngineTypeTransformer] instance.
  static OcrEngineTypeTransformer? _instance;
}

