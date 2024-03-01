import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/models/bottom_nav_model.dart';
import 'package:receipt_wrangler_mobile/shared/classes/base_ui_shell_builder.dart';
import 'package:receipt_wrangler_mobile/utils/group.dart';

class GroupDashboardUIShellBuilder implements BaseUIShellBuilder {
  static void setupBottomNav(BuildContext context, GoRouter router) {
    var provider = Provider.of<BottomNavModel>(context, listen: false);

    onDestinationSelected(int indexSelected) {
      var groupId = getGroupByIdWithRouter(router);

      switch (indexSelected) {
        case 0:
          router.go("/groups/$groupId/dashboards");
          break;
        case 1:
          router.go("/add");
          break;
        case 2:
          router.go("/search");
          break;
        case 3:
          router.go("/groups/$groupId/receipts");
          break;
        default:
          router.go("/groups");
      }
    }

    setIndexSelected() {
      var uri =
          GoRouter.of(context).routeInformationProvider.value.uri.toString();
      var index = 0;

      if (uri.contains("dashboards")) {
        index = 0;
      } else if (uri.contains("/add")) {
        index = 1;
      } else if (uri.contains("/search")) {
        index = 2;
      } else if (uri.contains("receipts")) {
        index = 3;
      }

      return index;
    }

    var destinations = const [
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
    ];

    provider.setBottomNavData(
        destinations, onDestinationSelected, setIndexSelected);
  }
}
