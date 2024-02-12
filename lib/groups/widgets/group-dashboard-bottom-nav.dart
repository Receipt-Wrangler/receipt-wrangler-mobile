import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/bottom_nav.dart';
import 'package:receipt_wrangler_mobile/utils/group.dart';

class GroupDashboardBottomNav extends StatefulWidget {
  const GroupDashboardBottomNav({super.key});

  @override
  State<GroupDashboardBottomNav> createState() => _GroupDashboardBottomNav();
}

class _GroupDashboardBottomNav extends State<GroupDashboardBottomNav> {
  var indexSelected = 0;

  void _onDestinationSelected(int indexSelected) {
    var groupId = getGroupId(context);
    switch (indexSelected) {
      case 0:
        context.go("/groups");
        break;
      case 1:
        context.go("/add");
        break;
      case 2:
        context.go("/search");
        break;
      case 3:
        context.go("/groups/$groupId/receipts");
        break;
      default:
        context.go("/groups");
    }
  }

  int _setIndexSelected() {
    var uri =
        GoRouter.of(context).routeInformationProvider.value.uri.toString();
    var groupId = getGroupId(context);
    var index = 0;

    if (uri == "/groups/$groupId/dashboards") {
      index = 0;
    } else if (uri.contains("/add")) {
      index = 1;
    } else if (uri.contains("/search")) {
      index = 2;
    }

    return index;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomNav(
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.dashboard),
          label: "Dashboards",
        ),
        NavigationDestination(
          icon: Icon(Icons.add),
          label: "Add",
        ),
        NavigationDestination(
          icon: Icon(Icons.search),
          label: "Search",
        ),
        NavigationDestination(
          icon: Icon(Icons.receipt),
          label: "Receipts",
        ),
      ],
      onDestinationSelected: _onDestinationSelected,
      getInitialSelectedIndex: _setIndexSelected,
    );
  }
}
