//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/receipt_status.dart';
import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/model/category.dart';
import 'package:openapi/src/model/tag.dart';
import 'package:openapi/src/model/comment.dart';
import 'package:openapi/src/model/file_data.dart';
import 'package:openapi/src/model/receipt.dart';
import 'package:openapi/src/model/item.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/one_of.dart';

part 'paged_data_data_inner.g.dart';

/// PagedDataDataInner
///
/// Properties:
/// * [amount] - Receipt total amount
/// * [categories] - Categories associated to receipt
/// * [comments] - Comments associated to receipt
/// * [createdAt] 
/// * [createdBy] 
/// * [date] - Receipt date
/// * [groupId] - Group foreign key
/// * [id] 
/// * [imageFiles] - Files associated to receipt
/// * [name] - Tag name
/// * [paidByUserId] - User paid foreign key
/// * [receiptItems] - Items associated to receipt
/// * [resolvedDate] - Date resolved
/// * [status] 
/// * [tags] - Tags associated to receipt
/// * [updatedAt] 
/// * [createdByString] - Created by string, which is anything that is not a user
/// * [description] - Tag description
@BuiltValue()
abstract class PagedDataDataInner implements Built<PagedDataDataInner, PagedDataDataInnerBuilder> {
  /// One Of [Category], [Receipt], [Tag]
  OneOf get oneOf;

  PagedDataDataInner._();

  factory PagedDataDataInner([void updates(PagedDataDataInnerBuilder b)]) = _$PagedDataDataInner;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PagedDataDataInnerBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PagedDataDataInner> get serializer => _$PagedDataDataInnerSerializer();
}

class _$PagedDataDataInnerSerializer implements PrimitiveSerializer<PagedDataDataInner> {
  @override
  final Iterable<Type> types = const [PagedDataDataInner, _$PagedDataDataInner];

  @override
  final String wireName = r'PagedDataDataInner';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PagedDataDataInner object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
  }

  @override
  Object serialize(
    Serializers serializers,
    PagedDataDataInner object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final oneOf = object.oneOf;
    return serializers.serialize(oneOf.value, specifiedType: FullType(oneOf.valueType))!;
  }

  @override
  PagedDataDataInner deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PagedDataDataInnerBuilder();
    Object? oneOfDataSrc;
    final targetType = const FullType(OneOf, [FullType(Receipt), FullType(Category), FullType(Tag), ]);
    oneOfDataSrc = serialized;
    result.oneOf = serializers.deserialize(oneOfDataSrc, specifiedType: targetType) as OneOf;
    return result.build();
  }
}

