import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/api/api.dart' as api;
import 'package:receipt_wrangler_mobile/models/group_model.dart';

class GroupDashboard extends StatefulWidget {
  const GroupDashboard({super.key});

  @override
  State<GroupDashboard> createState() => _GroupDashboard();
}

class _GroupDashboard extends State<GroupDashboard> {
  int? selectedDashboardIndex;

  void onGroupTap(api.Group group) {
    context.go("/groups/${group.id}");
  }

  Widget buildDashboardPillList(List<api.Dashboard> dashboards) {
    var widgets = <Widget>[];
    for (int i = 0; i < dashboards.length; i++) {
      var dashboard = dashboards[i];
      var defaultSelected = i == 0 && selectedDashboardIndex == null;
      var selected = i == selectedDashboardIndex || defaultSelected;

      widgets.add(ChoiceChip(
        key: Key(dashboard.id.toString()),
        label: Text(dashboards[i].name),
        selected: selected,
        onSelected: (value) {
          setState(() {
            selectedDashboardIndex = i;
          });
        },
      ));
    }

    return Container(
        width: 1000,
        height: 50,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: widgets,
        ));
  }

  @override
  Widget build(BuildContext context) {
    var groupProvider = Provider.of<GroupModel>(context, listen: true);
    var groupId = GoRouterState.of(context).uri.pathSegments[1];
    var dashboardFuture =
        api.DashboardApi().getDashboardsForUserByGroupId(groupId);

    return FutureBuilder<List<api.Dashboard>?>(
      future: dashboardFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Expanded(
              child: Column(
            children: [buildDashboardPillList(snapshot.data!)],
          ));
        }

        return const CircularProgressIndicator();
      },
    );
  }
}
