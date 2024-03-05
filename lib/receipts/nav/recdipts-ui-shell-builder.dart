import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:receipt_wrangler_mobile/groups/nav/receipt_ui_shell_builder.dart';

class ReceiptsUIShellBuilder {
  static void BuildShellUI(BuildContext context) {
    var router = GoRouter.of(context);
    var fullPath = router.routerDelegate.currentConfiguration.fullPath;

    if (fullPath == "/receipts/:receiptId/view") {
      ReceiptUIShellBuilder.setupBottomNav(context);
    }
  }
}
