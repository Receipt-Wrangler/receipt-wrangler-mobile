import 'package:flutter/material.dart';
import 'package:receipt_wrangler_mobile/api/api.dart';

class UserModel extends ChangeNotifier {
  List<UserView> _users = [];
  List<UserView> get users => _users;

  void setUsers(List<UserView> users) {
    _users = users;

    notifyListeners();
  }
}
