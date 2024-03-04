import 'package:flutter/material.dart';

class AppBarModel extends ChangeNotifier {
  String titleText = "";

  String? leadingArrowRedirect = "";

  dynamic leadingArrowExtra = {};

  void setAppBarData({
    required String titleText,
    String? leadingArrowRedirect,
    dynamic leadingArrowExtra,
  }) {
    this.titleText = titleText;
    this.leadingArrowRedirect = leadingArrowRedirect;
    this.leadingArrowExtra = leadingArrowExtra;

    notifyListeners();
  }
}
