import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/groups/widgets/group-dashboard-bottom-nav.dart';
import 'package:receipt_wrangler_mobile/groups/widgets/group_app_bar.dart';
import 'package:receipt_wrangler_mobile/groups/widgets/group_dashboard_wrapper.dart';
import 'package:receipt_wrangler_mobile/models/group_model.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/screen_wrapper.dart';

class GroupHome extends StatefulWidget {
  const GroupHome({super.key});

  @override
  State<GroupHome> createState() => _GroupHome();
}

class _GroupHome extends State<GroupHome> {
  @override
  Widget build(BuildContext context) {
    var segments = GoRouterState.of(context).uri.pathSegments;
    var groupId = segments[1];
    var group =
        Provider.of<GroupModel>(context, listen: false).getGroupById(groupId);

    return ScreenWrapper(
      appBarWidget: GroupAppBar(
          titleText: group!.name,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              context.go("/groups");
            },
          )),
      bottomNavigationBarWidget: const GroupDashboardBottomNav(),
      children: const [GroupDashboardWrapper()],
    );
  }
}
