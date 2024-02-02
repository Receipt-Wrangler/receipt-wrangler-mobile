import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GroupsBottomNav extends StatefulWidget {
  const GroupsBottomNav({super.key});

  @override
  State<GroupsBottomNav> createState() => _GroupsBottomNav();
}

class _GroupsBottomNav extends State<GroupsBottomNav> {
  var indexSelected = 0;

  void _navigateToGroupSelect(int indexSelected) {
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

  void _setIndexSelected() {
    var uri =
        GoRouter.of(context).routeInformationProvider.value.uri.toString();
    var index = 0;

    print(uri);

    if (uri.contains("/groups")) {
      index = 0;
    } else if (uri.contains("/add")) {
      index = 1;
    } else if (uri.contains("/search")) {
      index = 2;
    }

    setState(() {
      indexSelected = index;
    });
  }

  @override
  void initState() {
    super.initState();

    _setIndexSelected();
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: indexSelected,
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
      onDestinationSelected: (index) => _navigateToGroupSelect(index),
    );
  }
}
