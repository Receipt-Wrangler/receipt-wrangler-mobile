import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/models/bottom_nav_model.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNav();
}

class _BottomNav extends State<BottomNav> {
  var indexSelected = 0;

  @override
  void initState() {
    super.initState();
  }

  Widget buildNavigationBar(BottomNavModel bottomNavModel) {
    if (bottomNavModel.destinations.length < 2) {
      return const SizedBox.shrink();
    }
    return NavigationBar(
        destinations: bottomNavModel.destinations,
        selectedIndex: bottomNavModel.indexSelected,
        onDestinationSelected: bottomNavModel.onDestinationSelected);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavModel>(
      builder: (context, bottomNavModel, child) {
        return buildNavigationBar(bottomNavModel);
      },
    );
  }
}
