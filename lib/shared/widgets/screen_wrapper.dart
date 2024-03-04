import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/groups/nav/group_dashboard_ui_shell_builder.dart';
import 'package:receipt_wrangler_mobile/groups/nav/group_select_ui_shell_builder.dart';
import 'package:receipt_wrangler_mobile/groups/nav/receipt_ui_shell_builder.dart';
import 'package:receipt_wrangler_mobile/models/app_bar_model.dart';
import 'package:receipt_wrangler_mobile/models/group_model.dart';
import 'package:receipt_wrangler_mobile/utils/group.dart';

class ScreenWrapper extends StatefulWidget {
  const ScreenWrapper({
    super.key,
    required this.children,
    this.bottomNavigationBarWidget,
    this.appBarWidget,
    this.bodyPadding,
  });

  final List<Widget> children;

  final Widget? bottomNavigationBarWidget;

  final PreferredSizeWidget? appBarWidget;

  final EdgeInsets? bodyPadding;

  @override
  State<ScreenWrapper> createState() => _ScreenWrapper();
}

class _ScreenWrapper extends State<ScreenWrapper> {
  @override
  void initState() {
    super.initState();
    var router = GoRouter.of(context);

    router.routerDelegate.addListener(() {
      var fullPath = router.routerDelegate.currentConfiguration.fullPath;

      if (fullPath == "/groups") {
        GroupSelectUIShellBuilder.setupBottomNav(context);
        Provider.of<AppBarModel>(context, listen: false)
            .setAppBarData(titleText: "Groups");
      } else if (fullPath == "/groups/:groupId/dashboards") {
        var groupId = getGroupByIdWithRouter(router) ?? "";
        var group = Provider.of<GroupModel>(context, listen: false)
            .getGroupById(groupId);

        GroupDashboardUIShellBuilder.setupBottomNav(context);
        Provider.of<AppBarModel>(context, listen: false).setAppBarData(
            titleText: group!.name, leadingArrowRedirect: "/groups");
      } else if (fullPath == "/groups/:groupId/receipts") {
        var groupId = getGroupByIdWithRouter(router) ?? "";
        var group = Provider.of<GroupModel>(context, listen: false)
            .getGroupById(groupId);

        Provider.of<AppBarModel>(context, listen: false).setAppBarData(
            titleText: "${group!.name} Receipts",
            leadingArrowRedirect: "/groups");
      } else if (fullPath == "/receipts/:receiptId/view") {
        ReceiptUIShellBuilder.setupBottomNav(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBarWidget,
      bottomNavigationBar: widget.bottomNavigationBarWidget,
      body: Container(
          padding: widget.bodyPadding ?? const EdgeInsets.all(16),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: widget.children[0]),
    );
  }
}
