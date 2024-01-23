import 'package:flutter/material.dart';

class LayoutModel extends ChangeNotifier {
  bool _displayAppBar = false;

  String _appBarTitle = "Receipt Wrangler";

  bool get displayAppBar => _displayAppBar;

  String get appBarTitle => _appBarTitle;

  void setDisplayAppBar(bool displayAppBar) {
    _displayAppBar = displayAppBar;

    notifyListeners();
  }

  void setAppBarTitle(String appBarTitle) {
    _appBarTitle = appBarTitle;

    notifyListeners();
  }
}
