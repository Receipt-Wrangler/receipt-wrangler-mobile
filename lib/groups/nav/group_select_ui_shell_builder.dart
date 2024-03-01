import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/models/bottom_nav_model.dart';
import 'package:receipt_wrangler_mobile/shared/classes/base_ui_shell_builder.dart';

class GroupSelectUIShellBuilder implements BaseUIShellBuilder {
  static void setupBottomNav(BuildContext context, GoRouter router) {
    var provider = Provider.of<BottomNavModel>(context, listen: false);
    onDestinationSelected(int indexSelected) {
      switch (indexSelected) {
        case 0:
          router.go("/groups");
          break;
        case 1:
          router.go("/add");
          break;
        case 2:
          router.go("/search");
          break;
        default:
          router.go("/groups");
      }

      provider.setIndexSelected(indexSelected);
    }

    setIndexSelected() {
      var uri =
          GoRouter.of(context).routeInformationProvider.value.uri.toString();
      var index = 0;

      if (uri.contains("/groups")) {
        index = 0;
      } else if (uri.contains("/add")) {
        index = 1;
      } else if (uri.contains("/search")) {
        index = 2;
      }

      return index;
    }

    var destinations = const [
      NavigationDestination(
        icon: Icon(Icons.group),
        label: "Groups",
      ),
      NavigationDestination(
        icon: Icon(Icons.add),
        label: "Add",
      ),
      NavigationDestination(
        icon: Icon(Icons.search),
        label: "Search",
      ),
    ];

    provider.setBottomNavData(
        destinations, onDestinationSelected, setIndexSelected);
  }
}
