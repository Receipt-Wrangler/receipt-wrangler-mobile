import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/groups/nav/group_dashboard_ui_shell_builder.dart';
import 'package:receipt_wrangler_mobile/groups/nav/group_select_ui_shell_builder.dart';
import 'package:receipt_wrangler_mobile/models/app_bar_model.dart';
import 'package:receipt_wrangler_mobile/models/group_model.dart';
import 'package:receipt_wrangler_mobile/utils/group.dart';

class GroupUIShellBuilder {
  static void buildShellUI(BuildContext context) {
    var router = GoRouter.of(context);
    var fullPath = router.routerDelegate.currentConfiguration.fullPath;

    if (fullPath == "/groups") {
      GroupSelectUIShellBuilder.setupBottomNav(context);
      Provider.of<AppBarModel>(context, listen: false)
          .setAppBarData(titleText: "Groups");
    } else if (fullPath == "/groups/:groupId/dashboards") {
      var groupId = getGroupByIdWithRouter(router) ?? "";
      var group =
          Provider.of<GroupModel>(context, listen: false).getGroupById(groupId);

      GroupDashboardUIShellBuilder.setupBottomNav(context);
      Provider.of<AppBarModel>(context, listen: false).setAppBarData(
          titleText: group!.name, leadingArrowRedirect: "/groups");
    } else if (fullPath == "/groups/:groupId/receipts") {
      var groupId = getGroupByIdWithRouter(router) ?? "";
      var group =
          Provider.of<GroupModel>(context, listen: false).getGroupById(groupId);

      Provider.of<AppBarModel>(context, listen: false).setAppBarData(
          titleText: "${group!.name} Receipts",
          leadingArrowRedirect: "/groups");
    }
  }
}
