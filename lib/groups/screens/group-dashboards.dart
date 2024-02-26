import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/groups/widgets/group-dashboard-bottom-nav.dart';
import 'package:receipt_wrangler_mobile/groups/widgets/group_dashboard_wrapper.dart';
import 'package:receipt_wrangler_mobile/models/group_model.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/screen_wrapper.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/top-app-bar.dart';
import 'package:receipt_wrangler_mobile/utils/group.dart';

class GroupDashboards extends StatefulWidget {
  const GroupDashboards({super.key});

  @override
  State<GroupDashboards> createState() => _GroupDashboards();
}

class _GroupDashboards extends State<GroupDashboards> {
  @override
  Widget build(BuildContext context) {
    var groupId = getGroupId(context) ?? "";
    var group =
        Provider.of<GroupModel>(context, listen: false).getGroupById(groupId);

    return ScreenWrapper(
      appBarWidget: TopAppBar(
        titleText: group!.name,
        leadingArrowRedirect: "/groups",
      ),
      bottomNavigationBarWidget: const GroupDashboardBottomNav(),
      children: const [GroupDashboardWrapper()],
    );
  }
}
