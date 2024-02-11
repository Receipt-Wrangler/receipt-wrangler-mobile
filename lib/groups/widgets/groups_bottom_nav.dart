import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:receipt_wrangler_mobile/shared/widgets/bottom_nav.dart';

class GroupsBottomNav extends StatefulWidget {
  const GroupsBottomNav({super.key});

  @override
  State<GroupsBottomNav> createState() => _GroupsBottomNav();
}

class _GroupsBottomNav extends State<GroupsBottomNav> {
  var indexSelected = 0;

  void _onDestinationSelected(int indexSelected) {
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

  int _setIndexSelected() {
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

  @override
  void initState() {
    super.initState();

    _setIndexSelected();
  }

  @override
  Widget build(BuildContext context) {
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
      onDestinationSelected: _onDestinationSelected,
      getInitialSelectedIndex: _setIndexSelected,
    );
  }
}
