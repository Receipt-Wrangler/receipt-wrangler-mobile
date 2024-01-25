import 'package:flutter/material.dart';

class ServerModel extends ChangeNotifier {
  String _basePath = "";

  String get basePath => _basePath;

  void setBasePath(String basePath) {
    _basePath = basePath;

    notifyListeners();
  }
}
