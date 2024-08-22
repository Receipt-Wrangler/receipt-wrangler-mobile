import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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

ReceiptPagedRequestFilter dashboardConfigurationToFilter(
    Map<String, dynamic> configuration) {
  //print(configuration["status"]["value"]);
  //print(configuration["status"]["operation"]);
  //print(configuration["date"]);
/*

  var test = ReceiptPagedRequestFilter(
    status: PagedRequestField(
      value: PagedRequestFieldValue.fromJson(configuration["status"]["value"]),
      operation: FilterOperation.CONTAINS,
    ),
  );

  print(test);

  return test;
  */

// TODO: fix
  return {} as dynamic;
}
