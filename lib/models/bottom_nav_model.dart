import 'package:flutter/material.dart';

class BottomNavModel extends ChangeNotifier {
  List<NavigationDestination> destinations = [];

  void Function(int) onDestinationSelected = (int index) {};

  int Function() getInitialSelectedIndex = () => 0;

  var indexSelected = 0;

  setBottomNavData(
      List<NavigationDestination> destinations,
      void Function(int) onDestinationSelected,
      int Function() getInitialSelectedIndex) {
    this.destinations = destinations;
    this.onDestinationSelected = onDestinationSelected;
    this.getInitialSelectedIndex = getInitialSelectedIndex;
    notifyListeners();
  }

  void setIndexSelected(int index) {
    indexSelected = index;
    notifyListeners();
  }
}
