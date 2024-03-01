import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/models/bottom_nav_model.dart';

void setupGroupSelectBottomNav(BuildContext context) {
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
