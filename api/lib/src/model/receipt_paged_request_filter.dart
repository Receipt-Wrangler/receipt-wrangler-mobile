//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/paged_request_field.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'receipt_paged_request_filter.g.dart';

/// ReceiptPagedRequestFilter
///
/// Properties:
/// * [date] 
/// * [amount] 
/// * [name] 
/// * [paidBy] 
/// * [categories] 
/// * [tags] 
/// * [status] 
/// * [resolvedDate] 
/// * [createdAt] 
@BuiltValue()
abstract class ReceiptPagedRequestFilter implements Built<ReceiptPagedRequestFilter, ReceiptPagedRequestFilterBuilder> {
  @BuiltValueField(wireName: r'date')
  PagedRequestField? get date;

  @BuiltValueField(wireName: r'amount')
  PagedRequestField? get amount;

  @BuiltValueField(wireName: r'name')
  PagedRequestField? get name;

  @BuiltValueField(wireName: r'paidBy')
  PagedRequestField? get paidBy;

  @BuiltValueField(wireName: r'categories')
  PagedRequestField? get categories;

  @BuiltValueField(wireName: r'tags')
  PagedRequestField? get tags;

  @BuiltValueField(wireName: r'status')
  PagedRequestField? get status;

  @BuiltValueField(wireName: r'resolvedDate')
  PagedRequestField? get resolvedDate;

  @BuiltValueField(wireName: r'createdAt')
  PagedRequestField? get createdAt;

  ReceiptPagedRequestFilter._();

  factory ReceiptPagedRequestFilter([void updates(ReceiptPagedRequestFilterBuilder b)]) = _$ReceiptPagedRequestFilter;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ReceiptPagedRequestFilterBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ReceiptPagedRequestFilter> get serializer => _$ReceiptPagedRequestFilterSerializer();
}

class _$ReceiptPagedRequestFilterSerializer implements PrimitiveSerializer<ReceiptPagedRequestFilter> {
  @override
  final Iterable<Type> types = const [ReceiptPagedRequestFilter, _$ReceiptPagedRequestFilter];

  @override
  final String wireName = r'ReceiptPagedRequestFilter';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ReceiptPagedRequestFilter object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.date != null) {
      yield r'date';
      yield serializers.serialize(
        object.date,
        specifiedType: const FullType(PagedRequestField),
      );
    }
    if (object.amount != null) {
      yield r'amount';
      yield serializers.serialize(
        object.amount,
        specifiedType: const FullType(PagedRequestField),
      );
    }
    if (object.name != null) {
      yield r'name';
      yield serializers.serialize(
        object.name,
        specifiedType: const FullType(PagedRequestField),
      );
    }
    if (object.paidBy != null) {
      yield r'paidBy';
      yield serializers.serialize(
        object.paidBy,
        specifiedType: const FullType(PagedRequestField),
      );
    }
    if (object.categories != null) {
      yield r'categories';
      yield serializers.serialize(
        object.categories,
        specifiedType: const FullType(PagedRequestField),
      );
    }
    if (object.tags != null) {
      yield r'tags';
      yield serializers.serialize(
        object.tags,
        specifiedType: const FullType(PagedRequestField),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(PagedRequestField),
      );
    }
    if (object.resolvedDate != null) {
      yield r'resolvedDate';
      yield serializers.serialize(
        object.resolvedDate,
        specifiedType: const FullType(PagedRequestField),
      );
    }
    if (object.createdAt != null) {
      yield r'createdAt';
      yield serializers.serialize(
        object.createdAt,
        specifiedType: const FullType(PagedRequestField),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ReceiptPagedRequestFilter object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ReceiptPagedRequestFilterBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PagedRequestField),
          ) as PagedRequestField;
          result.date.replace(valueDes);
          break;
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PagedRequestField),
          ) as PagedRequestField;
          result.amount.replace(valueDes);
          break;
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PagedRequestField),
          ) as PagedRequestField;
          result.name.replace(valueDes);
          break;
        case r'paidBy':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PagedRequestField),
          ) as PagedRequestField;
          result.paidBy.replace(valueDes);
          break;
        case r'categories':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PagedRequestField),
          ) as PagedRequestField;
          result.categories.replace(valueDes);
          break;
        case r'tags':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PagedRequestField),
          ) as PagedRequestField;
          result.tags.replace(valueDes);
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PagedRequestField),
          ) as PagedRequestField;
          result.status.replace(valueDes);
          break;
        case r'resolvedDate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PagedRequestField),
          ) as PagedRequestField;
          result.resolvedDate.replace(valueDes);
          break;
        case r'createdAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PagedRequestField),
          ) as PagedRequestField;
          result.createdAt.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ReceiptPagedRequestFilter deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ReceiptPagedRequestFilterBuilder();
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

