import 'package:flutter/material.dart';

class GroupsBottomNav extends StatefulWidget {
  const GroupsBottomNav({super.key});

  @override
  State<GroupsBottomNav> createState() => _GroupsBottomNav();
}

class _GroupsBottomNav extends State<GroupsBottomNav> {
  @override
  Widget build(BuildContext context) {
    return NavigationBar(destinations: const [
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
    ]);
  }
}
