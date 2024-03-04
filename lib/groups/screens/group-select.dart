import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/groups/widgets/group_list.dart';
import 'package:receipt_wrangler_mobile/models/bottom_nav_model.dart';

class GroupSelect extends StatefulWidget {
  const GroupSelect({super.key});

  @override
  State<GroupSelect> createState() => _GroupSelect();
}

class _GroupSelect extends State<GroupSelect> {
  void setUpBottomNav() {
    var provider = Provider.of<BottomNavModel>(context, listen: false);
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

    provider.setBottomNavData(destinations, (p0) {}, () => 0);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const GroupList();
  }
}
