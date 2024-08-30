//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'upsert_system_settings_command.g.dart';

/// UpsertSystemSettingsCommand
///
/// Properties:
/// * [enableLocalSignUp] - Whether local sign up is enabled
/// * [currencyDisplay] - Currency display
/// * [debugOcr] 
/// * [numWorkers] - Number of workers to use
/// * [emailPollingInterval] - Email polling interval
/// * [receiptProcessingSettingsId] - Receipt processing settings foreign key
/// * [fallbackReceiptProcessingSettingsId] - Fallback receipt processing settings foreign key
@BuiltValue()
abstract class UpsertSystemSettingsCommand implements Built<UpsertSystemSettingsCommand, UpsertSystemSettingsCommandBuilder> {
  /// Whether local sign up is enabled
  @BuiltValueField(wireName: r'enableLocalSignUp')
  bool? get enableLocalSignUp;

  /// Currency display
  @BuiltValueField(wireName: r'currencyDisplay')
  String? get currencyDisplay;

  @BuiltValueField(wireName: r'debugOcr')
  bool? get debugOcr;

  /// Number of workers to use
  @BuiltValueField(wireName: r'numWorkers')
  int? get numWorkers;

  /// Email polling interval
  @BuiltValueField(wireName: r'emailPollingInterval')
  int? get emailPollingInterval;

  /// Receipt processing settings foreign key
  @BuiltValueField(wireName: r'receiptProcessingSettingsId')
  int? get receiptProcessingSettingsId;

  /// Fallback receipt processing settings foreign key
  @BuiltValueField(wireName: r'fallbackReceiptProcessingSettingsId')
  int? get fallbackReceiptProcessingSettingsId;

  UpsertSystemSettingsCommand._();

  factory UpsertSystemSettingsCommand([void updates(UpsertSystemSettingsCommandBuilder b)]) = _$UpsertSystemSettingsCommand;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpsertSystemSettingsCommandBuilder b) => b
      ..numWorkers = 1;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpsertSystemSettingsCommand> get serializer => _$UpsertSystemSettingsCommandSerializer();
}

class _$UpsertSystemSettingsCommandSerializer implements PrimitiveSerializer<UpsertSystemSettingsCommand> {
  @override
  final Iterable<Type> types = const [UpsertSystemSettingsCommand, _$UpsertSystemSettingsCommand];

  @override
  final String wireName = r'UpsertSystemSettingsCommand';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpsertSystemSettingsCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.enableLocalSignUp != null) {
      yield r'enableLocalSignUp';
      yield serializers.serialize(
        object.enableLocalSignUp,
        specifiedType: const FullType(bool),
      );
    }
    if (object.currencyDisplay != null) {
      yield r'currencyDisplay';
      yield serializers.serialize(
        object.currencyDisplay,
        specifiedType: const FullType(String),
      );
    }
    if (object.debugOcr != null) {
      yield r'debugOcr';
      yield serializers.serialize(
        object.debugOcr,
        specifiedType: const FullType(bool),
      );
    }
    if (object.numWorkers != null) {
      yield r'numWorkers';
      yield serializers.serialize(
        object.numWorkers,
        specifiedType: const FullType(int),
      );
    }
    if (object.emailPollingInterval != null) {
      yield r'emailPollingInterval';
      yield serializers.serialize(
        object.emailPollingInterval,
        specifiedType: const FullType(int),
      );
    }
    if (object.receiptProcessingSettingsId != null) {
      yield r'receiptProcessingSettingsId';
      yield serializers.serialize(
        object.receiptProcessingSettingsId,
        specifiedType: const FullType(int),
      );
    }
    if (object.fallbackReceiptProcessingSettingsId != null) {
      yield r'fallbackReceiptProcessingSettingsId';
      yield serializers.serialize(
        object.fallbackReceiptProcessingSettingsId,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UpsertSystemSettingsCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UpsertSystemSettingsCommandBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'enableLocalSignUp':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.enableLocalSignUp = valueDes;
          break;
        case r'currencyDisplay':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.currencyDisplay = valueDes;
          break;
        case r'debugOcr':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.debugOcr = valueDes;
          break;
        case r'numWorkers':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.numWorkers = valueDes;
          break;
        case r'emailPollingInterval':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.emailPollingInterval = valueDes;
          break;
        case r'receiptProcessingSettingsId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.receiptProcessingSettingsId = valueDes;
          break;
        case r'fallbackReceiptProcessingSettingsId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.fallbackReceiptProcessingSettingsId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpsertSystemSettingsCommand deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpsertSystemSettingsCommandBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}

