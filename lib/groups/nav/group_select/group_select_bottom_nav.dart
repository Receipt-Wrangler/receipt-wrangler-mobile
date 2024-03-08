import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/bottom_nav.dart';

class GroupSelectBottomNav extends StatefulWidget {
  const GroupSelectBottomNav({super.key});

  @override
  State<GroupSelectBottomNav> createState() => _GroupSelectBottomNav();
}

class _GroupSelectBottomNav extends State<GroupSelectBottomNav> {
  @override
  Widget build(BuildContext context) {
    onDestinationSelected(int indexSelected) {
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
        default:
          context.go("/groups");
      }
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

    return BottomNav(
      destinations: const [
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
      ],
      onDestinationSelected: onDestinationSelected,
      getInitialSelectedIndex: setIndexSelected,
    );
  }
}
