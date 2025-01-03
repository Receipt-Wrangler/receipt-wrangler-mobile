//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/group_role.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'upsert_group_member_command.g.dart';

/// UpsertGroupMemberCommand
///
/// Properties:
/// * [groupId] - Group compound primary key
/// * [groupRole] 
/// * [userId] - User compound primary key
@BuiltValue()
abstract class UpsertGroupMemberCommand implements Built<UpsertGroupMemberCommand, UpsertGroupMemberCommandBuilder> {
  /// Group compound primary key
  @BuiltValueField(wireName: r'groupId')
  int get groupId;

  @BuiltValueField(wireName: r'groupRole')
  GroupRole get groupRole;
  // enum groupRoleEnum {  OWNER,  VIEWER,  EDITOR,  };

  /// User compound primary key
  @BuiltValueField(wireName: r'userId')
  int get userId;

  UpsertGroupMemberCommand._();

  factory UpsertGroupMemberCommand([void updates(UpsertGroupMemberCommandBuilder b)]) = _$UpsertGroupMemberCommand;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpsertGroupMemberCommandBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpsertGroupMemberCommand> get serializer => _$UpsertGroupMemberCommandSerializer();
}

class _$UpsertGroupMemberCommandSerializer implements PrimitiveSerializer<UpsertGroupMemberCommand> {
  @override
  final Iterable<Type> types = const [UpsertGroupMemberCommand, _$UpsertGroupMemberCommand];

  @override
  final String wireName = r'UpsertGroupMemberCommand';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpsertGroupMemberCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'groupId';
    yield serializers.serialize(
      object.groupId,
      specifiedType: const FullType(int),
    );
    yield r'groupRole';
    yield serializers.serialize(
      object.groupRole,
      specifiedType: const FullType(GroupRole),
    );
    yield r'userId';
    yield serializers.serialize(
      object.userId,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    UpsertGroupMemberCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UpsertGroupMemberCommandBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'groupId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.groupId = valueDes;
          break;
        case r'groupRole':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(GroupRole),
          ) as GroupRole;
          result.groupRole = valueDes;
          break;
        case r'userId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.userId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpsertGroupMemberCommand deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpsertGroupMemberCommandBuilder();
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

