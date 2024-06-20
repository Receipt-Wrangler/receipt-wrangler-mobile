//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class SystemTaskType {
  /// Instantiate a new enum with the provided [value].
  const SystemTaskType._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const OCR_PROCESSING = SystemTaskType._(r'OCR_PROCESSING');
  static const CHAT_COMPLETION = SystemTaskType._(r'CHAT_COMPLETION');
  static const MAGIC_FILL = SystemTaskType._(r'MAGIC_FILL');
  static const QUICK_SCAN = SystemTaskType._(r'QUICK_SCAN');
  static const EMAIL_READ = SystemTaskType._(r'EMAIL_READ');
  static const EMAIL_UPLOAD = SystemTaskType._(r'EMAIL_UPLOAD');
  static const SYSTEM_EMAIL_CONNECTIVITY_CHECK = SystemTaskType._(r'SYSTEM_EMAIL_CONNECTIVITY_CHECK');
  static const RECEIPT_PROCESSING_SETTINGS_CONNECTIVITY_CHECK = SystemTaskType._(r'RECEIPT_PROCESSING_SETTINGS_CONNECTIVITY_CHECK');
  static const RECEIPT_UPLOADED = SystemTaskType._(r'RECEIPT_UPLOADED');
  static const PROMPT_GENERATED = SystemTaskType._(r'PROMPT_GENERATED');

  /// List of all possible values in this [enum][SystemTaskType].
  static const values = <SystemTaskType>[
    OCR_PROCESSING,
    CHAT_COMPLETION,
    MAGIC_FILL,
    QUICK_SCAN,
    EMAIL_READ,
    EMAIL_UPLOAD,
    SYSTEM_EMAIL_CONNECTIVITY_CHECK,
    RECEIPT_PROCESSING_SETTINGS_CONNECTIVITY_CHECK,
    RECEIPT_UPLOADED,
    PROMPT_GENERATED,
  ];

  static SystemTaskType? fromJson(dynamic value) => SystemTaskTypeTypeTransformer().decode(value);

  static List<SystemTaskType>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SystemTaskType>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SystemTaskType.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [SystemTaskType] to String,
/// and [decode] dynamic data back to [SystemTaskType].
class SystemTaskTypeTypeTransformer {
  factory SystemTaskTypeTypeTransformer() => _instance ??= const SystemTaskTypeTypeTransformer._();

  const SystemTaskTypeTypeTransformer._();

  String encode(SystemTaskType data) => data.value;

  /// Decodes a [dynamic value][data] to a SystemTaskType.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  SystemTaskType? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'OCR_PROCESSING': return SystemTaskType.OCR_PROCESSING;
        case r'CHAT_COMPLETION': return SystemTaskType.CHAT_COMPLETION;
        case r'MAGIC_FILL': return SystemTaskType.MAGIC_FILL;
        case r'QUICK_SCAN': return SystemTaskType.QUICK_SCAN;
        case r'EMAIL_READ': return SystemTaskType.EMAIL_READ;
        case r'EMAIL_UPLOAD': return SystemTaskType.EMAIL_UPLOAD;
        case r'SYSTEM_EMAIL_CONNECTIVITY_CHECK': return SystemTaskType.SYSTEM_EMAIL_CONNECTIVITY_CHECK;
        case r'RECEIPT_PROCESSING_SETTINGS_CONNECTIVITY_CHECK': return SystemTaskType.RECEIPT_PROCESSING_SETTINGS_CONNECTIVITY_CHECK;
        case r'RECEIPT_UPLOADED': return SystemTaskType.RECEIPT_UPLOADED;
        case r'PROMPT_GENERATED': return SystemTaskType.PROMPT_GENERATED;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [SystemTaskTypeTypeTransformer] instance.
  static SystemTaskTypeTypeTransformer? _instance;
}

