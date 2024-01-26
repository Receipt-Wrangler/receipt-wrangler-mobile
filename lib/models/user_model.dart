import 'package:flutter/material.dart';
import 'package:receipt_wrangler_mobile/api/api.dart';

class UserModel extends ChangeNotifier {
  List<User> _users = [];
  List<User> get users => _users;

  void setUsers(List<User> users) {
    _users = users;

    notifyListeners();
  }
}
