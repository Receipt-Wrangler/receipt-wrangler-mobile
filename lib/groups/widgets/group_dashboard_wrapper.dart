import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:receipt_wrangler_mobile/api/api.dart' as api;
import 'package:receipt_wrangler_mobile/groups/widgets/group_dashboard.dart';

class GroupDashboardWrapper extends StatefulWidget {
  const GroupDashboardWrapper({super.key});

  @override
  State<GroupDashboardWrapper> createState() => _GroupDashboardWrapper();
}

class _GroupDashboardWrapper extends State<GroupDashboardWrapper> {
  @override
  Widget build(BuildContext context) {
    var groupId = GoRouterState.of(context).uri.pathSegments[1];
    var dashboardFuture =
        api.DashboardApi().getDashboardsForUserByGroupId(groupId);

    return FutureBuilder(
        future: dashboardFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return GroupDashboard(
              dashboards: snapshot.data ?? [],
            );
          }

          return const CircularProgressIndicator();
        });
  }
}
