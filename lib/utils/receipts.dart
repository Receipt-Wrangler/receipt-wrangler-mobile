import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:one_of/one_of.dart';
import 'package:openapi/openapi.dart';
import 'package:receipt_wrangler_mobile/enums/form_state.dart';
import 'package:receipt_wrangler_mobile/utils/forms.dart';

String? getReceiptId(BuildContext context) {
  return GoRouterState.of(context).pathParameters["receiptId"];
}

Receipt getDefaultReceipt() {
  return (ReceiptBuilder()
        ..id = 0
        ..date = DateTime.now().toIso8601String()
        ..groupId = 0
        ..paidByUserId = 0
        ..amount = "0"
        ..name = ""
        ..status = ReceiptStatus.OPEN
        ..categories = ListBuilder<Category>([])
        ..tags = ListBuilder<Tag>([]))
      .build();
}

String getTitleText(WranglerFormState formState, String receiptName) {
  return "${getFormStateHeader(formState)} $receiptName Receipt";
}

String getLeadingArrowRedirect(String groupId) {
  return "/groups/$groupId/receipts";
}

double getImagePreviewWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double getImagePreviewHeight(BuildContext context) {
  return MediaQuery.of(context).size.height * .5;
}

EdgeInsets getImageDataPadding() {
  return const EdgeInsets.all(26);
}

ReceiptPagedRequestFilterBuilder dashboardConfigurationToFilter(
    BuiltMap<String, JsonObject?>? configuration) {
  var filter = (ReceiptPagedRequestFilterBuilder());
  if (configuration == null) {
    return filter;
  }

  configuration.forEach((key, value) {
    if (value.toString().length == 0) {
      return;
    }

    switch (key) {
      case 'name':
        break;
      case 'status':
        filter.status = buildPagedRequestField(key, value);
        break;
    }
  });
  return filter;
}

PagedRequestFieldBuilder buildPagedRequestField(String key, JsonObject? value) {
  var valueMap = value!.asMap;

  FilterOperation operation = FilterOperation.empty;
  if (valueMap["operation"].toString().length > 0) {
    operation = FilterOperation.valueOf(valueMap["operation"]);
  }

  dynamic filterValue =
      (valueMap["value"] as List<dynamic>).map((e) => e.toString()).toList();
  var filterValueBuilder = (PagedRequestFieldValueBuilder());
  filterValueBuilder.oneOf =
      OneOf.fromValue7(value: filterValue, type: List<String>);

  var valueBuilder = (PagedRequestFieldBuilder()
    ..operation = operation
    ..value = filterValueBuilder);

  return valueBuilder;
}
