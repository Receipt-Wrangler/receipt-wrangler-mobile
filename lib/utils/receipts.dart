import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:receipt_wrangler_mobile/api/api.dart';

String? getReceiptId(BuildContext context) {
  return GoRouterState.of(context).pathParameters["receiptId"];
}

Receipt getDefaultReceipt() {
  return Receipt(
    id: 0,
    date: DateTime.now().toIso8601String(),
    groupId: 0,
    paidByUserId: 0,
    amount: "0",
    name: "",
    status: ReceiptStatus.OPEN,
  );
}
