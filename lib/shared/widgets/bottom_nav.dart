import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  const BottomNav(
      {super.key,
      required this.destinations,
      required this.getInitialSelectedIndex,
      required this.onDestinationSelected});

  final List<NavigationDestination> destinations;

  final void Function(int) onDestinationSelected;

  final int Function() getInitialSelectedIndex;

  @override
  State<BottomNav> createState() => _BottomNav();
}

class _BottomNav extends State<BottomNav> {
  var indexSelected = 0;

  @override
  void initState() {
    super.initState();
    indexSelected = widget.getInitialSelectedIndex();
  }

  Widget buildNavigationBar() {
    return NavigationBar(
      destinations: widget.destinations,
      onDestinationSelected: widget.onDestinationSelected,
      selectedIndex: indexSelected,
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildNavigationBar();
  }
}
