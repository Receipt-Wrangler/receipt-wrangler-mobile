import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  const BottomNav(
      {super.key,
      required this.destinations,
      required this.onDestinationSelected,
      required this.getInitialSelectedIndex});

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

    var initialIndex = widget.getInitialSelectedIndex();
    setState(() {
      indexSelected = initialIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: indexSelected,
      destinations: widget.destinations,
      onDestinationSelected: (index) => widget.onDestinationSelected(index),
    );
  }
}
