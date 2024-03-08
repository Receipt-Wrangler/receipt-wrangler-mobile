import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/groups/nav/group_ui_shell_builder.dart';
import 'package:receipt_wrangler_mobile/models/app_bar_model.dart';
import 'package:receipt_wrangler_mobile/models/bottom_nav_model.dart';
import 'package:receipt_wrangler_mobile/receipts/nav/receipts_ui_shell_builder.dart';

void handleShellUIUpdate(BuildContext context, {String? fullPath}) {
  var router = GoRouter.of(context);
  var fullPath = router.routerDelegate.currentConfiguration.fullPath;

  if (fullPath.contains("/groups")) {
    GroupUIShellBuilder.buildShellUI(context);
  } else if (fullPath.contains("/receipts")) {
    ReceiptsUIShellBuilder.BuildShellUI(context);
  } else {
    var bottomNavModel = Provider.of<BottomNavModel>(context, listen: false);
    var appBarModel = Provider.of<AppBarModel>(context, listen: false);

    bottomNavModel.setBottomNavData([], (int index) {}, () => 0);
    appBarModel.setAppBarData(titleText: "");
  }
}
