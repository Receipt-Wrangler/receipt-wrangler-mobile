//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'widget_type.g.dart';

class WidgetType extends EnumClass {

  @BuiltValueEnumConst(wireName: r'GROUP_SUMMARY')
  static const WidgetType GROUP_SUMMARY = _$GROUP_SUMMARY;
  @BuiltValueEnumConst(wireName: r'FILTERED_RECEIPTS')
  static const WidgetType FILTERED_RECEIPTS = _$FILTERED_RECEIPTS;
  @BuiltValueEnumConst(wireName: r'GROUP_ACTIVITY')
  static const WidgetType GROUP_ACTIVITY = _$GROUP_ACTIVITY;

  static Serializer<WidgetType> get serializer => _$widgetTypeSerializer;

  const WidgetType._(String name): super(name);

  static BuiltSet<WidgetType> get values => _$values;
  static WidgetType valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class WidgetTypeMixin = Object with _$WidgetTypeMixin;

