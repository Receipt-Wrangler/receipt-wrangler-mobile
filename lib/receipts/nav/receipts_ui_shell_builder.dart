import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/groups/nav/receipt_ui_shell_builder.dart';
import 'package:receipt_wrangler_mobile/models/receipt_model.dart';
import 'package:receipt_wrangler_mobile/utils/forms.dart';
import 'package:receipt_wrangler_mobile/utils/receipts.dart';

import '../../models/app_bar_model.dart';

class ReceiptsUIShellBuilder {
  static void BuildShellUI(BuildContext context) {
    var router = GoRouter.of(context);
    var fullPath = router.routerDelegate.currentConfiguration.fullPath;

    if (fullPath == "/receipts/:receiptId/view") {
      ReceiptUIShellBuilder.setupBottomNav(context);
      var formState =
          getFormState(router.routeInformationProvider.value.uri.toString());
      var receipt = Provider.of<ReceiptModel>(context, listen: false).receipt;
      var groupId = receipt.groupId.toString() ?? "";

      Provider.of<AppBarModel>(context, listen: false).setAppBarData(
          titleText: getTitleText(formState, receipt.name),
          leadingArrowRedirect: "/groups/$groupId/receipts");
    }
  }
}
