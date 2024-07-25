import 'package:flutter/material.dart';

class SystemSettingsModel extends ChangeNotifier {
  String currencyDisplay = '';

  String get getCurrencyDisplay => currencyDisplay;

  void setCurrencyDisplay(String currencyDisplay) {
    this.currencyDisplay = currencyDisplay;

    notifyListeners();
  }
}
