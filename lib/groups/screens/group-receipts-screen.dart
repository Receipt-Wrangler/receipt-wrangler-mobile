import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/groups/widgets/group-dashboard-bottom-nav.dart';
import 'package:receipt_wrangler_mobile/models/group_model.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/screen_wrapper.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/top-app-bar.dart';
import 'package:receipt_wrangler_mobile/utils/group.dart';

class GroupReceiptsScreen extends StatefulWidget {
  const GroupReceiptsScreen({super.key});

  @override
  State<GroupReceiptsScreen> createState() => _GroupReceiptsScreen();
}

class _GroupReceiptsScreen extends State<GroupReceiptsScreen> {
  @override
  Widget build(BuildContext context) {
    var groupId = getGroupId(context);
    var groupModel = Provider.of<GroupModel>(context, listen: false);
    var group = groupModel.getGroupById(groupId ?? "");

    return ScreenWrapper(
        appBarWidget: TopAppBar(
          titleText: "${group?.name} Receipts",
          leadingArrowRedirect: "/groups/${group?.id}/dashboards",
        ),
        bottomNavigationBarWidget: const GroupDashboardBottomNav(),
        children: [Text("Hello")]);
  }
}
