import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:receipt_wrangler_mobile/receipts/widgets/receipt_form.dart';

Widget buildReceiptFormRoute(BuildContext context, GoRouterState state) {
  return SingleChildScrollView(child: const ReceiptForm());
}
